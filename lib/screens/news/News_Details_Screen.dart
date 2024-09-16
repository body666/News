import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/models/NewsDataModel.dart';
import 'package:news/screens/WebView/web_view_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news/screens/background_scaffold.dart';

class NewsDetailsScreen extends StatefulWidget {
  static const String routeName = "NewsDetailsScreen";

  final Articles articles;
  final CategoryData categoryData;

  NewsDetailsScreen({
    required this.articles,
    required this.categoryData,
  });

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  bool _showDescription = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BackgroundScaffold(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text(
          widget.categoryData.title,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        elevation: 0.0,
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr, // Force LTR for all widgets
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.articles.urlToImage ?? "",
                  width: screenSize.width,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                            color: Colors.green, value: downloadProgress.progress),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                const SizedBox(height: 5),
                Text(widget.articles.source!.name!,
                  style: const TextStyle(fontSize: 17),),
                const SizedBox(height: 10),
                Text(widget.articles.title!, style: const TextStyle(fontSize: 15),),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 140),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _showDescription = !_showDescription;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(_showDescription ? AppLocalizations.of(context)!.show_less : AppLocalizations.of(context)!.show_more,
                      style: const TextStyle(color: Colors.white),),
                  ),
                ),
                if (_showDescription) ...[
                  const SizedBox(height: 10),
                  Text(widget.articles.description!, style: const TextStyle(fontSize: 15),),
                ],
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewPage(
                            url: widget.articles.url!,
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Directionality(
                            textDirection: TextDirection.rtl, // Force RTL for "View full article"
                            child: Text(AppLocalizations.of(context)!.view_full_article)),
                        const Icon(Icons.play_arrow, size: 20),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
