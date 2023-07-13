import 'dart:ui';

import 'package:avinyaapp/modals/Classes.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/services/services.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avinyaapp/app_state.dart';
import 'package:outlined_text/outlined_text.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';


class UserFeed extends StatefulWidget {
  const UserFeed({Key? key,required this.isadmin}) : super(key: key);
  final bool isadmin;
  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  _UserFeedState(){
    readNews();
  }

  int notificationno=35;
  Constants myConstants= Constants();
  List<News> Message=[];
  List<News> ImportantMessage=[];
  Services _s = Services();
  Future<void> readNews() async{
    List<News> temp=await _s.read() as List<News>;
    List<News> dupNews= [];
    List<News> dupImpo=[];
    for(var element in temp){
      if(element.isImportant==true){
        dupImpo.add(element);
      }
      dupNews.add(element);
    }
    setState(() {
      Message = dupNews;
      ImportantMessage = dupImpo;
    });
  }

  @override
  void initstate(){
    readNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var app2 = context.watch<ApplicationState>();
    Size size= MediaQuery.of(context).size;
    bool ismember=widget.isadmin;
    Future<void> AddMessage(BuildContext context) async{
      var titlecontroller = TextEditingController();
      var desccontroller = TextEditingController();
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add news',style: TextStyle(fontSize: 32),),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(labelText: "Title",),
                  ),
                  TextField(
                    controller: desccontroller,
                    decoration: InputDecoration(labelText: "Description"),
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Important?",style: TextStyle(fontSize: 20)),
                      ToggleSwitch(
                        customWidths: [60.0, 40.0],
                        cornerRadius: 10.0,
                        activeBgColors: [[Colors.green], [Colors.redAccent]],
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ['YES', ''],
                        icons: [null, Icons.cancel],
                        onToggle: (index) {
                          app2.currentimportant=(index==0);
                          app2.notifyListeners();
                        },
                      ),
                    ],
                  )
                ],
              )
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  var currentNews = News(title: titlecontroller.text, desc: desccontroller.text, isImportant: app2.currentimportant,id: titlecontroller.text+desccontroller.text.length.toString());
                  _s.addNews(currentNews);
                  readNews();
                  app2.currentimportant=true;
                  app2.notifyListeners();
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xeeeeeeee),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(5.0),
          child: ClipRect(
            child: Image.asset("assets/profile.png"),
          ),
        ),
        title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
        elevation: 0,
        backgroundColor: Color(0xdddddddd),
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
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
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
          Positioned(top:150,child: Container(
            child:Stack(
              children: [
                ClipRRect(borderRadius:BorderRadius.circular(40),child: Image.asset("assets/UserBG.jpeg",height: size.height,fit: BoxFit.cover,alignment: Alignment.bottomCenter,),),
                ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 0,sigmaX: 0),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.black.withOpacity(0)],
                            stops: [0.5, 1]).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(40)))),
                    )
                ),
              ],
            ) ,
              height:size.height*.75,
              width:size.width,
              decoration:BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))))),
          Positioned(top:size.height*0.07,child: SizedBox(width:size.width,height:150,child: Center(child: Container(
            width:size.width*.8,
            height:150,
            decoration: BoxDecoration(
                color: Colors.blueAccent,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: myConstants.primaryColor,blurRadius: 8,offset: Offset(0,5))
              ]
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(top:-50,left:-50,child: Image.asset("assets/Announcements.png",width: 120,)),
              Positioned(top:20,left:60,child: OutlinedText(text: Text("IMPORTANT",style: TextStyle(color: Colors.red,fontSize: 24),),strokes: [OutlinedTextStroke(color: Colors.yellow,width: 3)],)),
              Positioned(top:60,left:20,child: SizedBox(width: size.width*.7,height: 80,
                child: ImportantMessage.length==0?Center(child: Text("NO IMPORTANT NEWS",style: TextStyle(color: Colors.white,fontSize: 18),)):
                Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: ListView.builder(
                    itemCount: ImportantMessage.length,
                      itemBuilder: (BuildContext context,int index){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(color: Colors.black.withOpacity(.4),blurRadius: 5,offset: Offset(0,5))
                                ]

                            ),
                            height: 50,
                            child: Center(child:
                                Text(ImportantMessage[index].title),
                            ),
                          ),
                        );

              }),
                ),))
              ]
              ,
            ),
          )))),
          Positioned(top:size.width*.65,child: SizedBox(width: size.width,height: 550,child: Center(
              child: SizedBox(
                width: size.width*.8,
                height: 9000,
                child:
                    Message.length==0?
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(height: 60,),
                          Image.asset("assets/NoEvents.png",height: 200,),
                          Text("NO NEWS YET",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),
                    ):

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: Message.length,
                    itemBuilder: (BuildContext context,int index){
                      var myapp = context.watch<ApplicationState>();
                    return GestureDetector(
                      onTap: (){
                        (myapp.selected!=index)?myapp.selected=index:myapp.selected=-1;
                        myapp.notifyListeners();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: DottedBorder(
                          strokeWidth: 3,
                          borderType: BorderType.RRect,
                          radius: Radius.circular(20),
                          dashPattern: [6,3,2,3],
                          strokeCap: StrokeCap.butt,
                          child: Container(
                            decoration: BoxDecoration(
                              color: myapp.selected==index?Colors.white:myConstants.primaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(color: Colors.black.withOpacity(.4),blurRadius: 5,offset: Offset(0,5))
                              ]

                            ),
                            height: index==myapp.selected?140:80,
                            child: Center(child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Message[index].title,style: TextStyle(
                                  fontSize: 24,
                                  color: myapp.selected!=index?Colors.white:myConstants.primaryColor,
                                  fontWeight: FontWeight.bold
                                ),),
                                Visibility(
                                    visible: myapp.selected==index,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text("Description:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                            SizedBox(width: 30,),
                                            Text(Message[index].desc,style: TextStyle(fontSize: 16),),
                                          ],
                                        ),
                                      ],
                                    ))
                              ],
                            )),
                          ),
                        ),
                      ),
                    );

                  },),
                )))))
        ],
      ),
      floatingActionButton: Visibility(
        visible: ismember,
        child: FloatingActionButton(
          onPressed: (){
            AddMessage(context);
            readNews();

          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
