import 'package:equatable/equatable.dart';
import 'package:easymove/features/Services_screen/domain/entities/Services_entity.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitState extends ServicesState {
  const ServicesInitState();

  @override
  List<Object> get props => [];
}

class ServicesLoadingState extends ServicesState {
  const ServicesLoadingState();

  @override
  List<Object> get props => [];
}

class ServicesErrorState extends ServicesState {
  final String message;
  const ServicesErrorState(this.message);
}

class ServicesSuccessState extends ServicesState {
  final Servicesdata_entity servicesEntity;

  const ServicesSuccessState(this.servicesEntity);
}
