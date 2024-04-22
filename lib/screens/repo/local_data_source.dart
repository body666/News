import 'package:news/models/NewsDataModel.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:news/screens/repo/repository.dart';

class LocalDataSource implements HomeRepo{
  @override
  Future<NewsDataModel> getNews(String SourceId) {
    // TODO: implement getNews
    throw UnimplementedError();
  }

  @override
  Future<SourcesResponse> getSources(String category) {
    // TODO: implement getSources
    throw UnimplementedError();
  }

}