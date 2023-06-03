import 'package:Array_App/bootstrap.dart';
import 'package:Array_App/rest/app/view/app.dart';
import 'package:Array_App/rest/util/logger/log.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

final logger = Log.instance;
SharedPreferences? sharedPrefs;

List<CameraDescription> cameras = <CameraDescription>[];

Future<void> main() async {
  // TODO MAYBE needs removal because it's inside runapp in Bootstrap
  // required if main is async
  WidgetsFlutterBinding.ensureInitialized();
  // boostrap == BlocOberser file/class
  sharedPrefs = await SharedPreferences.getInstance();
  await dotenv.load();
  cameras = await availableCameras();
  await bootstrap(ArrayApp.new);
}
