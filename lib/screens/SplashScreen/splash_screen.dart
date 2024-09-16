
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/cubit/HomeCubit/cubit.dart';
import 'package:news/layout/home_layout.dart';
import 'package:news/screens/category/categories_screen.dart';
import 'package:provider/provider.dart';
 class SplashScreen extends StatefulWidget{
 static const String routeName="SplashScreen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
   void initState() {
    Future.delayed(const Duration(seconds: 3),(){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeLayout()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      body: Center(
        child: Column(
         children: [
            Expanded(
              child: Image.asset(
              "assets/images/splash.png",
                fit: BoxFit.cover,
                width:double.infinity,),
            )
         ],
        ),
      ),
   );
  }
}