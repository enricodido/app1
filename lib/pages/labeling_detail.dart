import 'package:agros_app/model/product.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/get_boxes_type.dart';
import '../blocs/get_customer.dart';
import '../blocs/get_pallet.dart';
import '../blocs/get_product.dart';
import '../blocs/get_team.dart';
import '../components/customDialog.dart';
import '../components/flutter_flow_drop_down.dart';
import '../components/flutter_flow_theme.dart';
import '../components/flutter_flow_widget.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';
import '../model/boxes_type.dart';
import '../model/customers.dart';
import '../model/label.dart';
import '../model/pallet_type.dart';
import '../model/team.dart';
import '../repositories/repository.dart';
import 'labeling.dart';


class DettaglioEtichettaturaWidgetArg {
  DettaglioEtichettaturaWidgetArg({
    required this.label,
  });

  final Label? label;
}


class DettaglioEtichettaturaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/labeling_detail';
  @override
  _DettaglioEtichettaturaWidgetState createState() =>
      _DettaglioEtichettaturaWidgetState();
}

class _DettaglioEtichettaturaWidgetState
    extends State<DettaglioEtichettaturaWidget> {
 
  TextEditingController palletController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController noteController = TextEditingController();


  BoxModel? selectedBox;
  TeamModel? selectedTeam;
  PalletModel? selectedPallet;
  ProductModel? selectedProduct;
  CustomerModel? selectedCustomer;
  Label? label;

  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      
      final args = ModalRoute.of(context)!.settings.arguments as DettaglioEtichettaturaWidgetArg;
      palletController.text = args.label!.progressive!;
      dateController.text = args.label!.date;
      batchController.text = args.label!.batch!;
      numberController.text = args.label!.number;
      selectedProduct = args.label!.product;
    //  selectedPallet = args.label!.pallet;
      selectedTeam = args.label!.team;
    //  selectedCustomer = args.label!.customer;
    //  selectedBox = args.label!.box;
       if (args.label?.total_weight != null) {
        weightController.text = args.label!.total_weight!;
      }   
       if (args.label?.note != null) {
        noteController.text = args.label!.note!;
      }   
      
    });
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    
  }

  void onsubmit() async {

    String date = dateController.text.trim();
    String batch = batchController.text.trim();
    String weight = weightController.text.trim();
    String number = numberController.text.trim();
    String note = noteController.text.trim();
    String progressive = palletController.text.trim();

    
    if(date.isNotEmpty && batch.isNotEmpty) {

      setState(() {
        isLoading = true;
      });

      try {
        final data = await getIt.get<Repository>().labelRepository!.record(
          context,
          selectedProduct!.id.toString(),
          selectedPallet!.id.toString() ,
          date.toString()  ,
          batch.toString() ,
          weight.toString() ,
          number.toString(),
          selectedCustomer!.id.toString(),
          note.toString() ,
          selectedBox!.id.toString(),
          selectedTeam!.id.toString(),
          );
        if(data) {

          Navigator.pushNamed(
              context, EtichettaturaWidget.ROUTE_NAME);
          showCustomDialog(
            context: context,
            type: CustomDialog.SUCCESS,
            msg:  'Bancale caricato con Successo',
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
        backgroundColor: FlutterFlowTheme.primaryColor,
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
                      'Modifica etichettatura ' ,
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
                      textAlign: TextAlign.center,
                      enabled: false,
                      controller: palletController,
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
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                      ),
                    ),
                  ),
                 BlocBuilder<GetPalletBloc, GetPalletBlocState>(
                    builder: (context, state) {
                      if (state is GetPalletBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<PalletModel> pallets =
                            (state as GetPalletBlocStateLoaded).pallets;
                        

                        if (pallets.isNotEmpty) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),

                            ),
                            child: DropdownButton<PalletModel>(
                              hint: Text('Seleziona Tipo di Bancale'),
                              isExpanded: true,
                              value: selectedPallet,
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
                              onChanged: (PalletModel? value) {
                                setState(() {
                                  print(value);
                                  selectedPallet = value;
                                });
                              },
                              items: pallets.map<DropdownMenuItem<PalletModel>>(
                                      (PalletModel pallet) {
                                    return DropdownMenuItem<PalletModel>(
                                      value: pallet,
                                      child: Text(
                                        pallet.description,
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
                          return Text('Nessun Tipo di Bancale');
                        }
                      }
                    },
                  ),
                 BlocBuilder<GetProductBloc, GetProductBlocState>(
                    builder: (context, state) {
                      if (state is GetProductBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<ProductModel> products =
                            (state as GetProductBlocStateLoaded).products;
                        // Vehicle? selectedVehicle = (state as GetVehicleBlocStateLoaded).selectedVehicle;
                        // print(selectedVehicle?.description);

                        if (products.isNotEmpty) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),

                            ),
                            child: DropdownButton<ProductModel>(
                              hint: Text('Seleziona Tipo di Prodotto'),
                              isExpanded: true,
                              value: selectedProduct,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 25,
                              elevation: 16,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                              underline: Container(
                                height: 1,
                                color: Colors.black,
                              ),
                              onChanged: (ProductModel? value) {
                                setState(() {
                                  print(value);
                                  selectedProduct = value;
                                });
                              },
                              items: products.map<DropdownMenuItem<ProductModel>>(
                                      (ProductModel product) {
                                    return DropdownMenuItem<ProductModel>(
                                      value: product,
                                      child: Text(
                                        product.description + ' ' + product.variety,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                            color:  Colors.black,
                                            fontFamily: 'Open Sans'),
                                      ),
                                    );
                                  }).toList(),
                            ),
                          );
                        } else {
                          return Text('Nessun Tipo di Prodotto');
                        }
                      }
                    },
                  ),
                  BlocBuilder<GetBoxesBloc, GetBoxesBlocState>(
                    builder: (context, state) {
                      if (state is GetBoxesBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<BoxModel> boxes =
                            (state as GetBoxesBlocStateLoaded).boxes;
                        // Vehicle? selectedVehicle = (state as GetVehicleBlocStateLoaded).selectedVehicle;
                        // print(selectedVehicle?.description);

                        if (boxes.isNotEmpty) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),

                            ),
                            child: DropdownButton<BoxModel>(
                              hint: Text('Seleziona Tipo di Cassette'),
                              isExpanded: true,
                              value: selectedBox,
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
                              onChanged: (BoxModel? value) {
                                setState(() {
                                  print(value);
                                  selectedBox = value;
                                });
                              },
                              items: boxes.map<DropdownMenuItem<BoxModel>>(
                                  (BoxModel box) {
                                return DropdownMenuItem<BoxModel>(
                                  value: box,
                                  child: Text(
                                    box.description,
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
                          return Text('Nessun Tipo di Cassetta');
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
                        labelText: 'Data di raccolta',
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
                      controller: batchController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'n° lotto',
                        hintText: 'n° lotto',
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
                      controller: weightController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Peso',
                        hintText: 'Peso',
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
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: FlutterFlowDropDown(
                      initialOption: 'Unità di misura',
                      options: [],
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
                      controller: numberController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Numero casse',
                        hintText: 'Numero casse',
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
                              hint: Text('Seleziona Proprietario Cassette'),
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
                          return Text('Nessun Proprietario Cassette');
                        }
                      }
                    },
                  ),
                  BlocBuilder<GetTeamBloc, GetTeamBlocState>(
                    builder: (context, state) {
                      if (state is GetTeamBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<TeamModel> teams =
                            (state as GetTeamBlocStateLoaded).teams;
                        // Vehicle? selectedVehicle = (state as GetVehicleBlocStateLoaded).selectedVehicle;
                        // print(selectedVehicle?.description);

                        if (teams.isNotEmpty) {
                          return Container(
                            margin: EdgeInsetsDirectional.fromSTEB(12, 4, 12, 4),
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.black),

                            ),
                            child: DropdownButton<TeamModel>(
                              borderRadius: BorderRadius.circular(50),

                              hint: Text('Seleziona Squadra'),
                              isExpanded: true,
                              value: selectedTeam,
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
                              onChanged: (TeamModel? value) {
                                setState(() {
                                  print(value);
                                  selectedTeam = value;
                                });
                              },
                              items: teams.map<DropdownMenuItem<TeamModel>>(
                                      (TeamModel team) {
                                    return DropdownMenuItem<TeamModel>(
                                      value: team,
                                      child: Text(
                                        team.description,
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
                          return Text('Nessuna Squadra');
                        }
                      }
                    },
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
                            color: FlutterFlowTheme.primaryColor,
                            textStyle: FlutterFlowTheme.subtitle2.override(
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
