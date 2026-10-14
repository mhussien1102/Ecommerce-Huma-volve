import 'package:dartz/dartz.dart';

import '../../../../../core/failure/fauiler.dart';
import '../../data/models/sign_up_req_model.dart';
import '../entites/login_entity.dart';
import '../entites/sign_up_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, SignUpEntity>> signUp(SignUpReqModel request);
}