import 'package:agros_app/model/shipment.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/get_carrier.dart';
import '../blocs/get_customer.dart';
import '../components/customButtonPrimary.dart';
import '../components/customDialog.dart';
import '../components/flutter_flow_drop_down.dart';
import '../components/flutter_flow_theme.dart';
import '../components/flutter_flow_widget.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../model/carriers.dart';
import '../model/customers.dart';
import '../repositories/repository.dart';
import 'detail_new_shipment.dart';

class DettagliSpedizioneWidgetArg {
  DettagliSpedizioneWidgetArg({required this.shipment});

  final Shipment? shipment;
}

class DettagliSpedizioneWidget extends StatefulWidget {
  static const ROUTE_NAME = '/shipment_detail';

  @override
  _DettagliSpedizioneWidgetState createState() =>
      _DettagliSpedizioneWidgetState();
}

class _DettagliSpedizioneWidgetState extends State<DettagliSpedizioneWidget> {

  TextEditingController progressiveController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
 
  Shipment? shipment;
  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController carrierController = TextEditingController();
  CarrierModel? selectedCarrier;
  void dialogCarrier() {

    BlocProvider.of<GetCarrierBloc>(context).add(GetCarrierBlocRefreshEvent());
    BlocProvider.of<GetCarrierBloc>(context).add(GetCarrierBlocGetEvent());

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Center(
                    child: AutoSizeText(
                      'Trasportatore',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: BlocBuilder<GetCarrierBloc, GetCarrierBlocState>(
                          builder: (context, state) {
                            if (state is GetCarrierBlocStateLoading)
                              return Center(child: CircularProgressIndicator());
                            else {

                              final carriers = (state as GetCarrierBlocStateLoaded).carriers;

                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: carriers.length,
                                  itemBuilder: (context, index) {

                                    final carrier = carriers[index];

                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCarrier = carrier;
                                            carrierController.text = selectedCarrier!.description;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsetsDirectional.only(top: 5.0, bottom: 5.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.9,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFDBDBDB),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 1,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x00EEEEEE),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AutoSizeText(
                                                          carrier.description,
                                                          maxLines: 1,
                                                          style: FlutterFlowTheme.bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        )
                                    );

                                  }
                              );
                            }
                          }),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                      child: CustomButtonPrimary(
                          content: AutoSizeText(
                            'Chiudi',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Colors.red,
                          pressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );

  }

  TextEditingController customerController = TextEditingController();
  CustomerModel? selectedCustomer;
  void dialogCustomer() {

    BlocProvider.of<GetCustomerBloc>(context).add(GetCustomerBlocRefreshEvent());
    BlocProvider.of<GetCustomerBloc>(context).add(GetCustomerBlocGetEvent());

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Center(
                    child: AutoSizeText(
                      'Cliente',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: BlocBuilder<GetCustomerBloc, GetCustomerBlocState>(
                          builder: (context, state) {
                            if (state is GetCustomerBlocStateLoading)
                              return Center(child: CircularProgressIndicator());
                            else {

                              final customers = (state as GetCustomerBlocStateLoaded).customers;

                              return ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: customers.length,
                                  itemBuilder: (context, index) {

                                    final customer = customers[index];

                                    return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCustomer = customer;
                                            carrierController.text = selectedCarrier!.description;
                                            Navigator.pop(context);
                                          });
                                        },
                                        child: Padding(
                                            padding: EdgeInsetsDirectional.only(top: 5.0, bottom: 5.0),
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 2,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.9,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFFDBDBDB),
                                                  borderRadius: BorderRadius.circular(15),
                                                ),
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 1,
                                                  height: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color(0x00EEEEEE),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        AutoSizeText(
                                                          customer.business_name,
                                                          maxLines: 1,
                                                          style: FlutterFlowTheme.bodyText1.override(
                                                            fontFamily: 'Poppins',
                                                            fontSize: 24,
                                                            fontWeight: FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                        )
                                    );

                                  }
                              );
                            }
                          }),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 5.0, bottom: 5.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                      child: CustomButtonPrimary(
                          content: AutoSizeText(
                            'Chiudi',
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          color: Colors.red,
                          pressed: () {
                            Navigator.pop(context);
                          }
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );

  }

  @override
  void initState() {
    super.initState();
     SchedulerBinding.instance!.addPostFrameCallback((_) async {
     
      final args = ModalRoute.of(context)!.settings.arguments as DettagliSpedizioneWidgetArg;
      progressiveController.text = args.shipment!.progressive;
      dateController.text = args.shipment!.date;

      selectedCarrier = args.shipment!.carrier;
      carrierController.text = selectedCarrier!.description;

      selectedCustomer = args.shipment!.customer;
      customerController.text = selectedCustomer!.business_name;
  
    });
  }

  void onsubmit() async {

      String date = dateController.text.trim();
      String batch = progressiveController.text.trim();
      String vehicle = vehicleController.text.trim();
      String note = noteController.text.trim();


      if (vehicle.isNotEmpty ) {
        setState(() {
          isLoading = true;
        });

        try {
          final data = await getIt
              .get<Repository>()
              .shipmentRepository!
              .update(
            context,
            shipment!.id,
            selectedCarrier!.id.toString(),
            selectedCustomer!.id.toString(),
            date.toString(),
            vehicle.toString(),
            note.toString(),
          );

          if (data) {
            Navigator.pushNamed(
                context, DettaglioNuovaSpedizioneWidget.ROUTE_NAME,
                arguments: DettaglioNuovaSpedizioneWidgetArg(shipment: shipment));
            showCustomDialog(
              context: context,
              type: CustomDialog.SUCCESS,
              msg: 'Spedizione creata con Successo',
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
                      'Modifica Spedizione' ,
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
                      controller: progressiveController,
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.left,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Progressivo Spedizione',
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: TextFormField(
                      onTap: () {
                        dialogCustomer();
                      },
                      readOnly: true,
                      controller: customerController,
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'Cliente',
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 20, 10, 0),
                    child: TextFormField(
                      onTap: () {
                        dialogCarrier();
                      },
                      readOnly: true,
                      controller: carrierController,
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        labelText: 'Trasportatore',
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

                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      controller: vehicleController,
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
                      ),
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      controller: dateController,
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
                      controller: noteController,
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
                          onPressed: () {
                            
                            onsubmit();
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
