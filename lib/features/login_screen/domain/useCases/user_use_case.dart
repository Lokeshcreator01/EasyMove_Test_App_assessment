import 'package:easymove/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:easymove/features/login_screen/domain/entities/auth_entity.dart';
import 'package:easymove/features/login_screen/domain/repository/user_repository.dart';

class UserUseCase {
  final UserRepository realestateRepository;
  UserUseCase(this.realestateRepository);

  Future<Either<Failure, UserEntity>> getUser(
    String endPoint, {
    required Map<String, dynamic> body,
  }) {
    return realestateRepository.getUser(endPoint, body: body);
  }

  Future<Either<Failure, bool>> logout(
    String endPoint, {
    required String token,
  }) {
    return realestateRepository.logout(endPoint, token: token);
  }
}
