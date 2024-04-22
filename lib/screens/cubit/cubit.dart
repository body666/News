import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:news/screens/cubit/states.dart';
import 'package:news/screens/drawer_screen.dart';
import '../../models/CategoryData.dart';
import '../../models/NewsDataModel.dart';
import '../../models/SourcesResponse.dart';
import '../../shared/components/constants.dart';
import '../repo/repository.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeRepo homeRepo;

  HomeCubit(this.homeRepo)
      : super(HomeInitState()); // when app create cubit I know The Stata

  static HomeCubit get(context) => BlocProvider.of(context);

  List<Sources> sources = [];
  List<Articles> articles = [];
  CategoryData? categoryData;
  int SourceIndex = 0;

  void onDrawerSelected(number) {
    if (number == DrawerScreen.CATEGORIES) {
      categoryData = null;
    }
    if (number == DrawerScreen.SETTINGS) {
      //display settings screen
    }
    emit(HomeDrawerSelectedState());
  }

  void onCategorySelected(categorySelected) {
    emit(HomeInitState());
    categoryData = categorySelected;
    emit(HomeChangeCategoryState());
  }

  void changeSource(int index) {
    emit(HomeInitState());
    SourceIndex = index;
    emit(HomeChangeSourceState());
  }

  Future<void> getSources() async {
    try {
      emit(HomeSourcesLoadingState());
      SourcesResponse sourcesResponse =
          await homeRepo.getSources(categoryData?.id ?? "");
      sources = sourcesResponse.sources ?? [];
      emit(HomeGetSourcesSuccessState());
    } catch (e) {
      print(e);
      emit(HomeGetSourcesErrorState());
      throw e;
    }
  }

  Future<void> getNewsData() async {
    try {
      emit(HomeNewsDataLoadingState());
      NewsDataModel newsDataModel =
          await homeRepo.getNews(sources[SourceIndex].id ?? "");
      articles = newsDataModel.articles ?? [];
      emit(HomeGetNewsDataSuccessState());
    } catch (e) {
      print(e);
      emit(HomeGetNewsDataErrorState());
    }
  }
}
