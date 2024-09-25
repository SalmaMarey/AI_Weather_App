abstract class AuthEvent {}

class SignUpButtonPressed extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  SignUpButtonPressed({required this.fullName, required this.email, required this.password});
}

class LogInButtonPressed extends AuthEvent {
  final String email;
  final String password;

  LogInButtonPressed({required this.email, required this.password});
}
