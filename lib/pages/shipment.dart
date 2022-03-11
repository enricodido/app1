import 'package:agros_app/blocs/get_shipment.dart';
import 'package:agros_app/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/flutter_flow_theme.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/flutter_flow_widget.dart';
import '../theme/color.dart';
import 'detail_new_shipment.dart';
import 'detail_shipment.dart';
import 'new_shipment.dart';

class SpedizioneWidget extends StatefulWidget {
  static const ROUTE_NAME = '/shipment';
  @override
  _SpedizioneWidgetState createState() => _SpedizioneWidgetState();
}

class _SpedizioneWidgetState extends State<SpedizioneWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      BlocProvider.of<GetShipmentBloc>(context)
          .add(GetShipmentBlocRefreshEvent());
      BlocProvider.of<GetShipmentBloc>(context).add(GetShipmentBlocGetEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF018AAA),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NuovaSpedizioneWidget(),
            ),
          );
        },
        backgroundColor: Color(0xFF018AAA),
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
        elevation: 8,
        label: Text(
          'Nuova spedizione',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
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
                    'Spedizioni',
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: BlocBuilder<GetShipmentBloc, GetShipmentBlocState>(
                      builder: (context, state) {
                    if (state is GetShipmentBlocStateLoading)
                      return Center(child: CircularProgressIndicator());
                    else {
                      final shipments =
                          (state as GetShipmentBlocStateLoaded).shipments;
                      if (shipments.isNotEmpty) {
                        return ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: shipments.length,
                            itemBuilder: (context, index) {
                              final shipment = shipments[index];
                              Widget icon = Row();
                              switch (shipment.status) {
                                case COMPLAINT_OPEN:
                                icon =  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              Padding(
                              padding: EdgeInsetsDirectional
                                  .fromSTEB(10, 0, 0, 0),
                              child: Text(
                              'Carico in Lavorazione',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                              fontFamily: 'Poppins',
                              fontWeight:
                              FontWeight.w500,
                              ),
                              ),
                              ),
                              ]);
                              break;
                                case COMPLAINT_PROCESSING:
                                  icon =  Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.deepOrangeAccent,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 0, 0),
                                          child: Text(
                                            'Carico Completato',
                                            style: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontWeight:
                                              FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ]);
                                  break;
                                case COMPLAINT_CLOSED:
                                  icon =   Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                        Padding(
                                          padding: EdgeInsetsDirectional
                                              .fromSTEB(10, 0, 0, 0),
                                          child: Text(
                                            'Carico Spedito',
                                            style: FlutterFlowTheme
                                                .bodyText1
                                                .override(
                                              fontFamily: 'Poppins',
                                              fontWeight:
                                              FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ]);
                                  break;
                              }
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10, 10, 10, 10),
                                child: InkWell(
onTap: ()  {
                                     Navigator.pushNamed(
                                      context,
                                      DettagliSpedizioneWidget.ROUTE_NAME);
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: BorderSide(color: Colors.black38, width: 2.0,),
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
                                                    10, 10, 10, 10),
                                            child: Text(
                                              'Spedizione  ' +
                                                  shipment.progressive,
                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color:  Color(0xFF018AAA),
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Color(0xFF6C6C6C),
                                          ),
                                          Text(
                                            'Cliente: ' +
                                            shipment
                                                .customer.business_name +
                                                '\nTrasportatore: ' +
                                                shipment.carrier.description +
                                                '\nData spedizione: ' +
                                                shipment.date,
                                            style: FlutterFlowTheme.bodyText1,
                                          ),

                                         Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                   10, 5, 10, 0),
                                            child: //icon,
                                             FFButtonWidget(
                                               
                                               icon: Icon(Icons.qr_code_outlined,),
                                              onPressed: () async {

                                                Navigator.pushNamed(context,
                                                    DettaglioNuovaSpedizioneWidget.ROUTE_NAME);
                                                  //  arguments: DettaglioNuovaSpedizioneWidgetArg(shipment_id: shipment.id,));
                                              },
                                              text: '',
                                              options: FFButtonOptions(
                                                width: 50,
                                                height: 50,
                                                color:
                                                Color(0xFF018AAA),
                                                textStyle: FlutterFlowTheme
                                                    .subtitle2
                                                    .override(
                                                  fontFamily: 'Open Sans',
                                                  color: Colors.white,
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius: 12,
                                              ),
                                            ),
                                          ),
                                           ),
                                           icon,
                                        
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
                  }
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
