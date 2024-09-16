import 'package:news/models/NewsDataModel.dart';
import 'package:news/models/SourcesResponse.dart';
abstract class HomeRepo{
 Future<SourcesResponse> getSources(String category);
 Future<NewsDataModel> getNews({required String SourceId,int? pageNumber,});


}