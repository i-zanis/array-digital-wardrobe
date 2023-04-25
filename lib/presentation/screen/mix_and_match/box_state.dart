// box_cubit.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BoxState {
  BoxState({required this.isActive, required this.color});
  final bool isActive;
  final Color color;
}

class BoxCubit extends Cubit<BoxState> {
  BoxCubit(Color color) : super(BoxState(isActive: false, color: color));

  void toggleActive() =>
      emit(BoxState(isActive: !state.isActive, color: state.color));
}
