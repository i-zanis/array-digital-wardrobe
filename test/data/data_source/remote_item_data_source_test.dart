import 'package:Array_App/data/data_source/remote/remote_item_data_source.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:test/test.dart';

void main() {
  group('Item Data Source', () {
    test('Saving an item should return the same item with an ID', () async {
      final dataSource = RemoteItemDataSource();
      final item = Item(
          name: 'Test Item',
          price: 9.99,
          category: Category.TOP,
          userId: 1,
          looks: [Look(name: 'Test Look 1'), Look(name: 'Test Look 2')],
          tags: [Tag(name: 'Test Tag 1'), Tag(name: 'Test Tag 2')]);

      final savedItem = await dataSource.save(item);

      expect(savedItem.name, equals(item.name));
      expect(savedItem.price, equals(item.price));
      expect(savedItem.category, equals(item.category));
      // expect(savedItem.userId, equals(item.userId));
      // expect(savedItem.looks, equals(item.looks));
      expect(savedItem.tags, equals(item.tags));
      expect(savedItem.id, isNotNull);
    });
  });
}
