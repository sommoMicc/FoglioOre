import 'package:flutter/material.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/utils/utils.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class CardLavoro extends StatelessWidget {
  final Lavoro _lavoro;

  CardLavoro({@required Lavoro lavoro}) : _lavoro = lavoro;

  @override
  Widget build(BuildContext context) {
    var maskFormatter = new MaskTextInputFormatter(
        mask: '#:##', filter: {"#": RegExp(r'[0-9]')});

    final DateTime dataSelezionata =
        Provider.of<DateTimeAppState>(context).dataCorrente;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_lavoro.nomeCantiere),
          Row(
            children: <Widget>[
              Text("Hai lavorato oggi?"),
              Switch(
                onChanged: (bool value) {
                  _lavoro.lavorato = value;
                  Provider.of<GlobalAppState>(context, listen: false)
                      .aggiornaLavoro(dataSelezionata, _lavoro);
                },
                value: _lavoro.lavorato,
              )
            ],
          ),
          Visibility(
            visible: _lavoro.lavorato,
            child: Row(
              children: <Widget>[
                Text("Quanto hai lavorato?"),
                Expanded(
                  child: TextFieldContainer(
                    maskFormatter: maskFormatter,
                    lavoro: _lavoro,
                    dataSelezionata: dataSelezionata,
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: !_lavoro.lavorato,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Perché non hai lavorato?"),
                DropdownButton<MotivoAssenza>(
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
