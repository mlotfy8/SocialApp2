import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  SignIn({required String email, required String pass}) async {
    emit(SignInLoading());
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      emit(SignInSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignInFailed(error: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignInFailed(error: 'The account already exists for that email'));
      }
    } catch (e) {
      emit(SignInFailed(error: '$e'));
    }
  }
}
