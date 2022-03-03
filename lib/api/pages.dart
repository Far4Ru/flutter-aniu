import 'dart:convert';

import 'package:http/http.dart' as http;

Future<http.Response?> fetchNew22(http.Client client) async {
  final response = await client.get(Uri.parse('https://aniu.ru/api/v1/release.list.new22y'));
  print(response.body);
  if(response.statusCode == 200) {
    List body = json.decode(response.body);
    body.forEach((item) => {
      print(item['title_ru'])
    });
  }
  return null;
}