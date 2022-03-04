import 'package:easy_debounce/easy_debounce.dart';

import '../components/flutter_flow_drop_down.dart';
import '../components/flutter_flow_theme.dart';
import '../components/flutter_flow_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detail_new_shipment.dart';

class NuovaSpedizioneWidget extends StatefulWidget {
  static const ROUTE_NAME = '/new_shipment';
  @override
  _NuovaSpedizioneWidgetState createState() => _NuovaSpedizioneWidgetState();
}

class _NuovaSpedizioneWidgetState extends State<NuovaSpedizioneWidget> {

  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: 'Calcolato in automatico');
    textController2 = TextEditingController(text: 'AA000AA');
    textController3 = TextEditingController(
        text: '02/02/2022 (mettere calendario da oggi in poi)');
    textController4 =
        TextEditingController(text: 'Questo lotto ha questo dettaglio...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                    child: Text(
                      'Nuova spedizione',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController1',
                        Duration(milliseconds: 2000),
                            () => setState(() {}),
                      ),
                      controller: textController1,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Progressivo Spedizione',
                        hintText: 'Calcolato in automatico',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: textController1.text.isNotEmpty
                            ? InkWell(
                          onTap: () => setState(
                                () => textController1.clear(),
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )
                            : null,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: FlutterFlowDropDown(
                      initialOption: '',
                      options: ['Trasportatore 1', 'trasportatore 2'].toList(),
                      onChanged: (val) => setState(() => val),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      textStyle:
                      FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF303030),
                        fontSize: 16,
                      ),
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Color(0xFF6C6C6C),
                      borderWidth: 0,
                      borderRadius: 15,
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController2',
                        Duration(milliseconds: 2000),
                            () => setState(() {}),
                      ),
                      controller: textController2,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Targa (opzionale)',
                        hintText: 'AA000AA',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: textController2.text.isNotEmpty
                            ? InkWell(
                          onTap: () => setState(
                                () => textController2.clear(),
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )
                            : null,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: FlutterFlowDropDown(
                      initialOption: 'Codice cliente',
                      options: ['Cliente 1', 'Cliente 2'].toList(),
                      onChanged: (val) => setState(() =>  val),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      textStyle:
                      FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        color: Color(0xFF303030),
                        fontSize: 16,
                      ),
                      fillColor: Colors.white,
                      elevation: 2,
                      borderColor: Color(0xFF6C6C6C),
                      borderWidth: 0,
                      borderRadius: 15,
                      margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                      hidesUnderline: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController3',
                        Duration(milliseconds: 2000),
                            () => setState(() {}),
                      ),
                      controller: textController3,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Data di spedizione(mettere calendario)',
                        hintText: '02/02/22',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: textController3.text.isNotEmpty
                            ? InkWell(
                          onTap: () => setState(
                                () => textController3.clear(),
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )
                            : null,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController4',
                        Duration(milliseconds: 2000),
                            () => setState(() {}),
                      ),
                      controller: textController4,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Note (facoltativo)',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF6C6C6C),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: textController4.text.isNotEmpty
                            ? InkWell(
                          onTap: () => setState(
                                () => textController4.clear(),
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 22,
                          ),
                        )
                            : null,
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                      maxLines: 10,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          text: 'Chiudi',
                          options: FFButtonOptions(
                            width: 150,
                            height: 50,
                            color: Color(0xFF6C6C6C),
                            textStyle:
                            FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 15,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text(
                                      'Confermare le informazioni della nuova spedizione?'),
                                  content: Text(
                                      'Una volta confermate queste info, non saranno più modificabili'),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Non ancora'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.pop(alertDialogContext);
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DettaglioNuovaSpedizioneWidget(),
                                          ),
                                        );
                                        ;
                                      },
                                      child: Text('Conferma'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          text: 'Salva',
                          options: FFButtonOptions(
                            width: 150,
                            height: 50,
                            color: FlutterFlowTheme.secondaryColor,
                            textStyle:
                            FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 15,
                          ),
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
    );
  }
}
