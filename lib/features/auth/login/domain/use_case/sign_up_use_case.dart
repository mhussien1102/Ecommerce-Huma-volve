import 'package:dartz/dartz.dart';

import '../../../../../core/failure/fauiler.dart';
import '../../data/models/sign_up_req_model.dart';
import '../entites/sign_up_entity.dart';
import '../repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<Either<Failure, SignUpEntity>> invoke(SignUpReqModel request) {
    return repository.signUp(request);
  }
}
