import 'package:flutter/foundation.dart';
import 'package:foglio_ore/model/cantiere.dart';
import 'package:foglio_ore/utils/utils.dart';
import 'package:hive/hive.dart';

part 'lavoro.g.dart';

@HiveType(typeId: 100)
enum MotivoAssenza {
  @HiveField(0)
  NONE,

  @HiveField(1)
  PERMESSO,

  @HiveField(2)
  FERIE,

  @HiveField(3)
  LUTTO,

  @HiveField(4)
  FESTIVITA,

  @HiveField(5)
  ALTRO
}

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

@HiveType(typeId: 92)
class Lavoro with ChangeNotifier {
  @HiveField(0)
  Cantiere _cantiere;
  @HiveField(1)
  bool _lavorato;

  @HiveField(2)
  MotivoAssenza _motivoAssenza;
  @HiveField(3)
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
