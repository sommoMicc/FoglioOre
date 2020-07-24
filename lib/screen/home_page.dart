import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/screen/pdf_preview.dart';
import 'package:foglio_ore/utils/data_provider.dart';
import 'package:foglio_ore/utils/pdf_utils.dart';
import 'package:foglio_ore/widget/card_lavoro_container.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void ricaricaDatiCalendario() =>
      Provider.of<GlobalAppState>(context, listen: false).dati =
          DataProvider.getListaLavoriMese(
              Provider.of<DateTimeAppState>(context, listen: false)
                  .dataCorrente
                  .year,
              Provider.of<DateTimeAppState>(context, listen: false)
                  .dataCorrente
                  .month);

  void _daySelectedCallback(DateTime selectedDay, List<dynamic> events) {
    if (selectedDay.month !=
        Provider.of<DateTimeAppState>(context, listen: false)
            .dataCorrente
            .month) {
      Provider.of<DateTimeAppState>(context, listen: false).dataCorrente =
          DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
      print("Ricarico dati");
      ricaricaDatiCalendario();
    } else {
      print("Data selezionata: " + selectedDay.toString());
      Provider.of<DateTimeAppState>(context, listen: false).dataCorrente =
          DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foglio ore"),
        actions: <Widget>[
          // action button
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async {
              _showLoadingDialog();
              var pdfFile = await PDFUtils.generatePDF(
                  Provider.of<GlobalAppState>(context, listen: false).dati);
              Navigator.of(context).pop(); //Nascondo la dialog
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PDFPreview(pdfFile)));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TableCalendar(
              locale: 'it_IT',
              startingDayOfWeek: StartingDayOfWeek.monday,
              availableGestures: AvailableGestures.none,
              calendarController: _calendarController,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              initialSelectedDay:
                  DateTime(DateTime.now().year, DateTime.now().month, 1),
              onDaySelected: _daySelectedCallback,
            ),
            CardLavoroContainer(Provider.of<GlobalAppState>(context)
                .dati[Provider.of<DateTimeAppState>(context).dataCorrente])
          ],
        ),
      ),
    );
  }

  Future<void> _showLoadingDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Creazione foglio ore in corso'),
          content: SingleChildScrollView(
            child: Container(
              child: SizedBox(
                height: 80,
                child: SpinKitSquareCircle(
                  color: Theme.of(context).primaryColor,
                  size: 50.0,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
