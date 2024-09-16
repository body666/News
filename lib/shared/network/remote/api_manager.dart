import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news/models/NewsDataModel.dart';
import '../../../models/SourcesResponse.dart';
import '../../components/constants.dart';
class ApiManager {
 static Future<NewsDataModel> search(String query) async {
    Uri URL = Uri.https(
        BASE, "/v2/everything", {"apiKey": APIKEY, "q":query });
    try {
      Response data = await http.get(URL);
      var jsonData = jsonDecode(data.body);
      NewsDataModel newsDataModel = NewsDataModel.fromJson(jsonData);
      return newsDataModel;
    } catch (e) {
      print(e);
      throw Exception() ;
    }
  }

}
