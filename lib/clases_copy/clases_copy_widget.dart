import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'clases_copy_model.dart';
export 'clases_copy_model.dart';

class ClasesCopyWidget extends StatefulWidget {
  const ClasesCopyWidget({super.key});

  static String routeName = 'clasesCopy';
  static String routePath = '/clasesCopy';

  @override
  State<ClasesCopyWidget> createState() => _ClasesCopyWidgetState();
}

class _ClasesCopyWidgetState extends State<ClasesCopyWidget> {
  late ClasesCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClasesCopyModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            StreamBuilder<List<InscripcionesRecord>>(
              stream: queryInscripcionesRecord(
                queryBuilder: (inscripcionesRecord) =>
                    inscripcionesRecord.where(
                  'userId',
                  isEqualTo: currentUserUid,
                ),
              ),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                    ),
                  );
                }
                List<InscripcionesRecord> listViewInscripcionesRecordList =
                    snapshot.data!;

                return ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewInscripcionesRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewInscripcionesRecord =
                        listViewInscripcionesRecordList[listViewIndex];
                    return StreamBuilder<List<MateriasRecord>>(
                      stream: queryMateriasRecord(
                        singleRecord: true,
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<MateriasRecord>
                            subjectCardWidgetMateriasRecordList =
                            snapshot.data!;
                        // Return an empty Container when the item does not exist.
                        if (snapshot.data!.isEmpty) {
                          return Container();
                        }
                        final subjectCardWidgetMateriasRecord =
                            subjectCardWidgetMateriasRecordList.isNotEmpty
                                ? subjectCardWidgetMateriasRecordList.first
                                : null;

                        return InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            context.pushNamed(
                              DetalleClaseWidget.routeName,
                              queryParameters: {
                                'materias': serializeParam(
                                  subjectCardWidgetMateriasRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 0.18,
                            child: custom_widgets.SubjectCardWidget(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.18,
                              subjectName: subjectCardWidgetMateriasRecord!
                                  .nombreMateria,
                              subjectCode:
                                  subjectCardWidgetMateriasRecord.codigo,
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
