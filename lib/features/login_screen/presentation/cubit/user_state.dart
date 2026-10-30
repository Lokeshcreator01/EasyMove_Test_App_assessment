import 'package:easymove/features/login_screen/domain/entities/auth_entity.dart';
import 'package:equatable/equatable.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitState extends UserState {
  const UserInitState();

  @override
  List<Object> get props => [];
}

class UserLoadingState extends UserState {
  const UserLoadingState();

  @override
  List<Object> get props => [];
}

class UserErrorState extends UserState {
  final String message;

  const UserErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class UserSuccessState extends UserState {
  final UserEntity userEntity;

  const UserSuccessState(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}

class UserLogoutSuccessState extends UserState {
  const UserLogoutSuccessState();
}
