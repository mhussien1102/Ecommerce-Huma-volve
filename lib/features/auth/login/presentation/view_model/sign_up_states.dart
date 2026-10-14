
import '../../domain/entites/sign_up_entity.dart';

abstract class SignUpStates {}

class SignUpInitial extends SignUpStates {}

class SignUpLoading extends SignUpStates {}

class SignUpSuccess extends SignUpStates {
  final SignUpEntity signUpEntity;
  SignUpSuccess({required this.signUpEntity});
}

class SignUpError extends SignUpStates {
  final String errorMessage;
  SignUpError({required this.errorMessage});
}