part of 'sign_in_cubit.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {}

class SignInLoading extends SignInState {}

class SignInFailed extends SignInState {
  final String error;

  SignInFailed({required this.error});
}
