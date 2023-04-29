import 'dart:async';
import 'dart:io';

import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _onImageButtonPressed(ImageSource.camera, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    BuildContext? context,
  }) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        maxWidth: 320,
        maxHeight: 640,
        imageQuality: 100,
      );
      if (image == null) {
        await AppNavigator.push(AppRoute.root, arguments: 3);
        return;
      }
      final newImage = File(image.path);
      BlocProvider.of<ItemBloc>(context!)
          .add(RemoveBackground(filepath: newImage.path));
      await AppNavigator.push(AppRoute.selectItemInGrid, arguments: true);
    } catch (e) {
      logger.e('$CameraScreen: $e');
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }
}
