import 'package:dairy_app/features/auth/data/datasources/remote%20data%20sources/remote_data_source_template.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RemoteDataSource implements IRemoteDataSource {
  @override
  Future<LoggedInUserModel> signUpUser(
      {required String email, required String password}) async {
    var credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return LoggedInUserModel(id: credential.user?.uid as String, email: email);
  }

  @override
  Future<LoggedInUserModel> signInUser(
      {required String email, required String password}) async {
    var credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return LoggedInUserModel(id: credential.user?.uid as String, email: email);
  }
}
