import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EntregasRecord extends FirestoreRecord {
  EntregasRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "tarea" field.
  DocumentReference? _tarea;
  DocumentReference? get tarea => _tarea;
  bool hasTarea() => _tarea != null;

  // "estatus" field.
  String? _estatus;
  String get estatus => _estatus ?? '';
  bool hasEstatus() => _estatus != null;

  // "calificacion" field.
  double? _calificacion;
  double get calificacion => _calificacion ?? 0.0;
  bool hasCalificacion() => _calificacion != null;

  // "horaEntregada" field.
  DateTime? _horaEntregada;
  DateTime? get horaEntregada => _horaEntregada;
  bool hasHoraEntregada() => _horaEntregada != null;

  void _initializeFields() {
    _tarea = snapshotData['tarea'] as DocumentReference?;
    _estatus = snapshotData['estatus'] as String?;
    _calificacion = castToType<double>(snapshotData['calificacion']);
    _horaEntregada = snapshotData['horaEntregada'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('entregas');

  static Stream<EntregasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EntregasRecord.fromSnapshot(s));

  static Future<EntregasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EntregasRecord.fromSnapshot(s));

  static EntregasRecord fromSnapshot(DocumentSnapshot snapshot) =>
      EntregasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EntregasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EntregasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EntregasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EntregasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEntregasRecordData({
  DocumentReference? tarea,
  String? estatus,
  double? calificacion,
  DateTime? horaEntregada,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'tarea': tarea,
      'estatus': estatus,
      'calificacion': calificacion,
      'horaEntregada': horaEntregada,
    }.withoutNulls,
  );

  return firestoreData;
}

class EntregasRecordDocumentEquality implements Equality<EntregasRecord> {
  const EntregasRecordDocumentEquality();

  @override
  bool equals(EntregasRecord? e1, EntregasRecord? e2) {
    return e1?.tarea == e2?.tarea &&
        e1?.estatus == e2?.estatus &&
        e1?.calificacion == e2?.calificacion &&
        e1?.horaEntregada == e2?.horaEntregada;
  }

  @override
  int hash(EntregasRecord? e) => const ListEquality()
      .hash([e?.tarea, e?.estatus, e?.calificacion, e?.horaEntregada]);

  @override
  bool isValidKey(Object? o) => o is EntregasRecord;
}
