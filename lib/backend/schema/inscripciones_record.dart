import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InscripcionesRecord extends FirestoreRecord {
  InscripcionesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  // "materiaId" field.
  DocumentReference? _materiaId;
  DocumentReference? get materiaId => _materiaId;
  bool hasMateriaId() => _materiaId != null;

  void _initializeFields() {
    _userId = snapshotData['userId'] as String?;
    _materiaId = snapshotData['materiaId'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('inscripciones');

  static Stream<InscripcionesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => InscripcionesRecord.fromSnapshot(s));

  static Future<InscripcionesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => InscripcionesRecord.fromSnapshot(s));

  static InscripcionesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      InscripcionesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static InscripcionesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      InscripcionesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'InscripcionesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is InscripcionesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createInscripcionesRecordData({
  String? userId,
  DocumentReference? materiaId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userId': userId,
      'materiaId': materiaId,
    }.withoutNulls,
  );

  return firestoreData;
}

class InscripcionesRecordDocumentEquality
    implements Equality<InscripcionesRecord> {
  const InscripcionesRecordDocumentEquality();

  @override
  bool equals(InscripcionesRecord? e1, InscripcionesRecord? e2) {
    return e1?.userId == e2?.userId && e1?.materiaId == e2?.materiaId;
  }

  @override
  int hash(InscripcionesRecord? e) =>
      const ListEquality().hash([e?.userId, e?.materiaId]);

  @override
  bool isValidKey(Object? o) => o is InscripcionesRecord;
}
