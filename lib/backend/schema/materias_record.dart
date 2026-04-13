import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class MateriasRecord extends FirestoreRecord {
  MateriasRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "nombreMateria" field.
  String? _nombreMateria;
  String get nombreMateria => _nombreMateria ?? '';
  bool hasNombreMateria() => _nombreMateria != null;

  // "codigo" field.
  String? _codigo;
  String get codigo => _codigo ?? '';
  bool hasCodigo() => _codigo != null;

  // "nombreProfesor" field.
  String? _nombreProfesor;
  String get nombreProfesor => _nombreProfesor ?? '';
  bool hasNombreProfesor() => _nombreProfesor != null;

  // "horario" field.
  String? _horario;
  String get horario => _horario ?? '';
  bool hasHorario() => _horario != null;

  void _initializeFields() {
    _nombreMateria = snapshotData['nombreMateria'] as String?;
    _codigo = snapshotData['codigo'] as String?;
    _nombreProfesor = snapshotData['nombreProfesor'] as String?;
    _horario = snapshotData['horario'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('materias');

  static Stream<MateriasRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => MateriasRecord.fromSnapshot(s));

  static Future<MateriasRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => MateriasRecord.fromSnapshot(s));

  static MateriasRecord fromSnapshot(DocumentSnapshot snapshot) =>
      MateriasRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static MateriasRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      MateriasRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'MateriasRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is MateriasRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createMateriasRecordData({
  String? nombreMateria,
  String? codigo,
  String? nombreProfesor,
  String? horario,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'nombreMateria': nombreMateria,
      'codigo': codigo,
      'nombreProfesor': nombreProfesor,
      'horario': horario,
    }.withoutNulls,
  );

  return firestoreData;
}

class MateriasRecordDocumentEquality implements Equality<MateriasRecord> {
  const MateriasRecordDocumentEquality();

  @override
  bool equals(MateriasRecord? e1, MateriasRecord? e2) {
    return e1?.nombreMateria == e2?.nombreMateria &&
        e1?.codigo == e2?.codigo &&
        e1?.nombreProfesor == e2?.nombreProfesor &&
        e1?.horario == e2?.horario;
  }

  @override
  int hash(MateriasRecord? e) => const ListEquality()
      .hash([e?.nombreMateria, e?.codigo, e?.nombreProfesor, e?.horario]);

  @override
  bool isValidKey(Object? o) => o is MateriasRecord;
}
