import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/get_label.dart';
import '../components/flutter_flow_theme.dart';
import '../main.dart';
import '../repositories/repository.dart';
import '../theme/color.dart';
import 'labeling_detail.dart';
import 'login.dart';
import 'new_labeling.dart';

class EtichettaturaWidget extends StatefulWidget {
  static const ROUTE_NAME = '/labeling';
  @override
  _EtichettaturaWidgetState createState() => _EtichettaturaWidgetState();
}

class _EtichettaturaWidgetState extends State<EtichettaturaWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      BlocProvider.of<GetLabelBloc>(context).add(GetLabelBlocRefreshEvent());
      BlocProvider.of<GetLabelBloc>(context).add(GetLabelBlocGetEvent());
    });
  }

  void logout(BuildContext context) {
    getIt.get<Repository>().sessionRepository!.logout();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPageWidget.ROUTE_NAME, ModalRoute.withName('/'));
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
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NuovaEtichettaturaWidget(),
            ),
          );
        },
        backgroundColor: FlutterFlowTheme.primaryColor,
        icon: Icon(
          Icons.add,
          color: Colors.white,
          size: 20,
        ),
        elevation: 8,
        label: Text(
          'Aggiungi',
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 20),
                    child: Text(
                      'Etichettatura',
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  BlocBuilder<GetLabelBloc, GetLabelBlocState>(
                      builder: (context, state) {
                    if (state is GetLabelBlocStateLoading)
                      return Center(child: CircularProgressIndicator());
                    else {
                      final labels = (state as GetLabelBlocStateLoaded).labels;
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
                                      DettaglioEtichettaturaWidget.ROUTE_NAME
                                    );
                                  },
                                  child: Card(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    color: Color(0xFFF5F5F5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 10),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 5),
                                            child: Text(
                                              'Dettagli etichettatura ' + label.progressive,

                                              style: FlutterFlowTheme.bodyText1
                                                  .override(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            color: Color(0xFF6C6C6C),
                                          ),
                                          Text(
                                            'Lotto: ' +  label.batch + '\n'
                                            'Prodotto: ' + label.product.description + '\n'
                                            'Peso: ' + label.total_weight + ' kg\n'
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
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
