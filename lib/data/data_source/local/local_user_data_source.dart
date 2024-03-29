import 'package:Array_App/domain/entity/user/user.dart';
import 'package:Array_App/main_development.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserDataSource {
  factory LocalUserDataSource() {
    return _singleton;
  }

  // _internal is a private constructor You can create any private constructor
  // using any Class._someName construction
  LocalUserDataSource._internal({SharedPreferences? prefs})
      : _prefs = prefs ?? sharedPrefs;

  static final LocalUserDataSource _singleton = LocalUserDataSource._internal();
  final SharedPreferences? _prefs;

  static const String _userKey = 'user';

  Future<void> save(User user) async {
    final userJson = user.toJson();
    await _prefs?.setString(_userKey, userJson as String);
  }

  Future<User> get() async {
    final userJson = _prefs?.getString(_userKey);
    if (userJson == null) {
      return User.empty();
    }
    return User.fromJson(userJson as Map<String, dynamic>);
  }
}
