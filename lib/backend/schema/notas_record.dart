import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class NotasRecord extends FirestoreRecord {
  NotasRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nota" field.
  double? _nota;
  double get nota => _nota ?? 0.0;
  bool hasNota() => _nota != null;

  // "notaMaxima" field.
  double? _notaMaxima;
  double get notaMaxima => _notaMaxima ?? 0.0;
  bool hasNotaMaxima() => _notaMaxima != null;

  // "tareaRef" field.
  DocumentReference? _tareaRef;
  DocumentReference? get tareaRef => _tareaRef;
  bool hasTareaRef() => _tareaRef != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "estado" field.
  String? _estado;
  String get estado => _estado ?? '';
  bool hasEstado() => _estado != null;

  void _initializeFields() {
    _nota = castToType<double>(snapshotData['nota']);
    _notaMaxima = castToType<double>(snapshotData['notaMaxima']);
    _tareaRef = snapshotData['tareaRef'] as DocumentReference?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _estado = snapshotData['estado'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('notas');

  static Stream<NotasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => NotasRecord.fromSnapshot(s));

  static Future<NotasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => NotasRecord.fromSnapshot(s));

  static NotasRecord fromSnapshot(DocumentSnapshot snapshot) => NotasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static NotasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      NotasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'NotasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is NotasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createNotasRecordData({
  double? nota,
  double? notaMaxima,
  DocumentReference? tareaRef,
  DocumentReference? userRef,
  String? estado,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nota': nota,
      'notaMaxima': notaMaxima,
      'tareaRef': tareaRef,
      'userRef': userRef,
      'estado': estado,
    }.withoutNulls,
  );

  return firestoreData;
}

class NotasRecordDocumentEquality implements Equality<NotasRecord> {
  const NotasRecordDocumentEquality();

  @override
  bool equals(NotasRecord? e1, NotasRecord? e2) {
    return e1?.nota == e2?.nota &&
        e1?.notaMaxima == e2?.notaMaxima &&
        e1?.tareaRef == e2?.tareaRef &&
        e1?.userRef == e2?.userRef &&
        e1?.estado == e2?.estado;
  }

  @override
  int hash(NotasRecord? e) => const ListEquality()
      .hash([e?.nota, e?.notaMaxima, e?.tareaRef, e?.userRef, e?.estado]);

  @override
  bool isValidKey(Object? o) => o is NotasRecord;
}
