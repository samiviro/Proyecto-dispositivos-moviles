import '/flutter_flow/flutter_flow_util.dart';
import 'entregas_widget.dart' show EntregasWidget;
import 'package:flutter/material.dart';

class EntregasModel extends FlutterFlowModel<EntregasWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for inputSearch widget.
  FocusNode? inputSearchFocusNode;
  TextEditingController? inputSearchTextController;
  String? Function(BuildContext, String?)? inputSearchTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inputSearchFocusNode?.dispose();
    inputSearchTextController?.dispose();
  }
}
