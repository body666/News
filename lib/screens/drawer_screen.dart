import 'package:flutter/material.dart';
class DrawerScreen extends StatelessWidget {
Function onDrawerSelected;
DrawerScreen(this.onDrawerSelected);
static const int CATEGORIES=0;
static const int SETTINGS=1;


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 30),
            color: Colors.green,
            child: const Text("News App!",
                textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: Colors.white
            ),),
          ),
          const SizedBox(height: 10,),
          InkWell(
            onTap: (){
              onDrawerSelected(CATEGORIES);
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Categories",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          InkWell(
            onTap: () {
              onDrawerSelected(SETTINGS);
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("Settings",
                style: TextStyle(
                  fontSize: 18,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
