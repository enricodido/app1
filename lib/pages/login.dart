import '../components/customDialog.dart';
import '../components/flutter_flow_theme.dart';
import '../components/flutter_flow_util.dart';
import '../components/flutter_flow_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../repositories/repository.dart';
import 'home.dart';

class LoginPageWidget extends StatefulWidget {
  static const ROUTE_NAME = '/login';
  @override
  _LoginPageWidgetState createState() => _LoginPageWidgetState();
}

class _LoginPageWidgetState extends State<LoginPageWidget> {
  bool isLoading = false;

  TextEditingController textFieldEmailController = TextEditingController();
  TextEditingController textFieldPasswordController = TextEditingController();

  String emailError = 'email richiesta.';
  String passwordError = 'Password richiesta.';

  bool textFieldPasswordVisibility = false;
  bool _loadingButton = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void onSubmit() async {
    final email = textFieldEmailController.text.trim();
    final password = textFieldPasswordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {

        final jwt = await getIt
            .get<Repository>()
            .userRepository!
            .login(context, email.toString(), password.toString());
        if(jwt != null) {
          Navigator.pushNamed(context, HomePagWidget.ROUTE_NAME);
        }

      } catch (error) {
        if ((error as RequestError).error == 'Unauthorized') {
          showCustomDialog(
            context: context,
            type: CustomDialog.WARNING,
            msg: 'Credenziali Non Corrette!',
          );
        }
      }
      setState(() {
        isLoading = false;
      });

    } else {
      showCustomDialog(
        context: context,
        type: CustomDialog.WARNING,
        msg:'Dati Mancanti!',
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                color: Color(0xFFEEEEEE),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Image.asset(
                    'images/landscape.jpg',
                  ).image,
                ),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.2,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.primaryColor,
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/agrosApp-logo.png',
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.2,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 20, 5, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          color: Color(0xBEFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 10, 0),
                                  child: TextFormField(
                                    controller: textFieldEmailController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF707070),
                                      ),
                                      hintText: 'Inserisci Email',
                                      hintStyle: FlutterFlowTheme.bodyText1.override(
                                        fontFamily: 'Open Sans',
                                        color: Color(0xFF707070),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF009648),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF009648),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(18, 18, 18, 18),
                                      prefixIcon: Icon(
                                        Icons.mail,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Open Sans',
                                      color: Color(0xFF707070),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                          color: Color(0xBEFFFFFF),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 0, 10, 0),
                                      child: TextFormField(
                                        controller: textFieldPasswordController,
                                        obscureText: !textFieldPasswordVisibility,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF707070),
                                          ),
                                          hintText: 'Password',
                                          hintStyle: FlutterFlowTheme.bodyText1.override(
                                            fontFamily: 'Open Sans',
                                            color: Color(0xFF707070),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF009648),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF009648),
                                              width: 1,
                                            ),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(18, 18, 18, 18),
                                          prefixIcon: Icon(
                                            Icons.vpn_key,
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () => setState(
                                                  () => textFieldPasswordVisibility =
                                              !textFieldPasswordVisibility,
                                            ),
                                            child: Icon(
                                              textFieldPasswordVisibility
                                                  ? Icons.visibility_outlined
                                                  : Icons.visibility_off_outlined,
                                              color: Color(0xFF757575),
                                              size: 22,
                                            ),
                                          ),
                                        ),
                                        style: FlutterFlowTheme.bodyText1.override(
                                          fontFamily: 'Open Sans',
                                          color: Color(0xFF707070),
                                        ),
                                        keyboardType: TextInputType.visiblePassword,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                              child: InkWell(
                                onTap: () async {
                                  await launchURL('http://google.it');
                                },
                                child: Text(
                                  'Password dimenticata?',
                                  style: FlutterFlowTheme
                                      .bodyText1
                                      .override(
                                    fontFamily: 'Poppins',
                                    color: FlutterFlowTheme
                                        .secondaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 40, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: onSubmit,
                            text: 'Accedi',
                            options: FFButtonOptions(
                              width: 150,
                              height: 50,
                              color: Colors.white,
                              textStyle: FlutterFlowTheme
                                  .subtitle2
                                  .override(
                                fontFamily: 'Poppins',
                                color: FlutterFlowTheme
                                    .primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,

                              ),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: 15,
                            ),
                         //   showLoadingIndicator: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
