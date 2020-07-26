import 'package:flutter/material.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/screen/compilazione_page.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/data_provider.dart';
import 'package:foglio_ore/widget/foglio_ore_list_tile.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class RiepilogoPage extends StatefulWidget {
  @override
  _RiepilogoPageState createState() => _RiepilogoPageState();
}

class _RiepilogoPageState extends State<RiepilogoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Riepilogo"),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(GlobalAppState.HIVE_BOX_NAME).listenable(),
        builder: (context, box, widget) {
          List<GlobalAppState> list =
              box.toMap().values.toList().cast<GlobalAppState>();

          return ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) =>
                FoglioOreListTile(list[index], index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Provider.of<GlobalAppState>(context, listen: false).dati =
              DataProvider.getListaLavoriMese(
                  DateTime.now().year, DateTime.now().month);

          Provider.of<DateTimeAppState>(context, listen: false).dataCorrente =
              DateTime(DateTime.now().year, DateTime.now().month, 1);

          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => CompilazionePage()),
          );
        },
        label: Text("Nuovo foglio ore"),
        icon: Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
