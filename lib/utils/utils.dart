int orarioToMinuti(String orario) {
  List<String> tocchi = orario.split(":");
  if (tocchi.length == 2) {
    return int.parse(tocchi[0]) * 60 + int.parse(tocchi[1]);
  }
  throw Exception("Formato dell'orario $orario non corretto");
}

String minutiToOrario(int tempo) {
  int ore = tempo ~/ 60;
  String minuti = (tempo - (ore * 60)).toString().padLeft(2, '0');

  return "$ore:$minuti";
}

int getGiorniDelMese(int anno, int mese) {
  print("Giorni del mese $mese: ${DateTime(anno, mese + 1, 0).day}");
  return DateTime(anno, mese + 1, 0).day;
}
