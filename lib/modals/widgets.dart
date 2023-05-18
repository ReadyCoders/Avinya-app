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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> page));
        print(title+" Pressed");
      },
      child: Container(
          width: size.width,
          height: size.height*.15,
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
                    color: myConstants.avinyaText.withOpacity(.8)
                )
              ]
          ),
          child: Center(child: Text(title,style: TextStyle(color: myConstants.avinyaText,fontSize: 30),))),
    );
  }
}
