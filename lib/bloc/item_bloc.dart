import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:wardrobe_frontend/domain/add_item_use_case.dart';
import 'package:wardrobe_frontend/domain/entity/item.dart';
import 'package:wardrobe_frontend/domain/initial_load_use_case.dart';
import 'package:wardrobe_frontend/main_development.dart';

import 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  // final RemoveItemUseCase removeItemUseCase;
  // final LikeItemUseCase likeItemUseCase;
  // final SaveItemUseCase saveItemUseCase;
  ItemBloc(this._addItemUseCase, this._initialLoadUseCase)
      : super(const ItemState.initial()) {
    logger.i('ItemBloc constructor');

    on<ItemLoadStarted>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<AddItem>(
      _onAddItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  // ItemBloc(this.addItemUseCase, this.removeItemUseCase, this.likeItemUseCase,
  //     this.saveItemUseCase)
  //     : super(InitialItemState());
  final AddItemUseCase _addItemUseCase;
  final InitialLoadUseCase _initialLoadUseCase;

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

  Future<void> _onAddItem(AddItem event, Emitter<ItemState> emit) async {
    logger.i('On Add Item started..');
    emit(state.asLoading());
    await _addItemUseCase.execute(event.item);
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
class LoadsItems extends ItemEvent {
  final List<Item> items;

  const LoadsItems({this.items = const <Item>[]});

  @override
  List<Object> get props => [items];
}

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemLoadStarted extends ItemEvent {}

class AddItem extends ItemEvent {
  final Item item;

  const AddItem(this.item);

  @override
  List<Object> get props => [item];
}

class LikeItem extends ItemEvent {
  final Item item;

  const LikeItem(this.item);

  @override
  List<Object> get props => [item];
}

class SaveItem extends ItemEvent {
  final Item item;

  const SaveItem(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItem extends ItemEvent {
  final Item item;

  const RemoveItem(this.item);

  @override
  List<Object> get props => [item];
}

class FindItem extends ItemEvent {
  final String query;

  const FindItem(this.query);

  @override
  List<Object> get props => [query];
}

//   Stream<ItemState> _removeItem(Item item) async* {
//     try {
//       final result = await removeItemUseCase.call(item);
//       yield ItemRemovedState(result);
//     } catch (e) {
//       yield ItemErrorState(e.toString());
//     }
//   }
//
//   Stream<ItemState> _likeItem(Item item) async* {
//     try {
//       final result = await likeItemUseCase.call(item);
//       yield ItemLikedState(result);
//     } catch (e) {
//       yield ItemErrorState(e.toString());
//     }
//   }
//
//   Stream<ItemState> _saveItem(Item item) async* {
//     try {
//       final result = await saveItemUseCase.call(item);
//       yield ItemSavedState(result);
//     } catch (e) {
//       yield ItemErrorState(e.toString());
//     }
//   }
// }

enum ItemActions { add, remove, like, save }
