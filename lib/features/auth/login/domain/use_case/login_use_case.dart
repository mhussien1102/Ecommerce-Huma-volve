import 'package:dartz/dartz.dart';

import '../../../../../core/failure/fauiler.dart';
import '../entites/login_entity.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginEntity>> invoke({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
