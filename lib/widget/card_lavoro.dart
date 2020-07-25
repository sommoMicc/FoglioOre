import 'package:flutter/material.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CardLavoro extends StatelessWidget {
  final Lavoro _lavoro;
  final CardColor cardColor;

  CardLavoro({@required Lavoro lavoro, @required this.cardColor})
      : _lavoro = lavoro;

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '#:##', filter: {"#": RegExp(r'[0-9]')});

    final DateTime dataSelezionata =
        Provider.of<DateTimeAppState>(context).dataCorrente;

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: cardColor.border),
        borderRadius: BorderRadius.circular(kDefaultRadius),
      ),
      color: cardColor.background,
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _lavoro.nomeCantiere,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cardColor.border,
                fontSize: kCardTitleSize,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Hai lavorato oggi?",
                  style: kLabelTextStyle,
                ),
                Switch(
                  onChanged: (bool value) {
                    _lavoro.lavorato = value;
                    Provider.of<GlobalAppState>(context, listen: false)
                        .aggiornaLavoro(dataSelezionata, _lavoro);
                  },
                  value: _lavoro.lavorato,
                  activeColor: cardColor.border,
                )
              ],
            ),
            Visibility(
                visible: _lavoro.lavorato,
                child: Container(
                  child: TextFieldContainer(
                    maskFormatter: maskFormatter,
                    lavoro: _lavoro,
                    dataSelezionata: dataSelezionata,
                  ),
                )),
            Visibility(
              visible: !_lavoro.lavorato,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Perché non hai lavorato?",
                    style: kLabelTextStyle,
                  ),
                  DropdownButton<MotivoAssenza>(
                    isExpanded: true,
                    value: _lavoro.motivoAssenza,
                    onChanged: (newValue) {
                      _lavoro.motivoAssenza = newValue;
                      Provider.of<GlobalAppState>(context, listen: false)
                          .aggiornaLavoro(dataSelezionata, _lavoro);
                    },
                    items: MotivoAssenza.values
                        .map<DropdownMenuItem<MotivoAssenza>>(
                          (value) => DropdownMenuItem(
                            value: value,
                            child: Text(
                              value.toLongString(),
                            ),
                          ),
                        )
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatefulWidget {
  const TextFieldContainer({
    Key key,
    @required this.maskFormatter,
    @required Lavoro lavoro,
    @required this.dataSelezionata,
  })  : _lavoro = lavoro,
        super(key: key);

  final MaskTextInputFormatter maskFormatter;
  final Lavoro _lavoro;
  final DateTime dataSelezionata;

  @override
  _TextFieldContainerState createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    textEditingController.value = TextEditingValue(
      text: widget._lavoro.orarioLavorato,
      selection: TextSelection.fromPosition(
        TextPosition(offset: widget._lavoro.orarioLavorato.length),
      ),
    );

    return TextField(
      decoration: InputDecoration(
        labelText: "Quanto hai lavorato?",
        labelStyle: TextStyle(
          fontSize: kLabelFontSize + 3,
          color: AppColors.defaultText,
        ),
        border: OutlineInputBorder(),
      ),
      inputFormatters: [widget.maskFormatter],
      keyboardType: TextInputType.numberWithOptions(
        signed: false,
        decimal: false,
      ),
      controller: textEditingController,
      onEditingComplete: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }

        widget._lavoro.minutiLavorati =
            orarioToMinuti(textEditingController.value.text.toString());

        Provider.of<GlobalAppState>(context, listen: false)
            .aggiornaLavoro(widget.dataSelezionata, widget._lavoro);
      },
    );
  }
}
