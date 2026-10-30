import 'package:dartz/dartz.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:easymove/features/login_screen/data/DataSource/user_entity_datasource.dart';
import 'package:easymove/features/login_screen/domain/entities/auth_entity.dart';
import 'package:easymove/features/login_screen/domain/repository/user_repository.dart';

class UserRepositoriesImpl extends UserRepository {
  final UserDataSource userDataSource;

  UserRepositoriesImpl({required this.userDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUser(
    String endPoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      final response = await userDataSource.putUser(endPoint, body: body);
      if (response is UserEntity) {
        return Right(response);
      } else {
        return Left(Failure(message: response.toString()));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> logout(
    String endPoint, {
    required String token,
  }) async {
    try {
      await userDataSource.logout(endPoint, token: token);
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
