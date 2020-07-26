import 'package:hive/hive.dart';

part 'cantiere.g.dart';

@HiveType(typeId: 93)
enum Cantiere {
  Confindustria,
  Assimoco,
}

String cantiereToString(Cantiere input) {
  return input == Cantiere.Assimoco ? "Assimoco" : "Confindustria";
}
