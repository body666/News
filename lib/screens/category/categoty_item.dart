import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';

class CategoryItem extends StatelessWidget {
  final CategoryData categoryData;
  final int index;

  const CategoryItem(this.categoryData, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRtl = Directionality.of(context) == TextDirection.rtl;

    return Container(
      decoration: BoxDecoration(
        color: categoryData.color,
        borderRadius: BorderRadius.only(
          topRight: const Radius.circular(25),
          topLeft: const Radius.circular(25),
          bottomLeft: index.isEven
              ? Radius.circular(isRtl ? 0 : 25)
              : Radius.circular(isRtl ? 25 : 0),
          bottomRight: index.isOdd
              ? Radius.circular(isRtl ? 0 : 25)
              : Radius.circular(isRtl ? 25 : 0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(categoryData.image, height: 110),
          Center(
            child: Text(
              categoryData.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
