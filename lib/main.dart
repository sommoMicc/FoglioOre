import 'package:flutter/material.dart';
import 'package:foglio_ore/model/stato.dart';
import 'package:foglio_ore/screen/home_page.dart';
import 'package:foglio_ore/utils/constants.dart';
import 'package:foglio_ore/utils/data_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

void main() {
  initializeDateFormatting('it_IT', null).then((_) => runApp(MyApp()));
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
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: AppColors.defaultText,
                ),
              ),
          primaryColor: AppColors.primary,
          accentColor: AppColors.accent,
          backgroundColor: AppColors.defaultBackground,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
