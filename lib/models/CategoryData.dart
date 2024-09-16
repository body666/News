import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class CategoryData {
  String id;
  String title;
  String image;
  Color color;

  CategoryData(this.id, this.title, this.image, this.color);

  static List<CategoryData> getCategories(BuildContext context) {
    return [
      CategoryData("sports",AppLocalizations.of(context)!.sports , "assets/images/ball.png",
          const Color(0xFFC71C22)),
      CategoryData("technology",AppLocalizations.of(context)!.technology , "assets/images/technology.png",
          const Color(0xFF003E8F)),
      CategoryData("health", AppLocalizations.of(context)!.health, "assets/images/health.png",
          const Color(0xFFED1E79)),
      CategoryData("business", AppLocalizations.of(context)!.business, "assets/images/bussines.png",
          const Color(0xFFCD7D47)),
      CategoryData("general",AppLocalizations.of(context)!.general,
          "assets/images/environment.png", const Color(0xFF4781CD)),
      CategoryData("science", AppLocalizations.of(context)!.science, "assets/images/science.png",
          const Color(0xFFF2D352)),
    ];
  }
}
