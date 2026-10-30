import 'package:dartz/dartz.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:easymove/features/Services_screen/domain/entities/Services_entity.dart';

abstract class ServicesRepository {
  Future<Either<Failure, Servicesdata_entity>> getServices(String endPoint);
}
