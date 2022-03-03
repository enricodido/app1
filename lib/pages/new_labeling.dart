import 'package:agros_app/blocs/get_boxes_type.dart';
import 'package:agros_app/model/boxes_type.dart';
import 'package:agros_app/model/pallet_type.dart';
import 'package:agros_app/model/product.dart';
import 'package:agros_app/model/team.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/get_customer.dart';
import '../blocs/get_pallet.dart';
import '../blocs/get_product.dart';
import '../blocs/get_team.dart';
import '../components/flutter_flow_drop_down.dart';
import '../components/flutter_flow_theme.dart';
import '../components/flutter_flow_widget.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/customers.dart';
import 'labeling.dart';

class NuovaEtichettaturaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/new_labeling';
  @override
  _NuovaEtichettaturaWidgetState createState() =>
      _NuovaEtichettaturaWidgetState();
}

class _NuovaEtichettaturaWidgetState extends State<NuovaEtichettaturaWidget> {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;
  late TextEditingController textController4;
  late TextEditingController textController5;
  late TextEditingController textController6;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  BoxModel? selectedBox;
  TeamModel? selectedTeam;
  PalletModel? selectedPallet;
  ProductModel? selectedProduct;
  CustomerModel? selectedCustomer;


  @override
  void initState() {
    super.initState();
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
    });


    textController1 = TextEditingController(text: 'Calcolato in automatico');
    textController2 = TextEditingController(text: 'data messa automaticamente');
    textController3 = TextEditingController(text: 'Esempio: 342');
    textController4 = TextEditingController(text: 'Esempio: 150');
    textController5 = TextEditingController(text: 'Esempio: 5');
    textController6 =
        TextEditingController(text: 'Questo lotto ha questo dettaglio...');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                    child: Text(
                      'Nuova etichettatura',
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
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController1',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      controller: textController1,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Progressivo Pedana per lotto',
                        hintText: 'Calcolato in automatico',
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
                        suffixIcon: textController1.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController1.clear(),
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
                  BlocBuilder<GetPalletBloc, GetPalletBlocState>(
                    builder: (context, state) {
                      if (state is GetPalletBlocStateLoading)
                        return Center(child: CircularProgressIndicator());
                      else {
                        List<PalletModel> pallets =
                            (state as GetPalletBlocStateLoaded).pallets;
                        // Vehicle? selectedVehicle = (state as GetVehicleBlocStateLoaded).selectedVehicle;
                        // print(selectedVehicle?.description);

                        if (pallets.isNotEmpty) {
                          return DropdownButton<PalletModel>(
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
                              height: 2,
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
                          return DropdownButton<ProductModel>(
                            hint: Text('Seleziona Tipo di Prodotto'),
                            isExpanded: true,
                            value: selectedProduct,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 25,
                            elevation: 16,
                            style: const TextStyle(
                              color:  Color(0xFF009648),
                              fontSize: 20,
                            ),
                            underline: Container(
                              height: 2,
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
                                          color:  Color(0xFF009648),
                                          fontFamily: 'Open Sans'),
                                    ),
                                  );
                                }).toList(),
                          );
                        } else {
                          return Text('Nessun Tipo di Prodotto');
                        }
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController2',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      controller: textController2,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Data di raccolta',
                        hintText: 'data messa automaticamente',
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
                        suffixIcon: textController2.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController2.clear(),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController3',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      controller: textController3,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'n° lotto',
                        hintText: 'Esempio: 342',
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
                        suffixIcon: textController3.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController3.clear(),
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
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 15, 10, 0),
                    child: TextFormField(
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController4',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      controller: textController4,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Peso',
                        hintText: 'Esempio: 150',
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
                        suffixIcon: textController4.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController4.clear(),
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
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
                    child: FlutterFlowDropDown(
                      initialOption: 'Seleziona',
                      options: ['KG', 'Tonnellate'].toList(),
                      onChanged: (val) => setState(() => val),
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      textStyle: FlutterFlowTheme.bodyText1.override(
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
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController5',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      controller: textController5,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Numero casse',
                        hintText: 'Esempio: 5',
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
                        suffixIcon: textController5.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController5.clear(),
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
                      keyboardType: TextInputType.number,
                    ),
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
                          return DropdownButton<BoxModel>(
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
                              height: 2,
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
                          );
                        } else {
                          return Text('Nessun Tipo di Cassetta');
                        }
                      }
                    },
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
                          return DropdownButton<CustomerModel>(
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
                              height: 2,
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
                          return DropdownButton<TeamModel>(
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
                      onChanged: (_) => EasyDebounce.debounce(
                        'textController6',
                        Duration(milliseconds: 2000),
                        () => setState(() {}),
                      ),
                      controller: textController6,
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
                        suffixIcon: textController6.text.isNotEmpty
                            ? InkWell(
                                onTap: () => setState(
                                  () => textController6.clear(),
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
                        FFButtonWidget(
                          onPressed: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EtichettaturaWidget(),
                              ),
                            );
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
