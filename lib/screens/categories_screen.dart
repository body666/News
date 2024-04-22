import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/screens/categoty_item.dart';
class CategoriesScreen extends StatelessWidget {
Function onCategorySelect;
CategoriesScreen(this.onCategorySelect);
  @override
  Widget build(BuildContext context) {
    var categories=CategoryData.getCategories();
    return Container(
      margin: EdgeInsets.all(30),
      child: Column(
        children: [
          const Text("Pick your Category of interest",
            style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30
          ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
            ),
                itemCount: categories.length,
                itemBuilder:(context, index) {
                  return InkWell(
                    onTap: (){
                      onCategorySelect(categories[index]);
                    },
                      child: CategoryItem(categories[index], index));
                }, ),
          )
        ],
      ),
    );
  }
}
