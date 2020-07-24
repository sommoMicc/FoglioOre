enum Cantiere {
  Confindustria,
  Assimoko,
}

String cantiereToString(Cantiere input) {
  return input == Cantiere.Assimoko ? "Assimoko" : "Confindustria";
}
