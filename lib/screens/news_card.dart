import 'package:flutter/material.dart';
import '../models/NewsDataModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
class NewsCard extends StatelessWidget {

 Articles articles;
 NewsCard(this.articles);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:   EdgeInsets.symmetric(vertical: 6),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.green)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CachedNetworkImage(
            imageUrl:articles.urlToImage??"",
            height: 180   ,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                      value: downloadProgress.progress),
                ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Text(articles.author??"",
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
            ),
          ),
          Text(articles.title??"",
            style: TextStyle(
            fontSize: 16,
            color: Colors.black,
              fontWeight: FontWeight.bold
          ),
          ),
          Text(articles.publishedAt!.substring(0,10)??"",textAlign: TextAlign.right,),

        ],
      ),
    ) ;
  }
}
