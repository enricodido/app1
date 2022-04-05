import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../components/flutter_flow_theme.dart';

class RicercaProdottiWidget extends StatefulWidget {
  static const ROUTE_NAME = '/search';
  @override
  _RicercaProdottiWidgetState createState() => _RicercaProdottiWidgetState();
}

class _RicercaProdottiWidgetState extends State<RicercaProdottiWidget> {
  late TextEditingController textController;
  var scanQRCode = '';
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                  child: Text(
                    'Ricerca prodotti',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 15, 10, 0),
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
                            style:
                            FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          scanQRCode = await FlutterBarcodeScanner.scanBarcode(
                            '#C62828', // scanning line color
                            'Chiudi', // cancel button text
                            true, // whether to show the flash icon
                            ScanMode.BARCODE,
                          );

                          setState(() {});
                        },
                        child: Icon(
                          Icons.search,
                          color: Color(0xFF6C6C6C),
                          size: 30,
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
    );
  }
}
