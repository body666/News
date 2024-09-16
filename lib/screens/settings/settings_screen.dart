import 'package:flutter/material.dart';
import 'package:news/screens/background_scaffold.dart';
import 'language_selector.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SettingsScreen extends StatelessWidget {
  static const String routeName ="SettingsScreen";
  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(child:
        Container(
         color: Colors.transparent,
         margin: const EdgeInsets.all(10),
         child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            LanguageSelector(),
          ],
        ),
      ),

    );
  }
}