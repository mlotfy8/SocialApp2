import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  var name, url;
  LoginCubit() : super(LoginInitial());
  Login({required String email, required String pass}) async {
    emit(LoginLoading());
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailed(error: 'No user found for that email'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailed(error: 'Wrong password provided for that user'));
      }
    }
  }
}
