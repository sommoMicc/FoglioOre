import 'package:flutter/material.dart';
import 'package:foglio_ore/model/cantiere.dart';
import 'package:foglio_ore/model/lavoro.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/screen/riepilogo.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/data_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

import 'model/lavoro.dart';

void main() async {
  await initializeDateFormatting('it_IT', null);
  await Hive.initFlutter();

  Hive.registerAdapter<Cantiere>(CantiereAdapter());
  Hive.registerAdapter<MotivoAssenza>(MotivoAssenzaAdapter());
  Hive.registerAdapter<Lavoro>(LavoroAdapter());
  Hive.registerAdapter<GlobalAppState>(GlobalAppStateAdapter());

  await Hive.openBox(GlobalAppState.HIVE_BOX_NAME);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GlobalAppState>(
          create: (BuildContext context) => GlobalAppState(
              DataProvider.getListaLavoriMese(
                  DateTime.now().year, DateTime.now().month)),
        ),
        ChangeNotifierProvider<DateTimeAppState>(
          create: (BuildContext context) => DateTimeAppState(),
        )
      ],
      child: MaterialApp(
        title: 'Foglio ore',
        theme: ThemeData.light().copyWith(
          textTheme: kDefaultTextTheme,
          appBarTheme: AppBarTheme.of(context).copyWith(
            color: AppColors.defaultBackground,
            elevation: kAppBarElevation,
            textTheme: kDefaultTextTheme.copyWith(
              headline6: GoogleFonts.firaSans(
                color: AppColors.defaultText,
                fontSize: kAppBarFontSize,
                fontWeight: FontWeight.w900,
              ),
            ),
            iconTheme: IconTheme.of(context).copyWith(
              color: AppColors.defaultText,
            ),
          ),
          primaryColor: AppColors.primary,
          accentColor: AppColors.accent,
          backgroundColor: AppColors.defaultBackground,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: RiepilogoPage(),
      ),
    );
  }
}
