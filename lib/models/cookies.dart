import 'package:aniu/main.dart';
import 'package:objectbox/objectbox.dart';

class StoredCookies {

  late List<StoredCookie> cookies;

  StoredCookies() {
    _create();
    // print(cookies.length);
  }

  @override
  toString() => cookies.map((e) => e.name+'='+e.value).toList().join('; ');

  _create() => cookies = objectbox.store.box<StoredCookie>().getAll();

}

@Entity()
class StoredCookie {
  int id = 0;

  @Unique()
  String name;

  String value;

  StoredCookie(this.name, this.value);
}