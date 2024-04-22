import 'package:flutter/material.dart';
import 'package:news/models/NewsDataModel.dart';
import 'package:news/screens/cubit/cubit.dart';
import 'package:news/screens/cubit/states.dart';
import 'package:news/screens/news_card.dart';
import 'package:news/screens/tab_item.dart';
import 'package:news/shared/network/remote/api_manager.dart';
import '../models/SourcesResponse.dart';
class TabControllerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
            length: HomeCubit.get(context).sources.length,
            child: TabBar(
              onTap: (index) {
                HomeCubit.get(context).changeSource(index);
              },
              isScrollable: true,
              indicatorColor: Colors.transparent,
              tabs: HomeCubit.get(context).sources
                  .map((source) => Tab(
                        child: TabItem(source,
                            HomeCubit.get(context).sources.indexOf(source) == HomeCubit.get(context).SourceIndex),
                      ))
                  .toList(),
            )
        ),
        Expanded(
          child: ListView.builder(
            itemCount: HomeCubit.get(context).articles.length,
            itemBuilder: (context, index) {
              return NewsCard(HomeCubit.get(context).articles[index]);
            },
          ),
        )

      ],
    );
  }
}
