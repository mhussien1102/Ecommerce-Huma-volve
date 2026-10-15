import '../../domain/entites/login_entity.dart';

abstract class LoginStates {}

class LoginInitial extends LoginStates {}

class LoginLoading extends LoginStates {}

class LoginSuccess extends LoginStates {
  final LoginEntity loginEntity;
  LoginSuccess({required this.loginEntity});
}

class LoginError extends LoginStates {
  final String errorMessage;
  LoginError({required this.errorMessage});
}
