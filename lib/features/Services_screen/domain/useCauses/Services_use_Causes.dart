import 'package:easymove/core/errors/errors.dart';
import 'package:dartz/dartz.dart';
import 'package:easymove/features/Services_screen/domain/entities/Services_entity.dart';
import 'package:easymove/features/Services_screen/domain/repository/Services_repository.dart';

class ServicesUseCase {
  final ServicesRepository servicesRepository;

  ServicesUseCase(this.servicesRepository);

  Future<Either<Failure, Servicesdata_entity>> getServices(String endPoint) {
    return servicesRepository.getServices(endPoint);
  }
}
