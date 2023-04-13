import 'dart:async';
import 'dart:io';

import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/main_development.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
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
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();

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
      var image = await _picker.pickImage(
        source: source,
        maxWidth: 320,
        maxHeight: 640,
        imageQuality: 100,
      );
      if (image == null) {
        await AppNavigator.push(AppRoute.root, arguments: 3);
        return;
      }

      var newImage = File(image.path);
      logger.i('newImage: $newImage');
      // newImage = await removeBackground(newImage.path);
      await GallerySaver.saveImage(newImage.path, albumName: 'Array_App');
      image = XFile(newImage.path);
      setState(() {
        _setImageFileListFromFile(image);
      });
      if (mounted) {
        final imageBytes = await image.readAsBytes();
        BlocProvider.of<ItemBloc>(context!)
            .add(UpdateItemToAdd(Item(imageData: imageBytes)));
      }
      logger.d('image path: ${image.path}');
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

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
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

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Future<File> removeBackground(String imageFilePath) async {
    logger.i('Removing background from image');
    final imageFile = File(imageFilePath);
    final outputFile = File('${imageFile.path}_no_bg.png');
    // var headers = {'X-API-Key': 'fksjlk'};
    var headers = {'X-API-Key': 'hzHAEXKWZt8NPsDeM2hdQn92'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.remove.bg/v1.0/removebg'),
    );
    request.fields.addAll({'size': 'auto'});
    request.files
        .add(await http.MultipartFile.fromPath('image_file', imageFilePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      logger.e(response.reasonPhrase);
      print(response.stream.bytesToString());
      return imageFile;
    }

    if (response.statusCode == 200) {
      await outputFile.writeAsBytes(await response.stream.toBytes());
      return outputFile;
    } else {
      throw Exception('Failed to remove background from image');
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
