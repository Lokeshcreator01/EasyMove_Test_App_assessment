import 'package:dartz/dartz.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';

abstract class ServicesRepository {
  Future<Either<Failure,ServicesEntity>>getRealestate(String endPoint);
}