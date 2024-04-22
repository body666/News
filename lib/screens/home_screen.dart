import 'package:flutter/material.dart';
import 'package:news/models/CategoryData.dart';
import 'package:news/screens/cubit/cubit.dart';
import 'package:news/screens/drawer_screen.dart';
import 'package:news/screens/tab_controller.dart';
import '../shared/network/remote/api_manager.dart';
class HomeScreen extends StatelessWidget {
CategoryData categoryData;
HomeScreen(this.categoryData);

  @override
  Widget build(BuildContext context) {
    return TabControllerScreen();
  }
}
