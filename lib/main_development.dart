import 'package:wardrobe_frontend/bootstrap.dart';
import 'package:wardrobe_frontend/rest/app/view/app.dart';
import 'package:wardrobe_frontend/rest/util/log.dart';


final logger = Log.instance;
Future<void> main() async {
  await bootstrap(() => const App());
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
