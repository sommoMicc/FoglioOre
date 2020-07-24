import 'package:flutter/material.dart';
import 'package:foglio_ore/model/lavoro.dart';

class GlobalAppState with ChangeNotifier {
  Map<DateTime, List<Lavoro>> _dati;

  GlobalAppState(this._dati);

  Map<DateTime, List<Lavoro>> get dati => _dati;

  set dati(Map<DateTime, List<Lavoro>> value) {
    _dati = value;
    notifyListeners();
  }

  void aggiornaLavoro(DateTime dateTime, Lavoro lavoro) {
    List<Lavoro> lavoriDelGiorno = this._dati[dateTime];
    //Sostituisco l'oggetto lavoro con quello "vero"
    int index = lavoriDelGiorno
        .indexWhere((element) => element.cantiere == lavoro.cantiere);
    lavoriDelGiorno[index] = lavoro;

    notifyListeners();
  }
}

class DateTimeAppState with ChangeNotifier {
  DateTime _dataCorrente;

  DateTimeAppState() {
    DateTime now = DateTime.now();
    _dataCorrente = DateTime(now.year, now.month, 1);
  }

  DateTime get dataCorrente => _dataCorrente;

  set dataCorrente(DateTime value) {
    _dataCorrente = value;
    notifyListeners();
  }
}
