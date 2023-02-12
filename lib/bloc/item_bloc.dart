import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

import '../domain/add_item_use_case.dart';
import '../domain/delete_item_use_case.dart';
import '../domain/entity/item.dart';
import '../domain/initial_load_use_case.dart';
import '../domain/update_item_use_case.dart';
import '../main_development.dart';
import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  // final LikeItemUseCase likeItemUseCase;
  ItemBloc(
      this._saveItemUseCase, this._initialLoadUseCase, this.deleteItemUseCase)
      : super(const ItemState.initial()) {
    // logger.i('ItemBloc constructor');

    on<ItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<SaveItem>(
      _onSaveItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<DeleteItem>(
      _onDeleteItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<UpdateItem>(
      _onUpdateItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  // ItemBloc(this.addItemUseCase, this.removeItemUseCase, this.likeItemUseCase,
  //     this.saveItemUseCase)
  //     : super(InitialItemState());
  final InitialLoadUseCase _initialLoadUseCase;
  final SaveItemUseCase _saveItemUseCase;
  final DeleteItemUseCase deleteItemUseCase;
  final UpdateItemUseCase _updateItemUseCase;

  Future<void> _onLoadStarted(
      ItemLoadStarted event, Emitter<ItemState> emit) async {
    logger.i('On Load started..');
    try {
      emit(state.asLoading());
      // TODO(jtl): fix with USERID
      final items = await _initialLoadUseCase.execute(1);
      emit(state.asLoadSuccess(items));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  Future<void> _onSaveItem(SaveItem event, Emitter<ItemState> emit) async {
    logger.i('On SaveItem started..');
    emit(state.asLoading());
    try {
      await _saveItemUseCase.execute(event.item);
      emit(state.asSaveSuccess(event.item));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<ItemState> emit) async {
    logger.i('On DeleteItem started..');
    emit(state.asLoading());
    try {
      await _saveItemUseCase.execute(event.item);
      emit(state.copyWith(items: [...state.items, event.item]));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  Future<void> _onUpdateItem(DeleteItem event, Emitter<ItemState> emit) async {
    logger.i('On UpdateItem started..');
    emit(state.asLoading());
    try {
      await _updateItemUseCase.execute(event.item);
      final items = state.items.where((i) => event.item.id != i.id).toList();
      emit(state.copyWith(items: [...items, event.item]));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

// Stream<ItemState> mapEventToState(ItemEvent event) async* {
//   switch (event.type) {
//     case ItemActions.add:
//       yield* _addItem(event.item);
//       break;
//       // case ItemActions.remove:
//       //   yield* _removeItem(event.item);
//       //   break;
//       // case ItemActions.like:
//       //   yield* _likeItem(event.item);
//       //   break;
//       // case ItemActions.save:
//       //   yield* _saveItem(event.item);
//       break;
//     default:
//       break;
//   }
// }

// Stream<ItemState> _addItem(Item item) async* {
//   yield AddingItemState();
//   try {
//     await addItemUseCase.execute(item);
//     yield AddedItemState();
//   } catch (e) {
//     yield AddItemFailureState(e);
//   }
// }
}

//***********************************************
// FROM YOUTUBE VIDEO SEE IF NEEDED
//***********************************************

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class LoadsItems extends ItemEvent {
  const LoadsItems({this.items = const <Item>[]});

  final List<Item> items;

  @override
  List<Object> get props => [items];
}

class ItemLoadStarted extends ItemEvent {}

class SaveItem extends ItemEvent {
  const SaveItem(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class LikeItem extends ItemEvent {
  const LikeItem(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class UpdateItem extends ItemEvent {
  const UpdateItem(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class DeleteItem extends ItemEvent {
  const DeleteItem(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class FindItem extends ItemEvent {
  const FindItem(this.query);

  final String query;

  @override
  List<Object> get props => [query];
}

enum ItemActions { add, delete, like, save }
