import 'package:flutter/cupertino.dart';
import 'package:wardrobe_frontend/bootstrap.dart';
import 'package:wardrobe_frontend/rest/app/view/app.dart';
import 'package:wardrobe_frontend/rest/util/log.dart';

final logger = Log.instance;

Future<void> main() async {
  // required if main is async
  WidgetsFlutterBinding.ensureInitialized();
  // boostrap == BlocOberser file/class
  await bootstrap(() => const ArrayApp());

}

// void main() {
//   runApp(BlocProvider<WardrobeBloc>(
//     create: (context) => WardrobeBloc(
//       itemBloc: ItemBloc(),
//       userBloc: UserBloc(),
//     ),
//     child: MyApp(),
//   ));
// }
