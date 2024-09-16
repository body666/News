import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/screens/news/news_card.dart';
import 'package:news/shared/network/remote/api_manager.dart';
class NewsSearchPage extends SearchDelegate {
  CategoryData? categoryData;
  NewsSearchPage(this.categoryData);
  @override
  String? get searchFieldLabel => "Search Article";

  @override
  TextStyle? get searchFieldStyle => const TextStyle(color: Colors.white);
  @override
  ThemeData appBarTheme(BuildContext context){
    return ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.white),
          border:InputBorder.none,),

        appBarTheme:  const AppBarTheme(
            color: Colors.green,
            shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                )
            )
        )
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (){showResults(context);},
          icon: const Icon(CupertinoIcons.search,color: Colors.white,))
    ];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Colors.white,));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.search(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.green,));
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        var articles = snapshot.data?.articles ?? [];
        if (categoryData == null) {
          return const Center(child: Text("No category data available"));
        }

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return NewsCard(articles[index], categoryData!);
          },
        );
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: ApiManager.search(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(color: Colors.green,));
        }
        if (snapshot.hasError) {
          return const Center(child: Text("Something went wrong"));
        }

        var articles = snapshot.data?.articles ?? [];
        if (categoryData == null) {
          return const Center(child: Text("No category data available"));
        }

        return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return NewsCard(articles[index], categoryData!);
          },
        );
      },
    );
  }





}
