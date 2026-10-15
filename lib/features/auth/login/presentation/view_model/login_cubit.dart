import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/use_case/login_use_case.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginUseCase loginUseCase;

  LoginCubit({required this.loginUseCase}) : super(LoginInitial());

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    final result = await loginUseCase.invoke(email: email, password: password);
    result.fold(
      (failure) => emit(LoginError(errorMessage: failure.errorMessage)),
      (data) => emit(LoginSuccess(loginEntity: data)),
    );
  }
}
