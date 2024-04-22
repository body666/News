import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
class CategoryItem extends StatelessWidget {

 CategoryData categoryData;
 CategoryItem(this.categoryData,this.index);
 int index;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: categoryData.color,
        borderRadius: BorderRadius.only(
          topRight:Radius.circular(25),
          topLeft: Radius.circular(25),
          bottomLeft: index.isEven?Radius.circular(25):Radius.zero,
          bottomRight: index.isOdd?Radius.circular(25):Radius.zero,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(categoryData.image,height: 110,),
          Center(
            child: Text(categoryData.title,style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22
            ),
            ),
          ),
        ],
      ),
    );
  }
}
