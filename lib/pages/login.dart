import 'package:aniu/main.dart';
import 'package:aniu/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:http/http.dart' as http;

import '../models/cookies.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey _key = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
          useShouldOverrideUrlLoading: true,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
  );


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Stack(
            children: [
              InAppWebView(
                key: _key,
                initialUrlRequest: URLRequest(url: Uri.parse("https://aniu.ru/user/login")),
                initialOptions: options,
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                androidOnPermissionRequest: (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading:  (controller, navigationAction) async {
                  String url = navigationAction.request.url.toString();
                  // print(navigationAction);
                  if (RegExp(r"^https\:\/\/aniu\.ru\/user\/login$").hasMatch(url) || RegExp(r"google\.com\/recaptcha").hasMatch(url)) {
                    // print('allow');
                    return NavigationActionPolicy.ALLOW;
                  }
                  if(RegExp(r"https\:\/\/aniu\.ru\/user\/\w*-\d*\/").hasMatch(url)) {
                    // print('save');
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
                            // print(storedCookie?.id);
                            box.put(storedCookie);
                          }
                        }
                    }
                    //String cookieString = cookies.map((e) => e.name+'='+e.value).toList().join('; ');
                    Map<String, String> headers = {};
                    headers['cookie'] = StoredCookies().toString();
                    final response = await http.get(Uri.parse('https://aniu.ru/api/v1/account.notify.count'), headers: headers);
                    // await Future.delayed(const Duration(seconds: 5));
                    if(response.statusCode == 200) {
                      //print(response.body);
                    }
                    Navigator.pop(context);
                  }
                  if(RegExp(r'^https\:\/\/aniu\.ru\/$').hasMatch(url)){
                    Navigator.pop(context);
                  }
                  controller.stopLoading();
                  // return null;
                  return NavigationActionPolicy.CANCEL;
                  // controller.stopLoading();
                  // Navigator.pop(context);
                  // print(navigationAction);
                  // return NavigationActionPolicy.CANCEL;
                  // controller.stopLoading();
                  // await controller.stopLoading();
                  // controller.goBack();
                  // return null;
                },
              ),
            ],
          )
      ),
    );
  }
}