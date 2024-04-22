import 'dart:convert';
import 'package:http/http.dart';
import 'package:news/models/NewsDataModel.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:news/screens/repo/repository.dart';
import 'package:http/http.dart' as http;
import '../../shared/components/constants.dart';

class RemoteDataSource implements HomeRepo {
  @override
  Future<NewsDataModel> getNews(String SourceId) async {
    Uri URL = Uri.https(
        BASE, "/v2/everything", {"apiKey": APIKEY, "sources": SourceId});
    try {
      Response data = await http.get(URL);
      var jsonData = jsonDecode(data.body);
      NewsDataModel newsDataModel = NewsDataModel.fromJson(jsonData);
      return newsDataModel;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<SourcesResponse> getSources(String category) async {
    Uri url = Uri.https(BASE, "/v2/top-headlines/sources", {
      "apiKey": APIKEY,
      "category": category,
    });
    try {
      Response data = await http.get(url);
      var jsonData = jsonDecode(data.body);
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonData);
      return sourcesResponse;
    } catch (e) {
      throw Exception();
    }
  }
}
