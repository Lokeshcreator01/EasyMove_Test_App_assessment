import 'package:easymove/features/Services_screen/domain/useCauses/Services_use_Causes.dart';
import 'package:easymove/features/Services_screen/presentation/cubit/Services_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesCubit extends Cubit<ServicesState> {
  final ServicesUseCase servicesUseCase;

  ServicesCubit(this.servicesUseCase) : super(const ServicesInitState());

  Future<void> getServices(String endPoint) async {
    try {
      emit(const ServicesLoadingState());
      final response = await servicesUseCase.getServices(endPoint);
      response.fold(
        (failure) {
          emit(ServicesErrorState(failure.message));
        },
        (data) {
          emit(ServicesSuccessState(data));
        },
      );
    } catch (e) {
      emit(ServicesErrorState(e.toString()));
    }
  }
}
