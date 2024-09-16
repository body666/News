import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/screens/background_scaffold.dart';
import 'package:news/screens/settings/settings_screen.dart';
import '../cubit/HomeCubit/cubit.dart';
import '../cubit/HomeCubit/states.dart';
import '../repo/remote_data_source.dart';
import '../screens/HomeScreen/home_screen.dart';
import '../screens/category/categories_screen.dart';
import '../screens/drawer/drawer_screen.dart';
import '../screens/news/news_search_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = "HomeLayout";

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(child: BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeDrawerSelectedState) {
          Navigator.pop(context);
        } else if (state is HomeChangeCategoryState) {
          // Handle category change if needed
        } else if (state is HomeLanguageChangedState) {

        } else if (state is HomeSourcesLoadingState ||
            (state is HomeNewsDataLoadingState &&
                HomeCubit.get(context).pageNumber == 1)) {
          _showLoading(context);
        } else if (state is HomeGetSourcesSuccessState ||
            (state is HomeGetNewsDataSuccessState &&
                HomeCubit.get(context).pageNumber == 1)) {
          Navigator.pop(context); // Dismiss loading dialog
        } else if (state is HomeGetSourcesErrorState ||
            state is HomeGetNewsDataErrorState) {
          Navigator.pop(context); // Dismiss loading if there's an error
          _showError(context);
        } else if (state is HomeNoSourcesState) {
          Navigator.pop(context);
          _showNoSources(context);
        } else if (state is HomeNoMoreNewsState) {
          Navigator.pop(context);
          _showNoMoreNews(context);
        }
      },
      builder: (context, state) {
        final currentIndex = HomeCubit.get(context).currentDrawerIndex;

        Widget body;
        bool showSearchIcon = false;

        if (currentIndex == DrawerScreen.CATEGORIES) {
          body = CategoriesScreen(HomeCubit.get(context).onCategorySelected);
          showSearchIcon = false;
        } else if (currentIndex == DrawerScreen.SETTINGS) {
          body = SettingsScreen();
          showSearchIcon = false;
        } else {
          body = HomeCubit.get(context).categoryData == null
              ? CategoriesScreen(HomeCubit.get(context).onCategorySelected)
              : HomeScreen(HomeCubit.get(context).categoryData!);
          showSearchIcon = true; // Show search icon on Home screen
        }

        return Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            centerTitle: true,
            title: Text(
              HomeCubit.get(context).categoryData?.title ?? AppLocalizations.of(context)!.news_app,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w400),
            ),
            backgroundColor: Colors.green,
            elevation: 0.0,
            shape: const OutlineInputBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25)),
              borderSide: BorderSide(color: Colors.transparent),
            ),
            actions: [
              if (showSearchIcon)
                IconButton(
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: NewsSearchPage(
                          HomeCubit.get(context).categoryData),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.search,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
          drawer: DrawerScreen(HomeCubit.get(context).onDrawerSelected),
          body: body,
        );
      },
    ));
  }

  void _showLoading(BuildContext context) {
    showDialog(
      barrierColor: Colors.transparent,
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );
      },
    );
  }

  void _showError(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: const Text(
            "An error occurred while fetching data. Please try again."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showNoSources(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("No Sources"),
        content: const Text("No sources are available for this category."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void _showNoMoreNews(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("No more news articles available."),
      ),
    );
  }
}
