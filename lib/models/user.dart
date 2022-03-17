import 'package:aniu/models/cookies.dart';
import 'package:objectbox/objectbox.dart';

import '../main.dart';

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

class UserClass {
  String name;
  Map<String, int> stats;

  UserClass(this.name, this.stats);
}