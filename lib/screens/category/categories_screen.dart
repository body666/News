import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/screens/background_scaffold.dart';
import 'package:news/screens/category/categoty_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CategoriesScreen extends StatelessWidget {
Function onCategorySelect;
CategoriesScreen(this.onCategorySelect);
  @override
  Widget build(BuildContext context) {
    var categories=CategoryData.getCategories(context);
    return BackgroundScaffold(
      child: Container(
          margin: const EdgeInsets.all(25),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.pick_your_Category,
                style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
                color: Colors.black
              ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                ),
              )
            ],
          ),
        ),
    );
  }
}
