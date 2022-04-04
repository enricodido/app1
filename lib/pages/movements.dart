import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/flutter_flow_theme.dart';

class SpostamentoMagazzinoWidget extends StatefulWidget {
 static const ROUTE_NAME = '/movements';

  @override
  _SpostamentoMagazzinoWidgetState createState() =>
      _SpostamentoMagazzinoWidgetState();
}

class _SpostamentoMagazzinoWidgetState
    extends State<SpostamentoMagazzinoWidget> {
  TextEditingController textController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: ' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF6C6C6C),
        automaticallyImplyLeading: true,
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                  child: Text(
                    'Spostamento magazzino',
                    style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 10),
                  child: TextFormField(
                    onChanged: (_) => EasyDebounce.debounce(
                      'textController',
                      Duration(milliseconds: 2000),
                      () => setState(() {}),
                    ),
                    controller: textController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Ricerca prodotto',
                      hintText: ' ',
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
                      suffixIcon: textController.text.isNotEmpty
                          ? InkWell(
                              onTap: () => setState(
                                () => textController.clear(),
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
                Container(
                  width: 300,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Color(0xFFEEEEEE),
                    shape: BoxShape.rectangle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}