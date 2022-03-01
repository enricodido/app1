import 'package:agros_app/pages/detail_new_shipment.dart';
import 'package:agros_app/pages/detail_shipment.dart';
import 'package:agros_app/pages/labeling.dart';
import 'package:agros_app/pages/labeling_detail.dart';
import 'package:agros_app/pages/login.dart';
import 'package:agros_app/pages/movements.dart';
import 'package:agros_app/pages/new_labeling.dart';
import 'package:agros_app/pages/new_shipment.dart';
import 'package:agros_app/pages/search.dart';
import 'package:agros_app/pages/shipment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agros_app/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deltacall Checklist',
      debugShowCheckedModeBanner: false,
      initialRoute: LoginPageWidget.ROUTE_NAME,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        textTheme: GoogleFonts.montserratTextTheme(),
        primaryTextTheme: GoogleFonts.montserratTextTheme(),
        accentTextTheme: GoogleFonts.montserratTextTheme(),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlueAccent,
        ),
        primaryColor: Colors.lightBlueAccent,
        tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),

        ),
      ),
      routes: {
        LoginPageWidget.ROUTE_NAME: (_) => LoginPageWidget(),
        HomePagWidget.ROUTE_NAME: (_) => HomePagWidget(),
        SpedizioneWidget.ROUTE_NAME: (_) => SpedizioneWidget(),
        DettagliSpedizioneWidget.ROUTE_NAME: (_) => DettagliSpedizioneWidget(),
        DettaglioNuovaSpedizioneWidget.ROUTE_NAME: (_) => DettaglioNuovaSpedizioneWidget(),
        EtichettaturaWidget.ROUTE_NAME: (_) => EtichettaturaWidget(),
        DettaglioEtichettaturaWidget.ROUTE_NAME: (_) => DettaglioEtichettaturaWidget(),
        NuovaEtichettaturaWidget.ROUTE_NAME: (_) => NuovaEtichettaturaWidget(),
        RicercaProdottiWidget.ROUTE_NAME: (_) => RicercaProdottiWidget(),
        SpostamentoMagazzinoWidget.ROUTE_NAME: (_) => SpostamentoMagazzinoWidget(),
        NuovaSpedizioneWidget.ROUTE_NAME: (_) => NuovaSpedizioneWidget(),
      },
    );
  }
}
