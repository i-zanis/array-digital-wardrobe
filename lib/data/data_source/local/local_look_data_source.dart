import 'dart:convert';

import 'package:Array_App/domain/entity/item/look.dart';
import 'package:Array_App/main_development.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalLookDataSource {
  factory LocalLookDataSource() {
    return _eagerInstance;
  }

  LocalLookDataSource._internal();

  static final LocalLookDataSource _eagerInstance =
      LocalLookDataSource._internal();
  static final SharedPreferences? _prefs = sharedPrefs;
  static const String _looksKey = 'looks';

  Future<void> saveAll(List<Look> looks) async {
    logger.i('$LocalLookDataSource: Saving looks');
    final looksJson = looks.map((look) => look.toJson()).toList();
    await _prefs?.setStringList(
      _looksKey,
      looksJson.map((e) => json.encode(e)).toList(),
    );
  }

  Future<void> save(Look look) async {
    final looks = await findAll();
    logger.i('LocalLookDataSource: Saving look');

    final looksWithoutUpdated = looks.where((l) => look.id != l.id).toList()
      ..add(look);
    await saveAll(looksWithoutUpdated);
  }

  Future<List<Look>> findAll() async {
    logger.i('$LocalLookDataSource: Retrieving all looks');
    final looksJson = _prefs?.getStringList(_looksKey);
    if (looksJson == null) {
      logger.i('No looks found in local storage');
      return [];
    }
    return looksJson
        .map((look) => Look.fromJson(json.decode(look) as Map<String, dynamic>))
        .toList();
  }

  Future<void> delete(int id) async {
    logger.i('LocalLookDataSource: Deleting look with id: $id');
    final looks = await findAll();
    final looksWithoutDeleted = looks.where((l) => id != l.id).toList();
    await saveAll(looksWithoutDeleted);
  }

  Future<void> update(Look look) async {
    logger.i('LocalLookDataSource: Updating look: ${look.toJson()}');
    final looks = await findAll();
    final looksWithoutUpdated = looks.where((l) => look.id != l.id).toList()
      ..add(look);
    await saveAll(looksWithoutUpdated);
  }

  Future<Look> findById(int id) async {
    logger.i('LocalLookDataSource: Retrieving look with id: $id');
    final looks = await findAll();
    final look = looks.firstWhere((l) => id == l.id);
    return look;
  }
}
