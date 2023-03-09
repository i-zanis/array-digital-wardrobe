import 'package:Array_App/domain/entity/user/user.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  const UserState({required this.user, this.exception});

  const UserState._({this.user, this.exception});

  const UserState.initial() : this._();

  final User? user;
  final Exception? exception;

  @override
  List<Object?> get props => [
        user,
        exception,
      ];

  UserState copyWith({
    User? user,
    Exception? exception,
  }) {
    return UserState(
      user: user ?? this.user,
      exception: exception ?? this.exception,
    );
  }
}

class UserLoaded extends UserState {
  const UserLoaded({required super.user}) : super._();
}

class UserLoadFailure extends UserState {
  const UserLoadFailure(Exception exception) : super._(exception: exception);
}

class UserError extends UserState {
  const UserError(Exception exception) : super._(exception: exception);
}

class UserLoading extends UserState {
  const UserLoading({required super.user}) : super._();
}
