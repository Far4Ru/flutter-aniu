import 'package:aniu/main.dart';
import 'package:aniu/models/objectbox/cookies.dart';
import 'package:aniu/models/objectbox/user.dart';
import 'package:aniu/objectbox.g.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<void> saveUser(String url) async {

  var box = objectbox.store.box<StoredUser>();
  try {
    box.put(StoredUser(url));
  } catch (e) {
    // print('Пользователь уже существует');
  }
  await saveCookies(url);
}



Future<void> saveCookies(String url) async {
  CookieManager cookieManager = CookieManager.instance();
  List<Cookie> cookies = await cookieManager.getCookies(url: Uri.parse(url));
  var box = objectbox.store.box<StoredCookie>();
  for (var element in cookies) {
    try {
      box.put(StoredCookie(element.name,element.value));
    }
    catch (e) {
      var storedCookie = box.query(StoredCookie_.name.equals(element.name)).build().findFirst();
      if (storedCookie != null) {
        storedCookie.value = element.value;
        // print(storedCookie.id);
        box.put(storedCookie);
      }
    }
  }
}