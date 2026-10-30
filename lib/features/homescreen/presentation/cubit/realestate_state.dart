import 'package:easymove/features/homescreen/domain/entities/Realestste_Entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}

class ServicesInitState extends UserState{
  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState{
  @override
  List<Object> get props => [];
}

class RealestateErrorState extends UserState{
  final String message;
  const RealestateErrorState(this.message);
}

class RealestateSuccessState extends UserState{
  final ServicesEntity realestateEntity;
  const RealestateSuccessState(this.realestateEntity);
}