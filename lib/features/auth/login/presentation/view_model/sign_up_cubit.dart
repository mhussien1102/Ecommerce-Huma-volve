import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/sign_up_req_model.dart';
import '../../domain/use_case/sign_up_use_case.dart';
import 'sign_up_states.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  final SignUpUseCase signUpUseCase;

  SignUpCubit({required this.signUpUseCase}) : super(SignUpInitial());

  Future<void> signUp(SignUpReqModel request) async {
    emit(SignUpLoading());
    final result = await signUpUseCase.invoke(request);
    result.fold(
          (failure) => emit(SignUpError(errorMessage: failure.errorMessage)),
          (data) => emit(SignUpSuccess(signUpEntity: data)),
    );
  }
}