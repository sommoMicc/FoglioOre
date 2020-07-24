import 'package:flutter/material.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/widget/card_lavoro.dart';

class CardLavoroContainer extends StatelessWidget {
  final List<Lavoro> lavori;

  CardLavoroContainer(List<Lavoro> pLavori) : lavori = pLavori ?? [];

  List<Widget> _buildListaCardLavoro() {
    List<Widget> widgetLavori = [];

    for (Lavoro lavoro in lavori) {
      widgetLavori.add(CardLavoro(lavoro: lavoro));
    }
    return widgetLavori;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildListaCardLavoro(),
    );
  }
}
