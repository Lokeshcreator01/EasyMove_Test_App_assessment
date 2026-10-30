import 'package:dartz/dartz.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:easymove/features/Services_screen/data/datasource/Services_data_source.dart';
import 'package:easymove/features/Services_screen/domain/entities/Services_entity.dart';
import 'package:easymove/features/Services_screen/domain/repository/Services_repository.dart';

class ServicesRepositoriesImpl extends ServicesRepository {
  final ServicesDataSource servicesDataSource;

  ServicesRepositoriesImpl({required this.servicesDataSource});

  @override
  Future<Either<Failure, Servicesdata_entity>> getServices(
    String endPoint,
  ) async {
    try {
      final response = await servicesDataSource.getUser(endPoint);
      if (response is Servicesdata_entity) {
        return Right(response);
      } else {
        return Left(Failure(message: response.toString()));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
