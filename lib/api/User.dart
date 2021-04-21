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
//     "uuid": "96eb8802-998d-4802-a221-2ee9bc1b6497",
//     "name": "Mrs. Mikayla Jast"
//   },
//   {
//     "uuid": "3e77aa0a-1cde-4f2b-a2ea-cb9687a1dc80",
//     "name": "Prof. Rita Maggio"
//   },
//   {
//     "uuid": "9ddee826-f95d-4231-bec6-487fdbf37cce",
//     "name": "Princess Anika Parker"
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
