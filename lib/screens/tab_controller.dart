import 'package:flutter/material.dart';
import 'package:news/models/NewsDataModel.dart';
import 'package:news/screens/news_card.dart';
import 'package:news/screens/tab_item.dart';
import 'package:news/shared/network/remote/api_manager.dart';
import '../models/SourcesResponse.dart';

class TabControllerScreen extends StatefulWidget {
  List<Sources> sources;
  TabControllerScreen(this.sources);

  @override
  State<TabControllerScreen> createState() => _TabControllerScreenState();
}

class _TabControllerScreenState extends State<TabControllerScreen> {
  int SelectedIndex = 0;

  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        DefaultTabController(
            length: widget.sources.length,
            child: TabBar(
              onTap: (index) {
                SelectedIndex = index;
                setState(() {});
              },
              isScrollable: true,
              indicatorColor: Colors.transparent,
              tabs: widget.sources
                  .map((source) => Tab(
                        child: TabItem(source,
                            widget.sources.indexOf(source) == SelectedIndex),
                      ))
                  .toList(),
            )),
        FutureBuilder<NewsDataModel>(
          future: ApiManager.getNewsData(widget.sources[SelectedIndex].id??""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(
                color: Colors.green,
              ));
            }
            if (snapshot.hasError || snapshot.data?.status != "ok") {
              return Column(
                children: [
                  Text(snapshot.data?.message ?? "Has Error"),
                  TextButton(onPressed: () {}, child: Text("Try Again"))
                ],
              );
            }

            var news=snapshot.data?.articles??[];
            return Expanded(
              child: ListView.builder(
                itemCount: news.length,
                  itemBuilder:(context, index) {
                    return NewsCard(news[SelectedIndex]);
                  }, ),
            );
          },
        )
      ],
    );
  }
}
