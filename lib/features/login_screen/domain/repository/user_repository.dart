import 'package:dartz/dartz.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:easymove/features/login_screen/domain/entities/auth_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(
    String endPoint, {
    required Map<String, dynamic> body,
  });

  Future<Either<Failure, bool>> logout(
    String endPoint, {
    required String token,
  });
}
