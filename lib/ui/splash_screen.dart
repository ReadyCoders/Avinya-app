import 'dart:async';
import 'package:avinyaapp/ui/user_selection.dart';
import 'package:flutter/material.dart';

import '../modals/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 4), ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const UserSelection()))
    );
  }

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: myConstants.bgColor,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: size.height*0.2,
              child: SizedBox(
                width: size.width,
                height: 400,
                child: Column(
            children: [
                Center(child: Image.asset("assets/avinyaLogo.jpg",height: 200,)),
                const SizedBox(height: 20,),
                Center(child: Text("AVINYA",style: TextStyle(fontSize: 70,fontWeight: FontWeight.bold,color: myConstants.DarkBlue),)),


            ],
          ),
              )),
          Positioned(bottom: 80,
              right: size.width*0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text("Powered By",style: TextStyle(fontSize: 30),),
              Text("Readycoder",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),)
            ],
          )),
        ],
      ),
    );
  }
}
