part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

final class SignInInitial extends SignInState {}

class SignInSuccess extends SignInState {
  final String userId;

  SignInSuccess({required this.userId});

  @override
  String toString() {
    return 'SignInSuccess(userId: $userId)';
  }
}

class SignInFailure extends SignInState {
  final String? message;

  const SignInFailure({this.message});
}

class SignInProcess extends SignInState {}
