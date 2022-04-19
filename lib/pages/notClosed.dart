import 'package:agros_app/pages/home.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../blocs/get_open.dart';
import '../components/flutter_flow_theme.dart';
import '../theme/color.dart';
import 'labeling_detail.dart';

class NoEtichettaturaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/nolabeling';
  @override
  _NoEtichettaturaWidgetState createState() => _NoEtichettaturaWidgetState();
}

class _NoEtichettaturaWidgetState extends State<NoEtichettaturaWidget> {
   TextEditingController palletController = TextEditingController();
    bool isLoading = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
 SchedulerBinding.instance!.addPostFrameCallback((_) async {
      BlocProvider.of<GetOpenBloc>(context).add(GetOpenBlocRefreshEvent());
      BlocProvider.of<GetOpenBloc>(context).add(GetOpenBlocGetEvent());
    });
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
      palletController.text = barcodeScanRes;
    });
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
          icon:Icon(  Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.tertiaryColor,
                              size: 40,
                            ),
          onPressed: () { Navigator.pushNamed(context, HomePagWidget.ROUTE_NAME);}, ),
        ],
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFF5F5F5),
      body:(isLoading) ? Container(
        width: double.infinity,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF80BC01)),
                ),
              )
            ]
        ),
      ) : SafeArea(
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
                      'Completa etichettatura',
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: TextFormField(
                      controller: palletController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Segnacollo',
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
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    
                    ),
                  ),
                  ),
                      ]
                    ),
                   ),
                   Padding(
                     padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                   child: Expanded(
                  child: BlocBuilder<GetOpenBloc, GetOpenBlocState>(
                      builder: (context, state) {
                    if (state is GetOpenBlocStateLoading)
                      return Center(child: CircularProgressIndicator());
                    else {
                      final labels = (state as GetOpenBlocStateLoaded).labels;
                      if (labels.isNotEmpty) {
                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.zero,
                            itemCount: labels.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final label = labels[index];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: InkWell(
                                  onTap: ()  {
                                     Navigator.pushNamed(
                                      context,
                                      DettaglioEtichettaturaWidget.ROUTE_NAME,
                                      arguments: DettaglioEtichettaturaWidgetArg(label: label)
                                    );
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.black38, width: 2.0,),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10, 10, 10, 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 5),
                                            child: Text(
                                              'Etichettatura ' + label.progressive! +  '  ' + label.date  ,

                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.green,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Color(0xFF6C6C6C),
                                          ),
                                          Text(
                                            'Lotto: ' +  label.batch! + '\n'
                                            'Prodotto: ' + label.product.description + ' ' + label.product.variety +'\n'
                                            
                                            'Squadra di raccolta: ' + label.team.description,
                                            style: FlutterFlowTheme.bodyText1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Container(
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Icon(
                                    FontAwesomeIcons.folderOpen,
                                    color: firstColor,
                                    size: 50,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: AutoSizeText(
                                    'NESSUN ELEMENTO',
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }
                  }),
                )
                   ),
                    ]
                    )
                    )
                
              )
            )
          )
        );
      
    
 }
}