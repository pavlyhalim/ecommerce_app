abstract class SignState {}

class SignInitial extends SignState {}

class SignInSuccess extends SignState {}
class SignInFailed extends SignState {
  SignInFailed(String message);
}

class SignUpSuccess extends SignState {}

class SignUpFailed extends SignState {
  final String message;
  SignUpFailed(this.message);
}
