// @dart=2.9
import 'package:agros_app/blocs/get_shipment.dart';
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
import 'package:agros_app/repositories/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:agros_app/pages/home.dart';

import 'blocs/get_boxes_type.dart';
import 'blocs/get_carrier.dart';
import 'blocs/get_customer.dart';
import 'blocs/get_label.dart';
import 'blocs/get_pallet.dart';
import 'blocs/get_product.dart';
import 'blocs/get_team.dart';
import 'blocs/user_me.dart';

final getIt = GetIt.instance;
const String COMPLAINT_OPEN = '0';
const String COMPLAINT_PROCESSING = '1';
const String COMPLAINT_CLOSED = '2';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  getIt.registerSingleton(Repository());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserMeBloc(UserMeBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetLabelBloc(GetLabelBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetBoxesBloc(GetBoxesBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetTeamBloc(GetTeamBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetPalletBloc(GetPalletBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetProductBloc(GetProductBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetCustomerBloc(GetCustomerBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetShipmentBloc(GetShipmentBlocStateLoading()),
        ),
        BlocProvider(
          create: (_) => GetCarrierBloc(GetCarrierBlocStateLoading()),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agros App',
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
        DettaglioNuovaSpedizioneWidget.ROUTE_NAME: (_) =>
            DettaglioNuovaSpedizioneWidget(),
        EtichettaturaWidget.ROUTE_NAME: (_) => EtichettaturaWidget(),
        DettaglioEtichettaturaWidget.ROUTE_NAME: (_) =>
            DettaglioEtichettaturaWidget(),
        NuovaEtichettaturaWidget.ROUTE_NAME: (_) => NuovaEtichettaturaWidget(),
        RicercaProdottiWidget.ROUTE_NAME: (_) => RicercaProdottiWidget(),
        SpostamentoMagazzinoWidget.ROUTE_NAME: (_) =>
            SpostamentoMagazzinoWidget(),
        NuovaSpedizioneWidget.ROUTE_NAME: (_) => NuovaSpedizioneWidget(),
      },
    );
  }
}
