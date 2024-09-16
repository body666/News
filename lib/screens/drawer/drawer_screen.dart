import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class DrawerScreen extends StatelessWidget {
  final Function(int) onDrawerSelected;
  static const int CATEGORIES = 0;
  static const int SETTINGS = 1;

  DrawerScreen(this.onDrawerSelected);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: LinearBorder.none,
      width: 290,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(40),
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.only(top: 25, left: 40),
              child: Text(
                AppLocalizations.of(context)!.news_app,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: InkWell(
              onTap: () {
                onDrawerSelected(CATEGORIES);
              },
              child:  Row(
                children: [
                  const Icon(Icons.category_outlined, size: 35),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      AppLocalizations.of(context)!.categories,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: InkWell(
              onTap: () {
                onDrawerSelected(SETTINGS);
              },
              child:  Row(
                children: [
                  Icon(Icons.settings, size: 35),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      AppLocalizations.of(context)!.settings,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
