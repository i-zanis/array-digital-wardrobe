import 'package:Array_App/data/data_source/remote/remote_look_data_source.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Remote Look Data Source', () {
    test('save() should return a Look with an ID', () async {
      final dataSource = RemoteLookDataSource();
      final look = Look(
        id: null,
        name: 'Test Look',
      );
      final savedLook = await dataSource.save(look);

      expect(savedLook.id, isNotNull);
    });
  });
}
