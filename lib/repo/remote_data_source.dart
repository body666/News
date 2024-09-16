import 'dart:convert';
import 'package:http/http.dart';
import 'package:news/models/NewsDataModel.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:http/http.dart' as http;
import 'package:news/repo/repository.dart';
import '../../shared/components/constants.dart';

class RemoteDataSource implements HomeRepo {
  @override
  Future<SourcesResponse> getSources(String category,) async {
    Uri url = Uri.https(BASE, "/v2/top-headlines/sources", {
      "apiKey": APIKEY,
      "category": category,
    });
    try {
      final Response data = await http.get(url);
      if (data.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(data.body);
        final SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonData);
        return sourcesResponse;
      } else {
        throw Exception("Failed to load sources. Status Code: ${data.statusCode}");
      }
    } catch (e, stacktrace) {
      print("Error fetching sources: $e");
      print("Stacktrace: $stacktrace");
      throw Exception("Failed to fetch sources: $e");
    }
  }

  @override
  Future<NewsDataModel> getNews({required String SourceId, int? pageNumber}) async {
    Uri URL = Uri.https(BASE, "/v2/everything", {
      "apiKey": APIKEY,
      "sources": SourceId,
      "pageSize": "10",
      "page": "$pageNumber",
    });
    try {
      Response data = await http.get(URL);
      var jsonData = jsonDecode(data.body);
      NewsDataModel newsDataModel = NewsDataModel.fromJson(jsonData);
      if (data.statusCode == 200) {
        return newsDataModel;
      } else {
        throw Exception("Failed to load news data");
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }
}
