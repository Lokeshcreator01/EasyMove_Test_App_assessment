import 'package:dartz/dartz.dart';
import 'package:easymove/core/errors/errors.dart';
import 'package:easymove/features/homescreen/data/dataSources/realestate_data_source.dart';
import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';
import 'package:easymove/features/homescreen/domain/repository/realestate_repository.dart';

class RealestateRepositoriesImpl extends ServicesRepository{
  final ServicesDataSource realestateDataSource;
  RealestateRepositoriesImpl({required this.realestateDataSource});
  @override
  Future<Either<Failure, ServicesEntity>> getRealestate(String endPoint) async{
    try{
      final response=await realestateDataSource.getUser(endPoint);
      if(response is ServicesEntity){
        return Right(response);
      }else{
        return Left(Failure(message: response.toString()));
      }
    }catch(e){
      return Left(Failure(message: e.toString()));
    }
  }
  
}