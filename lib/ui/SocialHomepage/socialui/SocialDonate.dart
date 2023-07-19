import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:avinyaapp/ui/user_selection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SocialDonate extends StatefulWidget {
  const SocialDonate({Key? key}) : super(key: key);
  @override
  State<SocialDonate> createState() => _SocialDonateState();
}

class _SocialDonateState extends State<SocialDonate> {
  int selectedIndex = 0;
  void OnTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {


      int _selected=0;
      List<String> villages=["villages1","villages2","villages3","villages4","villages5","villages6","villages7"];
    Size size= MediaQuery.of(context).size;
    Constants myConstants= Constants();
    int notificationno=34;
    return Scaffold(
      backgroundColor: myConstants.bgColor,
      appBar: AppBar(
        leading: Profileroute(),
        title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        elevation: 0,
        backgroundColor: myConstants.bgColor,
        actions: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: 5,
                    right: 25,

                    child: IconButton(onPressed: (){print("Open chat");},icon: Icon(Icons.message,color: myConstants.DarkBlue,size: 35,),)),
                Positioned(
                    top: 4,
                    right: 15,
                    child: Container(
                        decoration: BoxDecoration(
                            color: myConstants.primaryColor,
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              const BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 5,
                                color: Colors.black,
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(notificationno.toString(),style: TextStyle(color: myConstants.DarkBlue,fontWeight: FontWeight.bold, fontSize: 15),),
                        )))
              ],
            ),
          )
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              top: 10,
              child: SizedBox(width:size.width,child: Center(child: Text("DONATE FOR CHANGE",style: TextStyle(color: myConstants.DarkBlue,fontSize: 30,fontWeight: FontWeight.bold))))),
          Positioned(
              top: 110,
              child: Container(

                width: size.width,
                height: size.height*0.9,
                decoration: BoxDecoration(
                  color: myConstants.DarkBlue,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                ),
              )),
          Positioned(
              top:70,
              left: 20,
              child: Container(
                width: size.width*0.9,
                height: 100,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: const Center(child: Text("BANNER HERE")),


              )),
          Positioned(
              top: 200,
              left: 20,
              child: SizedBox(
                width: size.width*0.9,
                height: 450,
                child: ListView.builder(
                    itemCount: villages.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context,int index){
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _selected=index;
                            });
                            print(_selected.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                color: _selected==index?Colors.white:myConstants.bgColor.withOpacity(0.9),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0,1),
                                    blurRadius: 5,
                                    color: Colors.white.withOpacity(.3),

                                  )
                                ]
                            ),
                            child: Center(child: Text(villages[index])),
                          ),
                        ),
                      );
                    }
                ),
              )),
          Positioned(
              top: 700,
              left: 60,
              child: Container(
                width:size.width*0.7,
                height:60,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            myConstants.bgColor.withOpacity(0.9),
                            Colors.white,
                          ]),
                    ),
                child: Center(child: Text("Give Fund",style: TextStyle(fontSize: 40,color: myConstants.DarkBlue,fontWeight: FontWeight.bold),)),))
        ],


      ),
    );
  }
}


