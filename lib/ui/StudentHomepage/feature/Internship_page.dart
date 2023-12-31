import 'dart:developer';
import 'dart:io';
import 'package:avinyaapp/services/services.dart';
import 'package:avinyaapp/ui/StudentHomepage/feature/news_feed.dart';
import 'package:avinyaapp/modals/Classes.dart';
import 'package:avinyaapp/ui/user_selection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:outlined_text/outlined_text.dart';

class InternPage extends StatefulWidget {
  const InternPage({Key? key, required this.isadmin}) : super(key: key);
  final bool isadmin;
  @override
  State<InternPage> createState() => _InternPageState();
}

class _InternPageState extends State<InternPage> {
  _InternPageState(){
    getallInternship();
  }
  bool isadmin=true;
  List<Internship> allInternship=[];
  Future<void> getallInternship() async{
    List<Internship> temp = await _s.readInternship() as List<Internship>;
    List<Internship> temp2=[];
    for(var element in temp){
      temp2.add(element);
    }
    setState(() {
      allInternship=temp2;
    });
  }

  int selectedIndex = 0;
  void OnTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  var _s = Services();
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    int notificationno=35;
    Constants myConstants= Constants();
    bool ismember=widget.isadmin;

    Future<void> addInternship(BuildContext context) async {
      String internshipurl="";
      var namecontroller= TextEditingController();
      var job_typecontroller= TextEditingController();
      var desccontroller= TextEditingController();
      var imagecontroller= TextEditingController();
      var websitecontroller = TextEditingController();
      PlatformFile? pickedFile;
      UploadTask? uploadTask;
      Future<void> getDownloadURL() async{
        var downloadURL = await FirebaseStorage.instance
            .ref()
            .child("files/${imagecontroller.text}")
            .getDownloadURL();
        setState(() {
          internshipurl=downloadURL.toString();
        });
      }
      Future selectFile() async{
        final result = await FilePicker.platform.pickFiles();
        if(result==null) return;
        setState(() {
          pickedFile=result.files.first;
          imagecontroller.text=pickedFile!.name;
        });
        final path= 'files/${pickedFile!.name}';

        final file = File(pickedFile!.path!);

        final ref= FirebaseStorage.instance.ref().child(path);

        ref.putFile(file);
      }

      // add option in admin side
      if (ismember) {
        return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Add Internship"),
              content: StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: namecontroller,
                        decoration: InputDecoration(
                          labelText: "Company Name",
                        ),
                      ),
                      TextField(
                        controller: job_typecontroller,
                        decoration: InputDecoration(
                          labelText: "Job_Type",
                        ),
                      ),
                      TextField(
                        controller: desccontroller,
                        decoration: InputDecoration(
                          labelText: "Description",
                        ),
                      ),
                      TextField(
                        controller: websitecontroller,
                        decoration: InputDecoration(
                          labelText: "WebsiteUrl",
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          selectFile();
                          setState(() {
                            imagecontroller.text = pickedFile!.name;
                          });
                          print(pickedFile!.name);
                        },
                        child: Text("Upload Images"),
                      ),
                      TextField(
                        readOnly: true,
                        controller: imagecontroller,
                        decoration: InputDecoration(
                          labelText: "internshipurl",
                        ),
                      ),
                    ],
                  ),
                );
              }),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    getDownloadURL();
                    var currentInternship = Internship(
                      name: namecontroller.text,
                      job_type: job_typecontroller.text,
                      description: desccontroller.text,
                      imageUrl: "assets/${imagecontroller.text}",
                      websiteUrl: websitecontroller.text,
                      id: namecontroller.text + (imagecontroller.text.length.toString()),
                    );
                    _s.addInternData(currentInternship);

                    getallInternship();
                    Navigator.pop(context);
                  },
                  child: Text("Add"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ],
            );
          },
        );
      }
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

          Positioned(
              top: 50,
              child: Container(

                width: size.width,
                height: size.height*0.9,
                decoration: BoxDecoration(
                  //color: myConstants.secondaryColor,
                  image: DecorationImage(
                      image: AssetImage("assets/UserBG.jpeg",),
                      fit: BoxFit.cover
                  ),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                ),

              )),
          Positioned(
              top:15,
              left: 0,
              child: SizedBox(
                width: size.width,
                child: Center(
                  child: Container(
                    width: size.width*0.8,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: const Center(child: OutlinedText(text: Text("Internship and Jobs",style: TextStyle(fontSize: 32),))),


                  ),
                ),
              )),
          Positioned(
              top: 155,
              left: 20,
              child: SizedBox(
                width: size.width*0.9,
                height: size.height*0.6,
                child: GridView.count(crossAxisCount: 3,
                  shrinkWrap: true,
                  childAspectRatio: (1/1.4),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 50,
                  children: [
                    for(int index=0;index<allInternship.length;index++)...[
                      Startupinternship(myConstants: myConstants, internship: allInternship[index])
                    ],
          // Replace this with your actual condition

                    Visibility(
                      visible: ismember,
                      child: GestureDetector(
                        onTap: () {
                          addInternship(context);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black, blurRadius: 5)],
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(40)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(child: Icon(Icons.add)),
                                  SizedBox(height: 10,),
                                  Text("Add Internship", style: GoogleFonts.poppins(fontSize: 20),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )


                  ],),
              ))
          /*Positioned(
              child: Text("Details here"),

          ),*/
        ],

      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38,blurRadius: 10),
            ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
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
    );
  }
}

