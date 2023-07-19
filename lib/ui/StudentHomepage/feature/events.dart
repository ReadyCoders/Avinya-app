import 'dart:ui';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:avinyaapp/services/services.dart';
import 'package:avinyaapp/modals/Classes.dart';
import 'package:flutter/material.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toggle_switch/toggle_switch.dart';
class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  _EventsPageState(){
    readEvents();
  }
  int eventselected=-1;
  int selectedIndex = 0;
  bool isadmin=true;
  bool light=false;
  List<Events> allEvents=[];
  List<Events> OnlineEvents=[];
  List<Events> OfflineEvents=[];
  Services _s = Services();
  void OnTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  Future<void> readEvents() async{
    List<Events> temp = await _s.readEvents() as List<Events>;
    List<Events> dupon=[];
    List<Events> dupoff=[];
    for(var element in temp){
      if(element.isonline){
        dupon.add(element);
      }
      else{
        dupoff.add(element);
      }
    }
    setState(() {
      OnlineEvents=dupon;
      OfflineEvents=dupoff;
    });
  }
  void initstate(){
    readEvents();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    int notificationno=35;
    Constants myConstants= Constants();
    Future<void> _registerEvent(BuildContext context,int index,String mode) async{
      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("$mode Event Description",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 28),),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(OnlineEvents[index].EventName.toUpperCase(),style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 24),),
                const Divider(color: Colors.black,),
                Text(OnlineEvents[index].Details,style: GoogleFonts.poppins(fontSize: 24),),
                const SizedBox(height: 10,),
                Text("Last Date to Apply: ${OnlineEvents[index].lastdate}",style: GoogleFonts.poppins(fontSize: 20),),
                const SizedBox(height: 10,),
                Text("Are you sure you want to register?",style: GoogleFonts.poppins(fontSize: 20),),
              ],
            ),
          ),
          actions: [
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
              _s.RegisterEvent(OnlineEvents[index].id);
              readEvents();
            }, child: const Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("No")),
          ],
        );
      });
    }
    Future<void> _addEvents(BuildContext context) async{
      var eventnamecontroller = TextEditingController();
      var eventDesccontroller = TextEditingController();
      var lastdatecontroller = TextEditingController();
      var registereddatecontroller = TextEditingController();
      var isRegistered= true;
      var isOnline=true;
      return showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
            return AlertDialog(
              title: const Text("Add Event"),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: eventnamecontroller,
                      decoration: const InputDecoration(
                          labelText: "Event Name"
                      ),

                    ),
                    TextField(
                      controller: eventDesccontroller,
                      decoration: const InputDecoration(
                          labelText: "Event Description"
                      ),

                    ),
                     const SizedBox(height: 20,),
                     Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Registered?",style: TextStyle(fontSize: 20)),
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
                        setState(() {
                          isRegistered=(index==0);
                        });
                      },
                    ),
                  ],
                ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("IsOnline?",style: TextStyle(fontSize: 20)),
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
                            setState(() {
                              isOnline=(index==0);
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      controller: lastdatecontroller,
                      decoration: const InputDecoration(
                        fillColor: Color(0xFFD9D9D9),
                        filled: true,
                        hintText: "Last Date",
                        border: OutlineInputBorder(),
                        icon: Icon(Icons.calendar_today),
                      ),
                      readOnly: true,
                      onTap: ()async{
                        DateTime? pickedDate = await showDatePicker(

                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2024));
                        if(pickedDate!=null){
                          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            lastdatecontroller.text=formattedDate;
                          });
                        }
                      },

                    ),
                    const SizedBox(height: 20,),
                    Visibility(
                      visible: isRegistered,
                      child: TextField(
                        controller: registereddatecontroller,
                        decoration: const InputDecoration(
                          fillColor: Color(0xFFD9D9D9),
                          filled: true,
                          hintText: "Registered Date",
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: ()async{
                          DateTime? pickedDate = await showDatePicker(

                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1990),
                              lastDate: DateTime.now());
                          if(pickedDate!=null){
                            String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              registereddatecontroller.text=formattedDate;
                            });
                          }
                        },

                      ),
                    ),

                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Add'),
                  onPressed: () {
                    var currentEvent = Events(
                        EventName: eventnamecontroller.text,
                        Details: eventDesccontroller.text,
                        isonline: isOnline,
                        lastdate: lastdatecontroller.text,
                        registereddate: (isRegistered)?registereddatecontroller.text:"",
                        registered: isRegistered,
                        id: eventnamecontroller.text+lastdatecontroller.text);
                    _s.addEventsData(currentEvent);
                    readEvents();
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
          });

    }
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xeeeeeeee),
        appBar: AppBar(
          leading: Profileroute(),
          title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
          elevation: 0,
          backgroundColor: const Color(0xdddddddd),
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
        bottom: TabBar(
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.black
          ),
          tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text("Online Events",style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.bold)),),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text("Offline Events",style: GoogleFonts.poppins(textStyle: const TextStyle(fontWeight: FontWeight.bold)),),
              ),
            )

          ],
        ),
        ),

        body:Stack(
          children: [
            Stack(
              children: [
                Image.asset("assets/UserBG.jpeg",height: size.height,fit: BoxFit.cover,alignment: Alignment.bottomCenter,),
                ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 20,sigmaX: 20),
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.black.withOpacity(0)],
                            stops: [0.4, 1]).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(color: const Color(0xdddddddd)),
                    )
                ),
              ],
            ),
            TabBarView(
            children: [
              Center(
                child: Container(
                  height: size.height*0.7,
                  width: size.width*0.95,
                  //color: Colors.red,
                  child: (OnlineEvents.length==0)?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 60,),
                        Image.asset("assets/NoEvents.png",height: 200,),
                        const Text("NO ONLINE EVENTS YET",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                      ],
                    ),
                  ):SizedBox(
                    child: ListView.builder(
                      itemCount: OnlineEvents.length,
                        itemBuilder: (BuildContext context,int index){
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 100,
                            width: size.width*0.9,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              boxShadow: [
                                BoxShadow(color: Colors.black,blurRadius: 3,offset: Offset(0,2)),
                              ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 100,width: size.width*0.5,
                                  child: SingleChildScrollView(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(OnlineEvents[index].EventName,style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 24),),
                                          const Divider(color: Colors.black,),
                                          Text(OnlineEvents[index].Details,style: GoogleFonts.poppins(fontSize: 18),)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 90,width: size.width*0.35,
                                  child: Center(child:(OnlineEvents[index].registered)?
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("Registered on",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                                        const SizedBox(height: 20,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            const Icon(Icons.calendar_today),
                                            const SizedBox(width: 10,),
                                            Text(OnlineEvents[index].registereddate,style: GoogleFonts.poppins(fontSize: 16),),
                                          ],
                                        )
                                      ],
                                    ),
                                  ):

                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text("Not Registered",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                                        const SizedBox(height: 8,),
                                        OutlinedButton(onPressed: (){
                                            _registerEvent(context,index,"Online");

                                        }, child: const Text("Register Now!!"))
                                      ],
                                    ),
                                  )),

                                )
                              ],
                            ),
                          )
                        );

                    }),
                  )
                ),
              ),
              Center(
                child: Container(
                    height: size.height*0.7,
                    width: size.width*0.95,
                    //color: Colors.red,
                    child: (OfflineEvents.length==0)?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 60,),
                          Image.asset("assets/NoEvents.png",height: 200,),
                          const Text("NO OFFINE EVENTS YET",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
                        ],
                      ),
                    ):SizedBox(
                      child: ListView.builder(
                          itemCount: OfflineEvents.length,
                          itemBuilder: (BuildContext context,int index){
                            return Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Container(
                                  height: 100,
                                  width: size.width*0.9,
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      boxShadow: [
                                        BoxShadow(color: Colors.black,blurRadius: 3,offset: Offset(0,2)),
                                      ]
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 100,width: size.width*0.5,
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(OfflineEvents[index].EventName,style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 24),),
                                                const Divider(color: Colors.black,),
                                                Text(OfflineEvents[index].Details,style: GoogleFonts.poppins(fontSize: 18),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 90,width: size.width*0.35,
                                        child: Center(child:(OfflineEvents[index].registered)?
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Registered on",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                                              const SizedBox(height: 20,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(Icons.calendar_today),
                                                  const SizedBox(width: 10,),
                                                  Text(OfflineEvents[index].registereddate,style: GoogleFonts.poppins(fontSize: 16),),
                                                ],
                                              )
                                            ],
                                          ),
                                        ):

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: [
                                              Text("Not Registered",style: GoogleFonts.poppins(fontWeight: FontWeight.bold,fontSize: 16),),
                                              const SizedBox(height: 8,),
                                              OutlinedButton(onPressed: (){
                                                _registerEvent(context,index,"Offline");

                                              }, child: const Text("Register Now!!"))
                                            ],
                                          ),
                                        )),

                                      )
                                    ],
                                  ),
                                )
                            );

                          }),
                    )
                ),
              ),


            ],
          ),]
        ),

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(color: Colors.black38,blurRadius: 10),
              ]
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.book),label: "My Resources"),
                BottomNavigationBarItem(icon: Icon(Icons.quiz),label: "Quiz"),
                BottomNavigationBarItem(icon: Icon(Icons.video_call),label: "Meet")
              ],
              selectedItemColor: myConstants.DarkBlue,
              currentIndex: selectedIndex,
              onTap: OnTapped,
            ),
          ),
        ),
        floatingActionButton: Visibility(
            visible: isadmin,
            child: FloatingActionButton(onPressed: (){
              _addEvents(context);
            },
            child: const Icon(Icons.add,color: Colors.white,),
              backgroundColor: Colors.black,
            ),

        ),
      ),
    );
  }
}
