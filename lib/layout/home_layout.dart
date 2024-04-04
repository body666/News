import 'package:flutter/material.dart';
import 'package:news/screens/tab_controller.dart';
import 'package:news/shared/network/remote/api_manager.dart';
class HomeLayout extends StatelessWidget {
  static const String routeName="HomeLayout";
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage("assets/images/backgroundimage.png"))
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text("News ",
          style: TextStyle(color: Colors.white),)
            ,backgroundColor: Colors.green,
          elevation: 0.0,
          shape: const OutlineInputBorder(borderRadius:
          BorderRadius.only(bottomRight: Radius.circular(25),bottomLeft:Radius.circular(25)),
            borderSide: BorderSide(color: Colors.transparent)
          ),
        ),
        body:
      ),
    );
  }
}
