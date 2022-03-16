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
 
  String? customerId;
  String? teamId;
  String? palletId;
  String? boxId;
  String? productId;


  bool isLoading = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
     DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      BlocProvider.of<GetBoxesBloc>(context).add(GetBoxesBlocRefreshEvent());
      BlocProvider.of<GetBoxesBloc>(context).add(GetBoxesBlocGetEvent());

      BlocProvider.of<GetTeamBloc>(context).add(GetTeamBlocRefreshEvent());
      BlocProvider.of<GetTeamBloc>(context).add(GetTeamBlocGetEvent());

      BlocProvider.of<GetPalletBloc>(context).add(GetPalletBlocRefreshEvent());
      BlocProvider.of<GetPalletBloc>(context).add(GetPalletBlocGetEvent());

      BlocProvider.of<GetProductBloc>(context).add(GetProductBlocRefreshEvent());
      BlocProvider.of<GetProductBloc>(context).add(GetProductBlocGetEvent());

      BlocProvider.of<GetCustomerBloc>(context).add(GetCustomerBlocRefreshEvent());
      BlocProvider.of<GetCustomerBloc>(context).add(GetCustomerBlocGetEvent());
      dateController = TextEditingController(text: formattedDate);
      setState(() {
        
     
      final args = ModalRoute.of(context)!.settings.arguments as DettaglioEtichettaturaWidgetArg;
      palletController.text = args.label!.progressive!;
      dateController.text = args.label!.date;
      batchController.text = args.label!.batch!;
      numberController.text = args.label!.number;
  
      productId =  args.label!.product!.id;
      boxId =  args.label!.box.id;
      palletId = args.label!.pallet.id;
      teamId = args.label!.team!.id;
      customerId = args.label!.customer.id;
    //  selectedCustomer = args.label!.customer;
      
       if (args.label?.total_weight != null) {
        weightController.text = args.label!.total_weight!;
      }   
       if (args.label?.note != null) {
        noteController.text = args.label!.note!;
      }   

    
       });
     
      print(selectedProduct!.id);
      print(selectedPallet!.id);
      print(dateController);
      print(batchController);
      print(weightController);
       print(selectedCustomer!.id);
      print(selectedBox!.id);
      print(selectedTeam!.id);
      print(numberController);
      print(noteController);
    });
  
    
    
  }

  void onsubmit() async {

    String date = dateController.text.trim();
    String batch = batchController.text.trim();
    String weight = weightController.text.trim();
    String number = numberController.text.trim();
    String note = noteController.text.trim();
 //   String progressive = palletController.text.trim();

    
    if(selectedCustomer != null) {

      setState(() {
        isLoading = true;
      });
      print(selectedProduct!.id);
      print(selectedPallet!.id);
      print(dateController);
      print(batchController);
      print(weightController);
       print(selectedCustomer!.id);
      print(selectedBox!.id);
      print(selectedTeam!.id);
      print(numberController);
      print(noteController);
      try {
        final data = await getIt.get<Repository>().labelRepository!.recupdate(
          context,
          label!.id,
          selectedProduct!.id.toString(),
          selectedPallet!.id.toString() ,
          date.toString()  ,
          batch.toString() ,
          weight.toString() ,
          selectedCustomer!.id.toString(),
          selectedBox!.id.toString(),
          selectedTeam!.id.toString(),
          number.toString(),
          note.toString() ,
          
          
          );
          
        if(data) {

          Navigator.pushNamed(
              context, EtichettaturaWidget.ROUTE_NAME);
          showCustomDialog(
            context: context,
            type: CustomDialog.SUCCESS,
            msg:  'Bancale aggiornato con Successo',
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
                      textAlign: TextAlign.left,
                      readOnly: true,
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
                         String val = palletId!;
                        if(pallets.length > 0) {
                            pallets.forEach((pallet) {                         
                              if(val == pallet.id) {                              
                                  selectedPallet = pallet;                         
                              }
                            });
                          }

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
                                  palletId = selectedPallet!.id;
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
                        String val = productId!;
                        if(products.length > 0) {
                            products.forEach((product) {                         
                              if(val == product.id) {                              
                                  selectedProduct = product;                         
                              }
                            });
                          }
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
                                  productId = selectedProduct!.id;
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
                        String val = boxId!;
                        if(boxes.length > 0) {
                            boxes.forEach((box) {                         
                              if(val == box.id) {                              
                                  selectedBox = box;                         
                              }
                            });
                          }
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
                                  boxId = selectedBox!.id;
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
                            print(customers);                        
                        String val = customerId!;
                        if(customers.length > 0) {
                            customers.forEach((customer) {                         
                              if(val == customer.id) {                              
                                  selectedCustomer = customer;                         
                              }
                            });
                          }
                          
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
                                  customerId = selectedCustomer!.id;
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
                       
                        String val = teamId!;
                        if(teams.length > 0) {
                            teams.forEach((team) {                         
                              if(val == team.id) {                              
                                  selectedTeam = team;                         
                              }
                            });
                          }
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
                                  teamId = selectedTeam!.id;
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
