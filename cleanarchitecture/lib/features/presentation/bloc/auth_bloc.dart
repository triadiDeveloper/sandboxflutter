// lib/features/presentation/bloc/auth_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/usecases/login.dart' as usecase_login;
import '../../domain/usecases/register.dart' as usecase_register;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final usecase_login.Login loginUsecase;
  final usecase_register.Register registerUsecase;

  AuthBloc(this.loginUsecase, this.registerUsecase) : super(AuthInitial()) {
    on<DoLogin>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await loginUsecase(usecase_login.LoginParams(
          email: event.email,
          password: event.password,
        ));
        emit(AuthSuccess(token));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });

    on<DoRegister>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await registerUsecase(usecase_register.RegisterParams(
          email: event.email,
          password: event.password,
        ));
        emit(AuthSuccess(token));
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}