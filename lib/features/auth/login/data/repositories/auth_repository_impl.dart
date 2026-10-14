import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../core/failure/fauiler.dart';
import '../../domain/entites/login_entity.dart';
import '../../domain/entites/sign_up_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/sign_up_req_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginEntity>> login({
    required String email,
    required String password,
  }) {
    return _handle(
          () => remoteDataSource.login(email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, SignUpEntity>> signUp(SignUpReqModel request) {
    return _handle(() => remoteDataSource.signUp(request));
  }

  // Shared error handling for all auth calls
  Future<Either<Failure, T>> _handle<T>(Future<T> Function() call) async {
    try {
      return Right(await call());
    } on DioException catch (e) {
      final data = e.response?.data;
      final message = data is Map
          ? (data['message']?.toString() ?? 'Something went wrong')
          : (e.message ?? 'Network error');
      return Left(Failure(errorMessage: message));
    } catch (e) {
      return Left(Failure(errorMessage: e.toString()));
    }
  }
}