import 'package:easymove/features/login_screen/domain/useCases/user_use_case.dart';
import 'package:easymove/features/login_screen/presentation/cubit/user_state.dart';
import 'package:easymove/features/login_screen/data/storage/auth_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  final UserUseCase userUseCase;
  UserCubit(this.userUseCase) : super(const UserInitState());

  Future<void> getUser(
    String endPoint, {
    required Map<String, dynamic> body,
  }) async {
    try {
      emit(const UserLoadingState());
      final response = await userUseCase.getUser(endPoint, body: body);
      response.fold(
        (failure) {
          emit(UserErrorState(failure.message));
        },
        (data) {
          emit(UserSuccessState(data));
        },
      );
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }

  Future<void> logout(String endPoint) async {
    try {
      final token = await AuthStorage().getToken();
      if (token == null || token.isEmpty) {
        emit(const UserErrorState('No saved login token was found.'));
        return;
      }

      emit(const UserLoadingState());
      final response = await userUseCase.logout(endPoint, token: token);
      if (response.isLeft()) {
        emit(
          UserErrorState(
            response.fold((failure) => failure.message, (_) => ''),
          ),
        );
        return;
      }
      await AuthStorage().clearToken();
      emit(const UserLogoutSuccessState());
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
