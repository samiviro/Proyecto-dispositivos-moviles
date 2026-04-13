import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsuariosRecord extends FirestoreRecord {
  UsuariosRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "carrera" field.
  String? _carrera;
  String get carrera => _carrera ?? '';
  bool hasCarrera() => _carrera != null;

  // "nombre" field.
  String? _nombre;
  String get nombre => _nombre ?? '';
  bool hasNombre() => _nombre != null;

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "rol" field.
  String? _rol;
  String get rol => _rol ?? '';
  bool hasRol() => _rol != null;

  // "contrasena" field.
  String? _contrasena;
  String get contrasena => _contrasena ?? '';
  bool hasContrasena() => _contrasena != null;

  void _initializeFields() {
    _email = snapshotData['email'] as String?;
    _uid = snapshotData['uid'] as String?;
    _carrera = snapshotData['carrera'] as String?;
    _nombre = snapshotData['nombre'] as String?;
    _displayName = snapshotData['display_name'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _rol = snapshotData['rol'] as String?;
    _contrasena = snapshotData['contrasena'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('usuarios');

  static Stream<UsuariosRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsuariosRecord.fromSnapshot(s));

  static Future<UsuariosRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsuariosRecord.fromSnapshot(s));

  static UsuariosRecord fromSnapshot(DocumentSnapshot snapshot) =>
      UsuariosRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsuariosRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsuariosRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsuariosRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsuariosRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsuariosRecordData({
  String? email,
  String? uid,
  String? carrera,
  String? nombre,
  String? displayName,
  String? photoUrl,
  DateTime? createdTime,
  String? phoneNumber,
  String? rol,
  String? contrasena,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'email': email,
      'uid': uid,
      'carrera': carrera,
      'nombre': nombre,
      'display_name': displayName,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'phone_number': phoneNumber,
      'rol': rol,
      'contrasena': contrasena,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsuariosRecordDocumentEquality implements Equality<UsuariosRecord> {
  const UsuariosRecordDocumentEquality();

  @override
  bool equals(UsuariosRecord? e1, UsuariosRecord? e2) {
    return e1?.email == e2?.email &&
        e1?.uid == e2?.uid &&
        e1?.carrera == e2?.carrera &&
        e1?.nombre == e2?.nombre &&
        e1?.displayName == e2?.displayName &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.rol == e2?.rol &&
        e1?.contrasena == e2?.contrasena;
  }

  @override
  int hash(UsuariosRecord? e) => const ListEquality().hash([
        e?.email,
        e?.uid,
        e?.carrera,
        e?.nombre,
        e?.displayName,
        e?.photoUrl,
        e?.createdTime,
        e?.phoneNumber,
        e?.rol,
        e?.contrasena
      ]);

  @override
  bool isValidKey(Object? o) => o is UsuariosRecord;
}
