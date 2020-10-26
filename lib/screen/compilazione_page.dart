import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/screen/pdf_preview.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/data_provider.dart';
import 'package:foglio_ore/utils/pdf_utils.dart';
import 'package:foglio_ore/widget/card_lavoro_container.dart';
import 'package:foglio_ore/widget/circle_icon_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CompilazionePage extends StatefulWidget {
  @override
  _CompilazionePageState createState() => _CompilazionePageState();
}

class _CompilazionePageState extends State<CompilazionePage> {
  CalendarController _calendarController;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();

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
    /*
    final dati = Provider.of<GlobalAppState>(context).dati;
    for (var key in dati.keys) {
      print("dati[$key] = ${dati[key]}");
    }
    print(
        "Data corrente: ${Provider.of<DateTimeAppState>(context).dataCorrente}");
    */
    return Scaffold(
      key: _scaffoldState,
      backgroundColor: AppColors.defaultBackground,
      appBar: AppBar(
        title: Text("Foglio ore"),
        actions: <Widget>[
          // action button
          CircleIconButton(
            icon: Icons.check,
            onPressed: () async {
              _showLoadingDialog();

              // Salvo foglio ore
              await DataProvider.salvaFoglioOre(
                  Provider.of<GlobalAppState>(context, listen: false));

              var pdfFile = await PDFUtils.generatePDF(
                  Provider.of<GlobalAppState>(context, listen: false).dati);
              Navigator.of(context).pop(); //Nascondo la dialog
              bool result = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PDFPreview(pdfFile))) ??
                  false;

              _scaffoldState.currentState.showSnackBar(
                SnackBar(
                  content: Row(
                    children: <Widget>[
                      Icon(result ? Icons.email : Icons.error),
                      SizedBox(width: 10),
                      Text(result
                          ? "Foglio ore inviato con successo"
                          : "Errore nell'invio del foglio ore"),
                    ],
                  ),
                  backgroundColor: result ? Colors.green[700] : Colors.red[700],
                ),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: <Widget>[
              TableCalendar(
                locale: 'it_IT',
                startingDayOfWeek: StartingDayOfWeek.monday,
                availableGestures: AvailableGestures.none,
                calendarController: _calendarController,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleTextStyle: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  titleTextBuilder: (DateTime data, locale) =>
                      DateFormat.yMMMMd(locale).format(data).toUpperCase(),
                  centerHeaderTitle: true,
                ),
                initialSelectedDay:
                    Provider.of<GlobalAppState>(context).dati.keys.first,
                onDaySelected: _daySelectedCallback,
                calendarStyle: CalendarStyle(
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.defaultText,
                  ),
                  selectedColor: AppColors.primary,
                  todayStyle: TextStyle(
                    color: AppColors.defaultText,
                  ),
                  todayColor: AppColors.accent.withOpacity(.6),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CardLavoroContainer(Provider.of<GlobalAppState>(context)
                  .dati[Provider.of<DateTimeAppState>(context).dataCorrente])
            ],
          ),
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
