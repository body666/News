import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/screens/categories_screen.dart';
import 'package:news/screens/cubit/cubit.dart';
import 'package:news/screens/cubit/states.dart';
import 'package:news/screens/drawer_screen.dart';
import 'package:news/screens/home_screen.dart';
import 'package:news/screens/repo/remote_data_source.dart';
class HomeLayout extends StatelessWidget { // when we work with bloc use StatelessWidget
  static const String routeName="HomeLayout";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage("assets/images/backgroundimage.png"))
      ),
      child: BlocProvider(
        create: (context) => HomeCubit(RemoteDataSource())..getSources(),
        child: BlocConsumer<HomeCubit,HomeStates>( // BlocConsumer build only this widget
          listener: (context, state) {
            if(state is HomeDrawerSelectedState)
              {
                Navigator.pop(context);
              }
            if(state is HomeSourcesLoadingState || state is HomeNewsDataLoadingState)
              {
                showDialog(context: context,
                    barrierDismissible: false,
                    builder: (context) => const AlertDialog(
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                     title: Center(child: CircularProgressIndicator()),
                    ),
                );
              }
            else if(state is HomeGetSourcesSuccessState)
              {
                HomeCubit.get(context).getNewsData();
              }
            else if(state is HomeChangeSourceState)
              {
                HomeCubit.get(context).getNewsData();
              }
            else if(state is HomeGetSourcesErrorState) {}
            else if(state is HomeGetNewsDataSuccessState)
            {
              Navigator.pop(context);
            }
            else if(state is HomeGetNewsDataErrorState) {}
          },
          builder:(context, state) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                title: const Text("News",
                  style: TextStyle(color: Colors.white),)
                ,backgroundColor: Colors.green,
                elevation: 0.0,
                shape: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft:Radius.circular(25)),
                    borderSide: BorderSide(color: Colors.transparent)
                ),
              ),
              drawer: DrawerScreen(HomeCubit.get(context).onDrawerSelected),
              body:HomeCubit.get(context).categoryData==null?
              CategoriesScreen(HomeCubit.get(context).onCategorySelected):
              HomeScreen(HomeCubit.get(context).categoryData!),
            );
          },
        ),
      ),
    );
  }
}
