import 'package:cloud_firestore/cloud_firestore.dart' show FirebaseFirestore;
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_storage/firebase_storage.dart' show FirebaseStorage;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/repositories/auth_repository.dart';
import '../data/repositories/email_repository.dart';
import '../data/repositories/firestore_repository.dart';
import '../data/repositories/storage_repository.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(FirebaseAuth.instance),
);

final firestoreRepositoryProvider = Provider(
  (ref) => FirestoreRepository(FirebaseFirestore.instance),
);

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(FirebaseStorage.instance),
);

final emailRepositoryProvider = Provider((ref) => EmailRepository());
