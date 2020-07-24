import 'dart:async' show Future;

import 'package:flutter/services.dart' show rootBundle;
import 'package:foglio_ore/model/cantiere.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/utils/utils.dart';

class DataProvider {
  static Map<DateTime, List<Lavoro>> getListaLavoriMese(int year, int month) {
    int giorniDelMese = getGiorniDelMese(year, month);
    Map<DateTime, List<Lavoro>> nuoviDati = {};

    DateTime dataDiPartenza = DateTime(year, month, 0);

    for (int i = 0; i < giorniDelMese; i++) {
      dataDiPartenza = dataDiPartenza.add(Duration(days: 1));

      bool giornoLavorativo = !(dataDiPartenza.weekday > 5);

      nuoviDati[dataDiPartenza] = [
        Lavoro(
          cantiere: Cantiere.Confindustria,
          lavorato: giornoLavorativo,
        ),
        Lavoro(
          cantiere: Cantiere.Assimoco,
          lavorato: giornoLavorativo &&
              dataDiPartenza.weekday % 2 == 0, //Solo martedì e giovedì
        )
      ];
    }

    return nuoviDati;
  }

  static Future<String> loadGlobalTemplate() async {
    return await rootBundle.loadString('assets/template.html');
  }

  static Future<String> loadRowTemplate() async {
    return await rootBundle.loadString('assets/row_template.html');
  }
}
