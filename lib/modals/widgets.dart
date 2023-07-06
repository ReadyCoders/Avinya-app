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
    required this.myConstants, required this.heading, required this.page, required this.Imageurl,

  });

  final Constants myConstants;
  final String heading;
  final Widget page;
  final String Imageurl;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
      },
      child: Container(decoration: BoxDecoration(
          boxShadow:[BoxShadow(offset: Offset(1, 2),color: Colors.black /*myConstants.primaryColor*/,blurRadius: 5)],
          color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30))),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0,left:0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: Text(heading,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),
                SizedBox(width:80,child: Divider()),
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage(Imageurl),
                      fit: BoxFit.cover
                    )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Startupwidget extends StatelessWidget {
  const Startupwidget({
    super.key,
    required this.myConstants, required this.heading, required this.page, required this.Imageurl, required this.StartupsList, required this.index,

  });

  final Constants myConstants;
  final String heading;
  final Widget page;
  final String Imageurl;
  final Map<String,dynamic> StartupsList;
  final int index;

  Future<void> _showDetails(BuildContext context) async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("About",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
            content: SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            color: Colors.white
                          ),
                          child: ClipOval(child: Image.asset(Imageurl,width: 60,)))),
                  Positioned(
                    top: 0,
                  left: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Text("Name: ",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(children: [SizedBox(width: 50,),Text(StartupsList.keys.toList()[index])],),
                      SizedBox(height: 10,),
                      Text("Details:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(children: [SizedBox(width: 50,),Text(StartupsList.values.toList()[index][0])],),
                      SizedBox(height: 10,),
                      Text("Description:",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Row(children: [SizedBox(width: 50,),Text(StartupsList.values.toList()[index][1])],),
                    ],
                  ),
                ),]
              ),
            ),
            actions: [
              ElevatedButton(onPressed: (){}, child: Text("VISIT WEBSITE")),
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("CANCEL"))
            ],
          );

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _showDetails(context);
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Imageurl),
                fit: BoxFit.cover,
              ),
              boxShadow:[BoxShadow(offset: Offset(1, 2),color: Colors.black /*myConstants.primaryColor*/,blurRadius: 5)],
              color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
            //child: Center(child: Text(heading,style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)),

          ),
          SizedBox(height: 20,),
          Center(child: Text(heading,style: TextStyle(color:Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
        ],
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


