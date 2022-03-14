import 'package:agros_app/pages/shipment.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/get_carrier.dart';
import '../blocs/get_customer.dart';
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

class NuovaSpedizioneWidget extends StatefulWidget {
  static const ROUTE_NAME = '/new_shipment';
  @override
  _NuovaSpedizioneWidgetState createState() => _NuovaSpedizioneWidgetState();
}

class _NuovaSpedizioneWidgetState extends State<NuovaSpedizioneWidget> {

  TextEditingController progressiveController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController vehicleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  CustomerModel? selectedCustomer;
  CarrierModel? selectedCarrier;
  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy HH:mm').format(now);
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      BlocProvider.of<GetCarrierBloc>(context).add(GetCarrierBlocRefreshEvent());
      BlocProvider.of<GetCarrierBloc>(context).add(GetCarrierBlocGetEvent());

      BlocProvider.of<GetCustomerBloc>(context).add(GetCustomerBlocRefreshEvent());
      BlocProvider.of<GetCustomerBloc>(context).add(GetCustomerBlocGetEvent());
      dateController = TextEditingController(text: formattedDate);
    });

  }

  void onsubmit() async {
    String date = dateController.text.trim();
    String batch = progressiveController.text.trim();
    String vehicle = vehicleController.text.trim();
    String note = noteController.text.trim();

 print(selectedCarrier!.id);
print(selectedCustomer!.id);
print(date);
print(vehicle);
print(note);


    if (vehicle.isNotEmpty ) {
      setState(() {
        isLoading = true;
      });

      try {
        final data = await getIt
            .get<Repository>()
            .shipmentRepository!
            .record(
          context,
          selectedCarrier!.id.toString(),
          selectedCustomer!.id.toString(),
          date.toString(),
          vehicle.toString(),
          note.toString(),
        );
       
        if (data) {
          Navigator.pushNamed(
              context, DettaglioNuovaSpedizioneWidget.ROUTE_NAME);
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
                      controller: progressiveController,
                      obscureText: false,
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
                  BlocBuilder<GetCarrierBloc, GetCarrierBlocState>(
                    builder: (context, state) {
                      if (state is GetCarrierBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<CarrierModel> carriers =
                            (state as GetCarrierBlocStateLoaded).carriers;
                        // Vehicle? selectedVehicle = (state as GetVehicleBlocStateLoaded).selectedVehicle;
                        // print(selectedVehicle?.description);

                        if (carriers.isNotEmpty) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),

                            ),
                            child: DropdownButton<CarrierModel>(
                              hint: Text('Seleziona Tipo di Bancale'),
                              isExpanded: true,
                              value: selectedCarrier,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 25,
                              elevation: 16,
                              style: const TextStyle(
                                color:  Color(0xFF009648),
                                fontSize: 20,
                              ),
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              onChanged: (CarrierModel? value) {
                                setState(() {
                                  print(value);
                                  selectedCarrier = value;
                                });
                              },
                              items: carriers.map<DropdownMenuItem<CarrierModel>>(
                                      (CarrierModel carrier) {
                                    return DropdownMenuItem<CarrierModel>(
                                      value: carrier,
                                      child: Text(
                                        carrier.description,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color:  Color(0xFF009648),
                                            fontFamily: 'Open Sans'),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          );
                        } else {
                          return Text('Nessun Trasportatore');
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      controller: vehicleController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Targa (opzionale)',
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
                  BlocBuilder<GetCustomerBloc, GetCustomerBlocState>(
                    builder: (context, state) {
                      if (state is GetCustomerBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<CustomerModel> customers =
                            (state as GetCustomerBlocStateLoaded).customers;
                        // Vehicle? selectedVehicle = (state as GetVehicleBlocStateLoaded).selectedVehicle;
                        // print(selectedVehicle?.description);

                        if (customers.isNotEmpty) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),

                            ),
                            child: DropdownButton<CustomerModel>(
                              hint: Text('Seleziona Cliente'),
                              isExpanded: true,
                              value: selectedCustomer,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 25,
                              elevation: 16,
                              style: const TextStyle(
                                color:  Color(0xFF009648),
                                fontSize: 20,
                              ),
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              onChanged: (CustomerModel? value) {
                                setState(() {
                                  print(value);
                                  selectedCustomer = value;
                                });
                              },
                              items: customers.map<DropdownMenuItem<CustomerModel>>(
                                      (CustomerModel customer) {
                                    return DropdownMenuItem<CustomerModel>(
                                      value: customer,
                                      child: Text(
                                        customer.business_name ,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color:  Color(0xFF009648),
                                            fontFamily: 'Open Sans'),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          );
                        } else {
                          return Text('Nessun Cliente');
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(

                      controller: dateController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Data di spedizione',
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
