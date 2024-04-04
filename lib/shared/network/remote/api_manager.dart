import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news/models/NewsDataModel.dart';
import 'package:news/models/SourcesResponse.dart';
import '../../components/constants.dart';
class ApiManager {

  static Future<SourcesResponse> getSources() async {
    Uri url = Uri.https(BASE, "/v2/top-headlines/sources",
        {"apiKey": APIKEY});
    try {
      http.Response data = await http.get(url);
      var jsonData = jsonDecode(data.body);
      SourcesResponse sourcesResponse = SourcesResponse.fromJson(jsonData);
      return sourcesResponse;
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsDataModel> getNewsData(String sourceId)async{
    Uri URL=Uri.https(BASE,"/v2/everything",
        {"apiKey": APIKEY,
        "sources":sourceId
        });

   Response response=await http.get(URL);
   var jsonData=jsonDecode(response.body);
   NewsDataModel newsDataModel=NewsDataModel.fromJson(jsonData);
   return newsDataModel;


  }




}
