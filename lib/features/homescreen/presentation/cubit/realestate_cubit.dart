import 'package:easymove/features/homescreen/domain/useCases/realestate_use_case.dart';
import 'package:easymove/features/homescreen/presentation/cubit/realestate_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RealestateCubit extends Cubit<UserState> {
  final UserUseCase realestateUseCase;
  RealestateCubit(this.realestateUseCase) : super(ServicesInitState());

  Future<void>getRealestate(String endPoint) async{
    try{
      emit(UserLoadingState());
      var response = await realestateUseCase.getRealestate(endPoint);
      response.fold((failure){
        emit(RealestateErrorState(failure.message));
      }, (data){
        emit(RealestateSuccessState(data));
      });
    } catch (e) {
      emit(RealestateErrorState(e.toString()));
    }
  }
}