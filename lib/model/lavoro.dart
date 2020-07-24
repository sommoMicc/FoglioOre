import 'package:flutter/foundation.dart';
import 'package:foglio_ore/model/cantiere.dart';
import 'package:foglio_ore/utils/utils.dart';

enum MotivoAssenza { NONE, PERMESSO, FERIE, LUTTO, FESTIVITA, ALTRO }

extension Stringify on MotivoAssenza {
  String toLongString() {
    return this != MotivoAssenza.NONE
        ? this.toString().split(".").last.toUpperCase()
        : "Non era un giorno lavorativo";
  }

  String toShortString() {
    return this != MotivoAssenza.NONE
        ? this.toLongString().substring(0, 1)
        : "";
  }
}

class Lavoro with ChangeNotifier {
  Cantiere _cantiere;
  bool _lavorato;

  MotivoAssenza _motivoAssenza;
  int _minutiLavorati;

  Lavoro({
    @required Cantiere cantiere,
    bool lavorato = true,
    MotivoAssenza motivoAssenza = MotivoAssenza.NONE,
    int minutiLavorati,
  }) {
    this._cantiere = cantiere;
    this._lavorato = lavorato;

    if (minutiLavorati == null)
      this._minutiLavorati =
          (this.cantiere == Cantiere.Confindustria) ? 150 : 45;
    else
      this._minutiLavorati = minutiLavorati;
  }

  Cantiere get cantiere => _cantiere;

  set cantiere(Cantiere value) {
    _cantiere = value;
  }

  String get nomeCantiere => cantiereToString(_cantiere);

  int get minutiLavorati => _minutiLavorati;

  set minutiLavorati(int value) {
    _minutiLavorati = value;
    notifyListeners();
  }

  String get orarioLavorato => minutiToOrario(_minutiLavorati);

  MotivoAssenza get motivoAssenza => _motivoAssenza ?? MotivoAssenza.NONE;

  set motivoAssenza(MotivoAssenza value) {
    _motivoAssenza = value;
    notifyListeners();
  }

  bool get lavorato => _lavorato;

  set lavorato(bool value) {
    _lavorato = value;
    notifyListeners();
  }
}
