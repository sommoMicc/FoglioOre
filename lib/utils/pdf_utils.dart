import 'dart:io';

import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:foglio_ore/model/cantiere.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/data_provider.dart';
import 'package:foglio_ore/utils/utils.dart';
import 'package:path_provider/path_provider.dart';

class PDFUtils {
  static Future<File> generatePDF(Map<DateTime, List<Lavoro>> dati) async {
    String globalTemplate = await DataProvider.loadGlobalTemplate();
    String rowTemplate = await DataProvider.loadRowTemplate();

    String cantieri = "";

    for (Cantiere c in Cantiere.values) {
      cantieri += _parseRowTemplate(rowTemplate, c, dati);
    }

    String finalHTML = globalTemplate
        .replaceAll("[CANTIERI]", cantieri)
        .replaceAll("[anno]", dati.keys.first.year.toString())
        .replaceAll("[mese]", MESI[dati.keys.first.month - 1]);

    Directory appDocDir = await getTemporaryDirectory();
    String pdfStorageDirectory = appDocDir.path;
    print("Directory del pdf: $pdfStorageDirectory");

    return await FlutterHtmlToPdf.convertFromHtmlContent(
        finalHTML,
        pdfStorageDirectory,
        "foglio_ore_${MESI[dati.keys.first.month - 1]}_${dati.keys.first.year}");
  }

  static String _parseRowTemplate(
      String rowTemplate, Cantiere cantiere, Map<DateTime, List<Lavoro>> dati) {
    String currentRowValue = rowTemplate.replaceAll(
        "[nome]", cantiere.toString().split(".").last.toUpperCase());

    int currentYear = dati.keys.first.year;
    int currentMonth = dati.keys.first.month;

    int daysInMonth = getGiorniDelMese(currentYear, currentMonth);

    int totaleMinuti = 0;

    for (int i = 1; i <= 31; i++) {
      String orarioLavorato = "00:00";
      String classe = "bianca";

      if (i <= daysInMonth) {
        Lavoro lavoroOdierno =
            dati[DateTime(currentYear, currentMonth, i)][cantiere.index];

        if (lavoroOdierno.lavorato) {
          orarioLavorato = lavoroOdierno.orarioLavorato;

          totaleMinuti += lavoroOdierno.minutiLavorati;

          classe = "";
        } else if (lavoroOdierno.motivoAssenza != MotivoAssenza.NONE) {
          orarioLavorato = lavoroOdierno.motivoAssenza.toShortString();
          classe = "";
        }
      }

      currentRowValue = currentRowValue
          .replaceAll("[giorno($i)]", orarioLavorato)
          .replaceAll("[classe($i)]", classe);
    }

    return currentRowValue.replaceAll("[totale]", minutiToOrario(totaleMinuti));
  }
}
