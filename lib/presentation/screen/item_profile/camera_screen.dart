import 'dart:async';
import 'dart:io';

import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<XFile>? _imageFileList;

  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  String? _retrieveDataError;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    _onImageButtonPressed(ImageSource.camera, context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      setState(() {
        _pickImageError = e;
      });
    }
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> retrieveLostData() async {
    final response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
  }

  Future<void> saveImageToGallery(File imageFile) async {
    final directory = await getExternalStorageDirectory();
    final galleryPath = '${directory!.absolute.path}/Pictures';
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
    final filePath = '$galleryPath/$fileName';
    final savedFile = await imageFile.copy(filePath);
  }
}
