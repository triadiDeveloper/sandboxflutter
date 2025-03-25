import 'package:cleanarchitecture/core/usecases/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_all_users.dart';

abstract class UserEvent {}
class LoadUsers extends UserEvent {}

abstract class UserState {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final List<User> users;
  UserLoaded(this.users);
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetAllUsers getAllUsers;

  UserBloc(this.getAllUsers) : super(UserInitial()) {
    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      final result = await getAllUsers(NoParams());
      result.fold(
        (error) => emit(UserError(error.toString())),
        (users) => emit(UserLoaded(users)),
      );
    });
  }
}
