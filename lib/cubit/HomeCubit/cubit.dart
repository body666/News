import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/cubit/HomeCubit/states.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/CategoryData.dart';
import '../../../models/NewsDataModel.dart';
import '../../../models/SourcesResponse.dart';
import '../../../repo/repository.dart';

class HomeCubit extends Cubit<HomeStates> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(HomeInitState()) {
    loadLanguage();  // Load language during initialization
  }

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Sources> sources = [];
  List<Articles> news = [];
  CategoryData? categoryData;
  int sourceIndex = 0;
  int pageNumber = 1;
  bool shouldLoadNextPage = false;
  int currentDrawerIndex = 0;
  String locale = "en";

  void loadLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = prefs.getString("lang") ?? "en";
  }

  void changeLanguage(String langCode) async {
    locale = langCode;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", langCode);
    emit(HomeLanguageChangedState());
  }



  void onDrawerSelected(int index) {
    categoryData = null;
    currentDrawerIndex = index;
    emit(HomeDrawerSelectedState());
  }

  void onCategorySelected(CategoryData categorySelected) {
    emit(HomeInitState());
    categoryData = categorySelected;
    currentDrawerIndex = -1;
    _resetNewsData();
    emit(HomeChangeCategoryState());
    getSources();
  }

  void changeSource(int index) {
    emit(HomeInitState());
    sourceIndex = index;
    _resetNewsPagination();
    getNewsData();
  }

  Future<void> getSources() async {
    emit(HomeSourcesLoadingState());
    try {
      final sourcesResponse = await homeRepo.getSources(categoryData?.id ?? "",);
      sources = sourcesResponse.sources ?? [];
      emit(HomeGetSourcesSuccessState());
      if (sources.isNotEmpty) {
        getNewsData();
      } else {
        emit(HomeNoSourcesState());
      }
    } catch (e) {
      emit(HomeGetSourcesErrorState());
    }
  }

  Future<void> getNewsData() async {
    if (sourceIndex >= sources.length || shouldLoadNextPage || isClosed) return;

    shouldLoadNextPage = true;

    if (!isClosed) {
      emit(HomeNewsDataLoadingState());
    }

    try {
      final newsDataModel = await homeRepo.getNews(
          SourceId: sources[sourceIndex].id ?? "", pageNumber: pageNumber,);

      shouldLoadNextPage = false;

      if (isClosed) return;

      if (newsDataModel.articles != null && newsDataModel.articles!.isNotEmpty) {
        if (pageNumber == 1) {
          news = newsDataModel.articles!;
        } else {
          news.addAll(newsDataModel.articles!);
        }
        if (!isClosed) {
          emit(HomeGetNewsDataSuccessState());
        }
      } else {
        if (!isClosed) {
          emit(HomeNoMoreNewsState());
        }
      }
    } catch (e) {
      shouldLoadNextPage = false;
      if (!isClosed) {
        emit(HomeGetNewsDataErrorState());
      }
    }
  }

  void _resetNewsData() {
    sources.clear();
    news.clear();
    pageNumber = 1;
    sourceIndex = 0;
  }

  void _resetNewsPagination() {
    news.clear();
    pageNumber = 1;
  }
}
