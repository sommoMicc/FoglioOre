import 'package:flutter/material.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/widget/card_lavoro.dart';

class CardLavoroContainer extends StatelessWidget {
  final List<Lavoro> lavori;

  CardLavoroContainer(List<Lavoro> pLavori) : lavori = pLavori ?? [];

  List<Widget> _buildListaCardLavoro() {
    List<Widget> widgetLavori = [];

    for (int i = 0; i < lavori.length; i++) {
      widgetLavori.add(CardLavoro(
        lavoro: lavori[i],
        cardColor: AppColors.cardColors[i],
      ));
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
