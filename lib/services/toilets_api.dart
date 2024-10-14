// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:surabhi/model/toilet/toilet_model.dart';

// class ApiService {
//   final String baseUrl = 'https://esmagroup.online/surabhi/api/v1/';

//   Future<List<Toilet>> fetchToilets() async {
//     final response = await http.get(Uri.parse('${baseUrl}get-toilets?status=&clusters='));

//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       if (data['status']) {
//         List<Toilet> toilets = (data['toilets'] as List)
//             .map((toiletJson) => Toilet.fromJson(toiletJson))
//             .toList();
//         return toilets;
//       } else {
//         throw Exception(data['message']);
//       }
//     } else {
//       throw Exception('Failed to load toilets');
//     }
//   }
// }
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:surabhi/controller/auth/authController.dart';
class ToiletService {
  static Future<List<dynamic>> fetchToilets({String status = '', int? cluster}) async {
    String? token = await AuthController.getToken();
    if (token == null) {
      throw Exception('No token available');
    }
    final url = Uri.parse('https://esmagroup.online/surabhi/api/v1/get-toilets?status=$status&clusters=${cluster ?? ''}');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Debugging line
      if (data is Map<String, dynamic> && data.containsKey('toilets')) {
        return data['toilets'];
      } else {
        throw Exception('Unexpected data structure: ${data.keys.join(', ')}');
      }
    } else {
      throw Exception('Failed to load toilets: ${response.reasonPhrase}');
    }
  }
}

class ClusterService {
  static Future<List<dynamic>> fetchClusters() async {
    String? token = await AuthController.getToken();
    if (token == null) {
      throw Exception('No token available');
    }
    final url = Uri.parse('https://esmagroup.online/surabhi/api/v1/get-clusters');
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); // Debugging line
      if (data is Map<String, dynamic> && data.containsKey('clusters')) {
        return data['clusters'];
      } else {
        throw Exception('Unexpected data structure: ${data.keys.join(', ')}');
      }
    } else {
      throw Exception('Failed to load clusters: ${response.reasonPhrase}');
    }
  }
}
