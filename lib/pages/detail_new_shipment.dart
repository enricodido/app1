import 'package:agros_app/model/shipment.dart';
import 'package:agros_app/pages/shipment.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/get_shipment.dart';
import '../components/customDialog.dart';
import '../components/flutter_flow_theme.dart';
import '../components/flutter_flow_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../repositories/repository.dart';

class DettaglioNuovaSpedizioneWidgetArg {
  DettaglioNuovaSpedizioneWidgetArg({required this.shipment,
  });

  final Shipment? shipment;
}

class DettaglioNuovaSpedizioneWidget extends StatefulWidget {
  static const ROUTE_NAME = '/new_shipment_detail';

  @override
  _DettaglioNuovaSpedizioneWidgetState createState() =>
      _DettaglioNuovaSpedizioneWidgetState();
}

class _DettaglioNuovaSpedizioneWidgetState
    extends State<DettaglioNuovaSpedizioneWidget> {
  TextEditingController textController2 = TextEditingController();
  String scanQRCode = '';
  Shipment? shipment;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
    setState(() {
      final args = ModalRoute.of(context)!.settings.arguments as DettaglioNuovaSpedizioneWidgetArg;
      shipment = args.shipment;
    });
      
    });
  }

void onsubmit() async {

    
      String note = textController2.text.trim();


      if (textController2 != null ) {
         print(shipment!.id);
        print(note);
       
        setState(() {
          isLoading = true;
        });

        try {
          final data = await getIt
              .get<Repository>()
              .shipmentRepository!
              .detail(
            context,
            shipment!.id,
            note.toString(),
          );

          if (data) {
            Navigator.pushNamed(
                context, DettaglioNuovaSpedizioneWidget.ROUTE_NAME,
                arguments: DettaglioNuovaSpedizioneWidgetArg(shipment: shipment));
            showCustomDialog(
              context: context,
              type: CustomDialog.SUCCESS,
              msg: 'Bancale aggiunto con Successo',
            );
            setState(() {
              isLoading = false;
            });
          }
        } catch (error) {
          print(error);
          showCustomDialog(
            context: context,
            type: CustomDialog.WARNING,
            msg: 'Errore!',
          );
        }

        setState(() {
          isLoading = false;
        });
      } else {
        showCustomDialog(
          context: context,
          type: CustomDialog.ERROR,
          msg: 'Dati mancanti!',
        );
      }
    }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      textController2.text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.secondaryColor,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                    child: Text(
                      'Dettaglio spedizione',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ), Text(
                    shipment!.progressive,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        InkWell(

                          onTap: ()  {
                            scanQR();

                          },
                          child: Icon(
                            Icons.qr_code,
                            color: Color(0xFF6C6C6C),
                            size: 35,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 15, 0, 0),
                            child: TextFormField(

                              controller: textController2,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Progressivo Pedana',
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

                              ),
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                                fontFamily: 'Poppins',
                                fontSize: 16,

                              ),
                            ),
                          ),
                         
                          
                        ),
                        
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 100, 0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                          child: FFButtonWidget(
                            
                            onPressed: () async {
                              onsubmit();
                             
                              // await showDialog(
                              //   context: context,
                              //   builder: (alertDialogContext) {
                              //     return AlertDialog(
                              //       title: Text(
                              //           'Confermi di aver finito il carico?'),
                              //       content: Text(
                              //           'Una volta completato non sarà più possibile modificare'),
                              //       actions: [
                              //         TextButton(
                              //           onPressed: () =>
                              //               Navigator.pop(alertDialogContext),
                              //           child: Text('Non ancora'),
                              //         ),
                              //         TextButton(
                              //           onPressed: () async {
                              //             Navigator.pop(alertDialogContext);
                              //             await Navigator.push(
                              //               context,
                              //               MaterialPageRoute(
                              //                 builder: (context) =>
                              //                     SpedizioneWidget(),
                              //               ),
                              //             );
                              //             ;
                              //           },
                              //           child: Text('Conferma'),
                              //         ),
                              //       ],
                              //     );
                              //   },
                              // );
                            },
                            text: 'Aggiungi alla spedizione',
                            options: FFButtonOptions(
                              width: 270,
                              height: 50,
                              color: FlutterFlowTheme.primaryColor,
                              textStyle: FlutterFlowTheme
                                  .subtitle2
                                  .override(
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
                        ),
                        Align(
                          alignment: AlignmentDirectional(0, -0.15),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 20, 10, 20),
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
                                    textStyle: FlutterFlowTheme
                                        .subtitle2
                                        .override(
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
                                    await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SpedizioneWidget(),
                                      ),
                                    );
                                  },
                                  text: 'Salva',
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: 50,
                                    color: FlutterFlowTheme
                                        .secondaryColor,
                                    textStyle: FlutterFlowTheme
                                        .subtitle2
                                        .override(
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
