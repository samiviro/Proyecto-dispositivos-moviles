import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TareasRecord extends FirestoreRecord {
  TareasRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "materia" field.
  DocumentReference? _materia;
  DocumentReference? get materia => _materia;
  bool hasMateria() => _materia != null;

  // "titulo" field.
  String? _titulo;
  String get titulo => _titulo ?? '';
  bool hasTitulo() => _titulo != null;

  // "descripcion" field.
  String? _descripcion;
  String get descripcion => _descripcion ?? '';
  bool hasDescripcion() => _descripcion != null;

  // "fechaEntrega" field.
  DateTime? _fechaEntrega;
  DateTime? get fechaEntrega => _fechaEntrega;
  bool hasFechaEntrega() => _fechaEntrega != null;

  // "tiempoEstimado" field.
  DateTime? _tiempoEstimado;
  DateTime? get tiempoEstimado => _tiempoEstimado;
  bool hasTiempoEstimado() => _tiempoEstimado != null;

  void _initializeFields() {
    _materia = snapshotData['materia'] as DocumentReference?;
    _titulo = snapshotData['titulo'] as String?;
    _descripcion = snapshotData['descripcion'] as String?;
    _fechaEntrega = snapshotData['fechaEntrega'] as DateTime?;
    _tiempoEstimado = snapshotData['tiempoEstimado'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('tareas');

  static Stream<TareasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => TareasRecord.fromSnapshot(s));

  static Future<TareasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => TareasRecord.fromSnapshot(s));

  static TareasRecord fromSnapshot(DocumentSnapshot snapshot) => TareasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static TareasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      TareasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'TareasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is TareasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createTareasRecordData({
  DocumentReference? materia,
  String? titulo,
  String? descripcion,
  DateTime? fechaEntrega,
  DateTime? tiempoEstimado,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'materia': materia,
      'titulo': titulo,
      'descripcion': descripcion,
      'fechaEntrega': fechaEntrega,
      'tiempoEstimado': tiempoEstimado,
    }.withoutNulls,
  );

  return firestoreData;
}

class TareasRecordDocumentEquality implements Equality<TareasRecord> {
  const TareasRecordDocumentEquality();

  @override
  bool equals(TareasRecord? e1, TareasRecord? e2) {
    return e1?.materia == e2?.materia &&
        e1?.titulo == e2?.titulo &&
        e1?.descripcion == e2?.descripcion &&
        e1?.fechaEntrega == e2?.fechaEntrega &&
        e1?.tiempoEstimado == e2?.tiempoEstimado;
  }

  @override
  int hash(TareasRecord? e) => const ListEquality().hash([
        e?.materia,
        e?.titulo,
        e?.descripcion,
        e?.fechaEntrega,
        e?.tiempoEstimado
      ]);

  @override
  bool isValidKey(Object? o) => o is TareasRecord;
}
