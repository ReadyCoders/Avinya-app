import 'package:flutter/material.dart';
import 'constants.dart';

class UserSelector extends StatelessWidget {
  const UserSelector({
    super.key,
    required this.size,
    required this.myConstants,
    required this.title,
    required this.page,
  });

  final Size size;
  final Constants myConstants;
  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> page));
      },
      child: Container(
          width: size.width*0.6,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.center,
                  colors: [
                    Color(0xffa9c1f5),
                    Color(0xff6696f5),
                  ]),
              boxShadow: [
                BoxShadow(
                    offset: Offset(0,3),
                    blurRadius: 5,
                    color: myConstants.DarkBlue.withOpacity(.8)
                )
              ]
          ),
          child: Center(child: Text(title,style: TextStyle(color: Colors.white,fontSize: 30),))),
    );
  }
}


class Featureswidget extends StatelessWidget {
  const Featureswidget({
    super.key,
    required this.myConstants, required this.heading, required this.page,

  });

  final Constants myConstants;
  final String heading;
  final Widget page;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>page));
      },
      child: Container(decoration: BoxDecoration(boxShadow:[BoxShadow(offset: Offset(1, 2),color: myConstants.primaryColor,blurRadius: 5)],image: DecorationImage(image: AssetImage("assets/detailbg.png"),fit: BoxFit.fill),color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0,left:0),
          child: Center(child: Text(heading,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
        ),
      ),
    );
  }
}

class memberfeature extends StatelessWidget {
  const memberfeature({
    super.key,
    required this.size, required this.width, required this.text,
  });

  final Size size;
  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    Constants myConstants= Constants();
    return Container(decoration:BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10))
    ),width:width,height:70,child: Center(child: Text(text,style: TextStyle(color: myConstants.DarkBlue,fontWeight: FontWeight.bold,fontSize: 20),)));
  }
}


