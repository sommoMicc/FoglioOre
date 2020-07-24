enum Cantiere {
  Confindustria,
  Assimoco,
}

String cantiereToString(Cantiere input) {
  return input == Cantiere.Assimoco ? "Assimoco" : "Confindustria";
}
