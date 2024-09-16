import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../cubit/HomeCubit/cubit.dart';
import '../../models/CategoryData.dart';
import '../news/news_card.dart';
import '../tab/tab_item.dart';

class HomeScreen extends StatefulWidget {
  CategoryData categoryData;
  HomeScreen(this.categoryData);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() async {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      const delta = 200.0;
      if (maxScroll - currentScroll <= delta) {
        if (!HomeCubit.get(context).shouldLoadNextPage) {
          if (!HomeCubit.get(context).isClosed) {
            HomeCubit.get(context).pageNumber++;
            await HomeCubit.get(context).getNewsData();
          }
        }
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _refreshNews() async {
    HomeCubit.get(context).news.clear();
    HomeCubit.get(context).pageNumber++; // Reset to the first page
    await HomeCubit.get(context).getNewsData();
  }

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
              child: TabItem(
                  source,
                  HomeCubit.get(context)
                      .sources
                      .indexOf(source) ==
                      HomeCubit.get(context).sourceIndex),
            ))
                .toList(),
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshNews,
            child: ListView.builder(
              controller: scrollController,
              itemCount: HomeCubit.get(context).news.length + 1,
              itemBuilder: (context, index) {
                if (index == HomeCubit.get(context).news.length) {
                  return HomeCubit.get(context).shouldLoadNextPage
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  )
                      : const SizedBox.shrink();
                }
                return NewsCard(
                    HomeCubit.get(context).news[index], widget.categoryData);
              },
            ),
          ),
        ),
      ],
    );
  }
}
