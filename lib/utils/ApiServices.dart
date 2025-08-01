import 'dart:convert';
import 'package:git_pull_request_viewer/utils/token_service.dart';
import 'package:http/http.dart' as http;
import '../modules/pull_request/model/pull_request.dart';


class ApiService {
  static const String baseUrl = 'https://api.github.com/repos/Shubham921/git_pull_request_viewer/pulls';





  static Future<List<PullRequest>> fetchPullRequests() async {
    final token = await TokenService.getToken();

    final isFakeToken = token == null || token == "abc123";

    final headers = {
      'Accept': 'application/vnd.github+json',
      if (!isFakeToken) 'Authorization': 'Bearer $token',
    };

    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => PullRequest.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load pull requests');
    }
  }

}
