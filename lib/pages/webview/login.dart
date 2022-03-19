import 'package:aniu/api/store.dart';
import 'package:aniu/main.dart';
import 'package:aniu/objectbox.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:http/http.dart' as http;

import '../../models/objectbox/cookies.dart';


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
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Color(0xff0c101b),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: InAppWebView(
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
                      await saveUser(url);
                      controller.clearCache();
                      var cookieManager = CookieManager();
                      cookieManager.deleteAllCookies();
                      Navigator.pop(context, 3);
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
              ),
            ],
          )
      ),
    );
  }
}