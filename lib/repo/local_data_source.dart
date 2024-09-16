import 'package:news/models/NewsDataModel.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:news/repo/repository.dart';

class LocalDataSource implements HomeRepo {
  @override
  Future<SourcesResponse> getSources(
    String category,
  ) {
    // TODO: implement getSources
    throw UnimplementedError();
  }

  @override
  Future<NewsDataModel> getNews(
      {required String SourceId, int? pageNumber, String? language}) {
    // TODO: implement getNews
    throw UnimplementedError();
  }
}
