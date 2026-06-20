import 'package:firebase_core/firebase_core.dart';

class FirebaseCoreService {
  FirebaseApp? _app;

  Future<FirebaseApp> initialize() async {
    _app ??= await Firebase.initializeApp();
    return _app!;
  }
}
