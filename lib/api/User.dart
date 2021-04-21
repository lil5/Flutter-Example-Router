import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiUser {
  String uuid;
  String name;

  ApiUser({required this.uuid, required this.name});

  ApiUser.fromJson(Map<String, dynamic> json)
      : uuid = json['uuid'] as String,
        name = json['name'] as String;
}

// api result example:
// [
//   {
//     "uuid": "RDTfENkxrhRSTnXHlunvgtVHo",
//     "name": "John"
//   },
//   {
//     "uuid": "rNyxqHmWysncXDABUrnhxQtOt",
//     "name": "Anna"
//   },
//   {
//     "uuid": "SpiiGltrDieOsELTYwIPhbFej",
//     "name": "Jane"
//   }
// ]
Future<List<ApiUser>> fetchAllDataBase() async {
  final response = await http.get(Uri.http("localhost:7001", '/user/all'));
  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
    return parsed.map<ApiUser>((json) => ApiUser.fromJson(json)).toList();
  } else {
    throw Exception('Unable to fetch users from the REST API');
  }
}
