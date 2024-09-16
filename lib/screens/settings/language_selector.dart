import 'package:flutter/material.dart';
import 'package:news/cubit/HomeCubit/cubit.dart';

class LanguageSelector extends StatefulWidget {
  @override
  _LanguageSelectorState createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  bool _expanded = false;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _selectedLanguage = HomeCubit.get(context).locale == 'en' ? 'English' : 'Arabic';
  }

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  void _selectLanguage(String language) {
    setState(() {
      _selectedLanguage = language;
      _expanded = false;
      HomeCubit.get(context).changeLanguage(language == 'English' ? 'en' : 'ar');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.green,width: 1)
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(_selectedLanguage),
            trailing: Icon(
              _expanded ? Icons.expand_less : Icons.expand_more,
              color: Colors.grey,
            ),
            onTap: _toggleExpanded,
          ),
          if (_expanded)
            Column(
              children: [
                const Divider(height: 1),
                ListTile(
                  title: const Text('English'),
                  onTap: () => _selectLanguage('English'),
                ),
                ListTile(
                  title: const Text('Arabic'),
                  onTap: () => _selectLanguage('Arabic'),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

