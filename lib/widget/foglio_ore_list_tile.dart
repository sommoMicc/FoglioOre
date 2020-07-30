import 'package:flutter/material.dart';
import 'package:foglio_ore/model/cantiere.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/screen/compilazione_page.dart';
import 'package:foglio_ore/screen/pdf_preview.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/pdf_utils.dart';
import 'package:foglio_ore/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FoglioOreListTile extends StatelessWidget {
  final GlobalAppState foglioOre;
  final int index;

  FoglioOreListTile(this.foglioOre, this.index);

  @override
  Widget build(BuildContext context) {
    DateTime dataFoglio = foglioOre.dati.keys.first;

    List<Widget> cantieri = [];

    for (Cantiere c in Cantiere.values) {
      cantieri.add(_creaWidgetCantiere(c, foglioOre.dati));
    }

    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      color: AppColors.cardColors[index % 2].background,
      child: Column(
        children: [
          ListTile(
            title: Text(
                DateFormat.yMMMM('it_IT').format(dataFoglio).toUpperCase()),
            leading: Text(DateFormat.yM('it_IT').format(dataFoglio)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cantieri,
            ),
          ),
          ButtonBar(
            mainAxisSize: MainAxisSize.max,
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton.icon(
                color: AppColors.primary,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () async {
                  _setAppState(context);
                  var pdf = await PDFUtils.generatePDF(foglioOre.dati);

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => PDFPreview(pdf)));
                },
                icon: Icon(Icons.picture_as_pdf),
                label: Text("Visualizza"),
              ),
              FlatButton.icon(
                color: AppColors.accent,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                onPressed: () {
                  _setAppState(context);

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CompilazionePage()));
                },
                icon: Icon(Icons.edit),
                label: Text("Modifica"),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _setAppState(context) {
    Provider.of<DateTimeAppState>(context, listen: false).dataCorrente =
        foglioOre.dati.keys.first;

    Provider.of<GlobalAppState>(context, listen: false).dati = foglioOre.dati;
  }

  static Widget _creaWidgetCantiere(
      Cantiere cantiere, Map<DateTime, List<Lavoro>> dati) {
    int currentYear = dati.keys.first.year;
    int currentMonth = dati.keys.first.month;

    int totaleMinuti = 0;

    for (int i = 1; i <= getGiorniDelMese(currentYear, currentMonth); i++) {
      Lavoro lavoroOdierno =
          dati[DateTime(currentYear, currentMonth, i)][cantiere.index];

      if (lavoroOdierno.lavorato) {
        totaleMinuti += lavoroOdierno.minutiLavorati;
      }
    }

    String nomeCantiere = cantiere.toString().split(".").last;
    return Text("$nomeCantiere: ${minutiToOrario(totaleMinuti)} ore");
  }
}
