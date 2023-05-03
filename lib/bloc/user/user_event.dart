import 'package:Array_App/domain/entity/user/user.dart';
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  const LoadUser({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}
