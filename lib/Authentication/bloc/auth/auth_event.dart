abstract class AuthEvent {}

class SignupRequested extends AuthEvent {
  final String email;
  final String password;

  SignupRequested(this.email, this.password);
}
