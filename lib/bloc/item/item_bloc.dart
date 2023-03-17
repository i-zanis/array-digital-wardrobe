import 'dart:async';

import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/use_case/initial_load_use_case.dart';
import 'package:Array_App/domain/use_case/item/add_item_use_case.dart';
import 'package:Array_App/domain/use_case/item/delete_item_use_case.dart';
import 'package:Array_App/domain/use_case/item/update_item_use_case.dart';
import 'package:Array_App/main_development.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc(
    this._initialLoadUseCase,
    this._saveItemUseCase,
    this._deleteItemUseCase,
    this._updateItemUseCase,
  ) : super(const ItemState.initial()) {
    on<LoadItem>(
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
    on<UpdateItemToAdd>(
      onUpdateItemToAdd,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
  }

  final InitialLoadUseCase _initialLoadUseCase;
  final SaveItemUseCase _saveItemUseCase;
  final DeleteItemUseCase _deleteItemUseCase;
  final UpdateItemUseCase _updateItemUseCase;

  Future<void> _onLoadStarted(ItemEvent event, Emitter<ItemState> emit) async {
    try {
      emit(ItemLoading(items: state.items));
      final items = await _initialLoadUseCase.execute(1);
      emit(ItemLoaded(items: items));
    } on Exception catch (e) {
      emit(ItemLoadFailure(e));
    }
  }

  Future<void> _onSaveItem(SaveItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items));
    try {
      final item = await _saveItemUseCase.execute(event.item);
      emit(ItemLoaded(items: [...state.items, item]));
    } on Exception catch (e) {
      emit(ItemError(e));
    }
  }

  Future<void> _onDeleteItem(DeleteItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items));
    final id = event.item.id;
    // following block required for null safety
    if (id == null) {
      emit(ItemError(Exception('The item contains invalid data.')));
      return;
    }
    try {
      await _deleteItemUseCase.execute(id);
      emit(ItemLoaded(items: state.items.where((i) => i.id != id).toList()));
    } on Exception catch (e) {
      emit(ItemLoadFailure(e));
    }
  }

  Future<void> _onUpdateItem(UpdateItem event, Emitter<ItemState> emit) async {
    emit(ItemLoading(items: state.items));
    try {
      final item = await _updateItemUseCase.execute(event.item);
      emit(
        ItemLoaded(
          items: state.items.map((i) => i.id == item.id ? item : i).toList(),
        ),
      );
    } on Exception catch (e) {
      emit(ItemLoadFailure(e));
    }
  }

  FutureOr<void> onUpdateItemToAdd(
    UpdateItemToAdd event,
    Emitter<ItemState> emit,
  ) {
    emit(ItemLoading(items: state.items));
    try {
      logger
          .d('onUpdateItemToAdd: ${event.itemToAdd.imageData![0].toString()}');
      emit(ItemLoaded(items: state.items, itemToAdd: event.itemToAdd));
    } on Exception catch (e) {
      emit(ItemLoadFailure(e));
    }
  }
}

abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class UpdateItemToAdd extends ItemEvent {
  UpdateItemToAdd(this.itemToAdd) {}

  final Item itemToAdd;

  @override
  List<Object> get props => [itemToAdd];
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
