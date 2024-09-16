import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/screens/news/News_Details_Screen.dart';
import '../../models/NewsDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
class NewsCard extends StatelessWidget {

 Articles articles;
 CategoryData categoryData;
 NewsCard(this.articles,this.categoryData);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 5,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding:const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
           border: Border.all(color: Colors.green,width: 2)
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetailsScreen(articles: articles,categoryData: categoryData),));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl:articles.urlToImage??"",
                height: 220,
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.green,
                          value: downloadProgress.progress),
                    ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(articles.author??"",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(articles.title??"",
                  style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
                ),
              ),
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(articles.publishedAt!.substring(0,10)??"",textAlign: TextAlign.right,)),

            ],
          ),
        ),
      ),
    ) ;
  }
}
