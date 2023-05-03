import 'dart:async';

import 'package:Array_App/bloc/user/user_event.dart';
import 'package:Array_App/bloc/user/user_state.dart';
import 'package:bloc/bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../domain/use_case/initial_item_load_use_case.dart';

// class InitialLoadUseCase {
//   final UserRepository userRepository;
//   final ItemRepository itemRepository;
//
//   InitialLoadUseCase({this.userRepository, this.itemRepository});
//
//   Future<Data> loadData() async {
//     final user = await userRepository.getUser();
//     final items = await itemRepository.getItems();
//     return Data(user: user, items: items);
//   }
// }
// TODO(jtl) probably in initial page the user will load and
// then the date will initiate a itemloadevent.
class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(
    this._initialLoadUseCase,
  ) : super(const UserState.initial()) {
    on<LoadUser>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  final InitialItemLoadUseCase _initialLoadUseCase;

  Future<void> _onLoadStarted(UserEvent event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading(user: state.user));
      // TODO(jtl): Implement this.
      // final user = await _initialLoadUseCase.execute(1);
      // emit(UserLoaded(user: user));
    } on Exception catch (e) {
      emit(UserLoadFailure(e));
    }
  }
}
