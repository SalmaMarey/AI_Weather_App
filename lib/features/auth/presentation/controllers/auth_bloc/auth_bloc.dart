import 'package:bloc/bloc.dart';
import 'package:tennis_app/features/auth/domain/auth_repository.dart';
import 'package:tennis_app/features/auth/presentation/controllers/auth_bloc/auth_state.dart';
import 'auth_event.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationRepository authenticationRepository;

  AuthBloc({required this.authenticationRepository}) : super(AuthInitial()) {
    on<SignUpButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        await authenticationRepository.signUp(
          event.fullName,
          event.email,
          event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<LogInButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        await authenticationRepository.logIn(
          event.email,
          event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });
  }
}
