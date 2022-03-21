import 'package:aniu/main.dart';
import 'package:aniu/models/objectbox/cookies.dart';
import 'package:objectbox/objectbox.dart';


@Entity()
class StoredUser {
  int id = 0;

  @Unique()
  String url;

  StoredUser(this.url);

  logout() {
    url = '';
    objectbox.store.box<StoredUser>().removeAll();
    StoredCookies().deleteAll();
  }
}
