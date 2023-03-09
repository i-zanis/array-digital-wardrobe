class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.userRepository}) : super(UserState.initial());

  final UserRepository userRepository;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is Login) {
      yield UserLoading(user: state.user);
      try {
        final user = await userRepository.login(event.username, event.password);
        yield UserLoaded(user: user);
      } catch (e) {
        yield UserLoadFailure(e);
      }
    } else if (event is Logout) {
      yield UserLoading(user: state.user);
      try {
        await userRepository.logout();
        yield UserState.initial();
      } catch (e) {
        yield UserLoadFailure(e);
      }
    }
  }
}

class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class Login extends UserEvent {
  const Login({required this.username, required this.password});

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class Logout extends UserEvent {
  const Logout();
}