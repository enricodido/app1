import 'package:agros_app/blocs/get_shipment.dart';
import 'package:agros_app/main.dart';
import 'package:agros_app/pages/home.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/flutter_flow_theme.dart';

import 'package:flutter/material.dart';

import '../components/flutter_flow_widget.dart';
import '../repositories/repository.dart';
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
         actions: <Widget>[
          IconButton(
          icon:Icon(  Icons.arrow_back_rounded,
                              color: FlutterFlowTheme.tertiaryColor,
                              size: 40,
                            ),
          onPressed: () { Navigator.pushNamed(context, HomePagWidget.ROUTE_NAME);}, 
          ),
        ],
        backgroundColor: Color(0xFF018AAA),
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 4,
         title: Text(
          'Spedizioni',
          style: FlutterFlowTheme.bodyText1.override(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
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
                              'Spedizione Creata',
                              style: FlutterFlowTheme
                                  .bodyText1
                                  .override(
                              fontFamily: 'Poppins',
                              fontWeight:
                              FontWeight.w500,
                              ),
                              ),
                              ),
                                Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                   75, 5, 0, 0),
                                            child:
                              FFButtonWidget(
                                            text: 'Lavorazione', 
                                            
                                          onPressed: () async {
                                        await showDialog(
                                          context: context,
                                           builder: (context) {
                                          return AlertDialog(
                                                title: Text('Scegli Ribalta',
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.bodyText1.override(
                                                                      fontFamily: 'Open Sans',
                                                                      color: Colors.black,
                                                                      fontSize: 30,
                                                                      fontWeight: FontWeight.w600,
                                                                    ),),
                                                content: SizedBox(
                                                  height: 400,
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          children: [ 
                                                              Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              7,
                                                                              30,
                                                                              7,
                                                                              0),
                                                                      child:
                                                                         shipment.slotone ? FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          final data = await getIt.get<Repository>().shipmentRepository!.change(
                                                                              shipment_id: shipment.id,
                                                                              slot: '1'
                                                                            );
                                                                             Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);
                                                                        },
                                                                        text: 'Ribalta 1',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        ),
                                                                      ) : FFButtonWidget(text: 'Ribalta 1 OCCUPATA', onPressed: () async { Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);}, options:  FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        ))
                                                              ),
                                                               Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              7,
                                                                              30,
                                                                              7,
                                                                              0),
                                                                      child: shipment.slottwo ?
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          final data = await getIt.get<Repository>().shipmentRepository!.change(
                                                                              shipment_id: shipment.id,
                                                                              slot: '2');
                                                                               Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);
                                                                        },
                                                                        text: 'Ribalta 2',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color:
                                                                                shipment.slottwo ?
                                                                                Colors.green  :  Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                               shipment.slottwo ?
                                                                                Colors.green  :  Colors.red,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        ),
                                                                      ) :  FFButtonWidget(text: 'Ribalta 2 OCCUPATA', onPressed: () async { Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);}, options:  FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        )),
                                                              ),
                                                               Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              7,
                                                                              30,
                                                                              7,
                                                                              0),
                                                                      child: shipment.slotthree ?
                                                                          FFButtonWidget(
                                                                        onPressed:
                                                                            () async {
                                                                          final data = await getIt.get<Repository>().shipmentRepository!.change(
                                                                              shipment_id: shipment.id,
                                                                              slot: '3'
                                                                            );
                                                                             Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);
                                                                        },
                                                                        text: 'Ribalta 3',
                                                                        options:
                                                                            FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color:
                                                                                shipment.slotthree ?
                                                                                Colors.green  :  Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                shipment.slotthree ?
                                                                                Colors.green  :  Colors.red,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        ),
                                                                      ) : FFButtonWidget(text: 'Ribalta 3 OCCUPATA', onPressed: () async { Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);}, options:  FFButtonOptions(
                                                                          width:
                                                                              double.infinity,
                                                                          height:
                                                                              50,
                                                                          color:
                                                                              Colors.white,
                                                                          textStyle: FlutterFlowTheme
                                                                              .subtitle2
                                                                              .override(
                                                                            fontFamily:
                                                                                'Open Sans',
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color: shipment.slotone ?
                                                                                Colors.green  :  Colors.red,
                                                                            width:
                                                                                3,
                                                                          ),
                                                                          borderRadius:
                                                                              15,
                                                                        )),
                                                              ),
                                                          ]       
                                                                    ),
                                                                    
                                                                    )
                                                  ),
                                                );
                                          },
                                        );
                                      } ,
                                         

                                                
                                              
                                             options: FFButtonOptions(
                                                width: 100,
                                                height: 50,
                                                color:
                                                Colors.deepOrangeAccent,
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
                                              ),),)),
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
                                          Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                   60, 5, 0, 0),
                                            child:
                                        FFButtonWidget(
                                            text: 'Completato', 
                                            
                                          onPressed: () async {

                                                final data = await getIt.get<Repository>().shipmentRepository!.change(
                                                  shipment_id: shipment.id,
                                                 slot: 'null',
                                                );
                                                Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);
                                              },
                                             options: FFButtonOptions(
                                                width:100,
                                                height: 50,
                                                color:
                                                Colors.green,
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
                                              ),),)),
                                      ]);
                                  break;
                                  case COMPLAINT_CLOSED:
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
                                          Align(
                                      alignment: AlignmentDirectional(1, 0),
                                      child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                   70, 5, 0, 0),
                                            child:
                                        FFButtonWidget(
                                            text: 'Spedito', 
                                            
                                          onPressed: () async {

                                                final data = await getIt.get<Repository>().shipmentRepository!.change(
                                                  shipment_id: shipment.id,
                                                 slot: 'null',
                                                );
                                                Navigator.pushNamed(context, SpedizioneWidget.ROUTE_NAME);
                                              },
                                             options: FFButtonOptions(
                                                width:100,
                                                height: 50,
                                                color:
                                                Colors.grey,
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
                                              ),),)),
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
                                      DettagliSpedizioneWidget.ROUTE_NAME,
                                      arguments: DettagliSpedizioneWidgetArg(shipment: shipment)
                                      );
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
                                              'Cliente: ' +
                                            shipment
                                                .customer.business_name + 
                                              '\nData: ' + shipment.date,
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
                                           'Spedizione  ' +
                                                  shipment.progressive +
                                                '\nTrasportatore: ' +
                                                shipment.carrier.description,
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
                                                    DettaglioNuovaSpedizioneWidget.ROUTE_NAME,
                                                    arguments: DettaglioNuovaSpedizioneWidgetArg(shipment: shipment));
                                              },
                                              text: '',
                                              options: FFButtonOptions(
                                                width: 55,
                                                height: 55,
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
