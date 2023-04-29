import 'dart:async';

import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/domain/use_case/use_case.dart';
import 'package:Array_App/main_development.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc(
    this._initialLoadUseCase,
    this._initialLookLoadUseCase,
    this._saveItemUseCase,
    this._deleteItemUseCase,
    this._updateItemUseCase,
    this._saveLookUseCase,
    this._updateLookUseCase,
    this._removeBackgroundUseCase,
  ) : super(const ItemState.initial()) {
    on<LoadItem>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<SaveItem>(
      _onSaveItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<UpdateItem>(
      _onUpdateItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<DeleteItem>(
      _onDeleteItem,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<UpdateItemToAdd>(
      _onUpdateItemToAdd,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<UpdateLookToAdd>(
      _onUpdateLookToAdd,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<RemoveBackground>(
      _onRemoveBackground,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<SaveLook>(
      _onSaveLook,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<UpdateLook>(
      _onUpdateLook,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  final InitialItemLoadUseCase _initialLoadUseCase;
  final InitialLookLoadUseCase _initialLookLoadUseCase;
  final SaveItemUseCase _saveItemUseCase;
  final DeleteItemUseCase _deleteItemUseCase;
  final UpdateItemUseCase _updateItemUseCase;
  final RemoveBackgroundUseCase _removeBackgroundUseCase;
  final SaveLookUseCase _saveLookUseCase;
  final UpdateLookUseCase _updateLookUseCase;

  Future<void> _onLoadStarted(ItemEvent event, Emitter<ItemState> emit) async {
    try {
      emit(ItemLoading(items: state.items, looks: state.looks));
      final loadItemsFuture = _initialLoadUseCase.execute(1);
      final loadLooksFuture = _initialLookLoadUseCase.execute(1);
      final results = await Future.wait([loadItemsFuture, loadLooksFuture]);
      final items = results[0] as List<Item>;
      final looks = results[1] as List<Look>;
      emit(ItemLoaded(items: items, looks: looks));
    } on Exception catch (e) {
      logger.e('$_onLoadStarted: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onSaveItem(SaveItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      final item = await _saveItemUseCase.execute(event.item);
      // Remove item from state and add the updated instance
      final updatedItems = state.items.where((i) => i.id != item.id).toList()
        ..add(item);
      emit(ItemLoaded(items: updatedItems, looks: state.looks));
    } on Exception catch (e) {
      logger.e('$_onSaveItem: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    final id = event.item.id;
    // following block required for null safety
    if (id == null) {
      emit(ItemError(Exception('The item contains invalid data.')));
      return;
    }
    try {
      await _deleteItemUseCase.execute(id);
      emit(
        ItemLoaded(
          items: state.items.where((i) => i.id != id).toList(),
          looks: state.looks,
        ),
      );
    } on Exception catch (e) {
      logger.e('$_onDeleteItem($id): $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onUpdateItem(UpdateItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      final item = await _updateItemUseCase.execute(event.item);
      emit(
        ItemLoaded(
          items: state.items.map((i) => i.id == item.id ? item : i).toList(),
          looks: state.looks,
        ),
      );
    } on Exception catch (e) {
      logger.e('$_onUpdateItem: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onUpdateItemToAdd(
    UpdateItemToAdd event,
    Emitter<ItemState> emit,
  ) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      emit(
        ItemLoaded(
          items: state.items,
          looks: state.looks,
          itemToAdd: event.itemToAdd,
        ),
      );
    } on Exception catch (e) {
      logger.e('$_onUpdateItemToAdd: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onSaveLook(SaveLook event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      logger.d('Saving look: ${event.look}');
      final look = await _saveLookUseCase.execute(event.look);
      // Remove look from state and add the updated instance
      final updatedLooks = state.looks.where((i) => i.id != look.id).toList()
        ..add(look);
      emit(ItemLoaded(items: state.items, looks: updatedLooks));
    } on Exception catch (e) {
      logger.e('$_onSaveLook: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onUpdateLook(UpdateLook event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      final look = await _updateLookUseCase.execute(event.look);
      emit(
        ItemLoaded(
          items: state.items,
          looks: state.looks.map((i) => i.id == look.id ? look : i).toList(),
        ),
      );
    } on Exception catch (e) {
      logger.e('$_onUpdateLook: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onUpdateLookToAdd(
    UpdateLookToAdd event,
    Emitter<ItemState> emit,
  ) async {
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      logger.d('Updating look to add');
      emit(
        ItemLoaded(
          items: state.items,
          lookToAdd: event.lookToAdd,
          looks: state.looks,
        ),
      );
    } on Exception catch (e) {
      logger.e('$_onUpdateLookToAdd: $e');
      emit(ItemLoadFailure(e));
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }

  Future<void> _onRemoveBackground(
    RemoveBackground event,
    Emitter<ItemState> emit,
  ) async {
    logger.i('$ItemBloc: Removing background from image.');
    emit(ItemLoading(items: state.items, looks: state.looks));
    try {
      final image =
          await (await _removeBackgroundUseCase.execute(event.filepath))
              .readAsBytes();
      emit(
        ItemLoaded(
          items: state.items,
          looks: state.looks,
          itemToAdd:
              state.itemToAdd?.copyWith(imageData: image) ?? Item.empty(),
          lookToAdd:
              state.lookToAdd?.copyWith(lookImageData: image) ?? Look.empty(),
        ),
      );
    } on Exception catch (e) {
      logger.e('$_onRemoveBackground: $e');
      emit(ItemLocalLoaded(items: state.items, looks: state.looks));
    }
  }
}

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class UpdateLookToAdd extends ItemEvent {
  const UpdateLookToAdd(this.lookToAdd);

  final Look lookToAdd;

  @override
  List<Object> get props => [lookToAdd];
}

class UpdateItemToAdd extends ItemEvent {
  const UpdateItemToAdd(this.itemToAdd);

  final Item itemToAdd;

  @override
  List<Object> get props => [itemToAdd];
}

class RemoveBackground extends ItemEvent {
  const RemoveBackground({
    required this.filepath,
  });

  final String filepath;

  @override
  List<Object> get props => [filepath];
}

class LoadItem extends ItemEvent {
  const LoadItem({this.items = const <Item>[]});

  final List<Item> items;

  @override
  List<Object> get props => [items];
}

class SaveItem extends ItemEvent {
  const SaveItem(this.item);

  final Item item;

  @override
  List<Object> get props => [item];
}

class SaveLook extends ItemEvent {
  const SaveLook(this.look);

  final Look look;

  @override
  List<Object> get props => [look];
}

class UpdateLook extends ItemEvent {
  const UpdateLook(this.look);

  final Look look;

  @override
  List<Object> get props => [look];
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
