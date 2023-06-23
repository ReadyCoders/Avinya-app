import 'package:avinyaapp/modals/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avinyaapp/app_state.dart';
import 'package:outlined_text/outlined_text.dart';
import 'package:provider/provider.dart';

class UserFeed extends StatefulWidget {
  const UserFeed({Key? key}) : super(key: key);

  @override
  State<UserFeed> createState() => _UserFeedState();
}

class _UserFeedState extends State<UserFeed> {
  @override
  Widget build(BuildContext context) {
    var myapp= context.watch<ApplicationState>;
    Size size= MediaQuery.of(context).size;
    int notificationno=35;
    Constants myConstants= Constants();
    Map<String,dynamic> Message={};
    Map<String,dynamic> ImportantMessage={};
    //var ImportantMessage= {"Title1":"Description1","Title2":"Description2","Title3":"Description3","Title4":"Description4","Title5":"Description5","Title6":"Description6","Title7":"Description7"};
    //var Message= {"Title1":"Description1","Title2":"Description2","Title3":"Description3","Title4":"Description4","Title5":"Description5","Title6":"Description6","Title7":"Description7"};
    bool ismember=false;

    Future<void> AddMessage(BuildContext context) async{
      var titlecontroller = TextEditingController();
      var desccontroller = TextEditingController();
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add news'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titlecontroller,
                    decoration: InputDecoration(labelText: "Title"),
                  ),
                  TextField(
                    controller: desccontroller,
                    decoration: InputDecoration(labelText: "Description"),
                  )
                ],
              )
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Add'),
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
          Positioned(top:150,child: Container(height:size.height*.75,width:size.width,decoration:BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))))),
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
                                Text(ImportantMessage.keys.toList()[index]),
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
                        myapp.selected=index;
                        myapp.notifyListeners();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                              Text(Message.keys.toList()[index]),
                              Visibility(
                                  visible: myapp.selected==index,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 30,),
                                      Text(Message.values.toList()[index]),
                                    ],
                                  ))
                            ],
                          )),
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

          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
