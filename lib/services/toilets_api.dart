import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:surabhi/model/toilet/toilet_model.dart';

class ApiService {
  final String baseUrl = 'https://esmagroup.online/surabhi/api/v1/';

  Future<List<Toilet>> fetchToilets() async {
    final response = await http.get(Uri.parse('${baseUrl}toilets'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status']) {
        List<Toilet> toilets = (data['toilets'] as List)
            .map((toiletJson) => Toilet.fromJson(toiletJson))
            .toList();
        return toilets;
      } else {
        throw Exception(data['message']);
      }
    } else {
      throw Exception('Failed to load toilets');
    }
  }
}
