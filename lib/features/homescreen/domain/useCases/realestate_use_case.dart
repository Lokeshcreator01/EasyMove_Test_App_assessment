import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';
import 'package:easymove/features/homescreen/domain/repository/realestate_repository.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:dartz/dartz.dart';

class UserUseCase {
  final ServicesRepository realestateRepository;
  UserUseCase( this.realestateRepository);
  Future<Either<Failure,ServicesEntity>>getRealestate(String endPoint){
    return realestateRepository.getRealestate(endPoint);
  }
}