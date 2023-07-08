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

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({Key? key}) : super(key: key);

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  _ProjectsPageState(){
    getallProjects();
  }

  bool isadmin=true;
  List<Projects> allProjects=[];
  Future<void> getallProjects() async{
    List<Projects> temp = await _s.readProjects() as List<Projects>;
    List<Projects> temp2=[];
    for(var element in temp){
      temp2.add(element);
    }
    setState(() {
      allProjects=temp2;
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
    Future<void> addproject(BuildContext context)async {
      String imageurl="";
      var namecontroller= TextEditingController();
      var detailcontroller= TextEditingController();
      var desccontroller= TextEditingController();
      var imagecontroller= TextEditingController();
      var websitecontroller= TextEditingController();
      PlatformFile? pickedFile;
      UploadTask? uploadTask;
      Future<void> getDownloadURL() async{
        var downloadURL = await FirebaseStorage.instance
            .ref()
            .child("files/${imagecontroller.text}")
            .getDownloadURL();
        setState(() {
          imageurl=downloadURL.toString();
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
      return showDialog(barrierDismissible:false,context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Add Project"),
          content: StatefulBuilder(builder: (BuildContext context,StateSetter setState){
            return SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    labelText: "Name"
                  ),
                ),
                TextField(
                  controller: detailcontroller,
                  decoration: InputDecoration(
                      labelText: "Details"
                  ),
                ),
                TextField(
                  controller: desccontroller,
                  decoration: InputDecoration(
                      labelText: "Description"
                  ),
                ),
                TextField(
                  controller: websitecontroller,
                  decoration: InputDecoration(
                      labelText: "WebsiteUrl"
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async {
                  selectFile();
                  setState(() {
                    imagecontroller.text=pickedFile!.name;
                  });
                  print(pickedFile!.name);
                }, child: Text("Upload Images")),
                TextField(
                  readOnly: true,
                  controller: imagecontroller,
                  decoration: InputDecoration(
                      labelText: "ImageURL"
                  ),
                ),
              ],
            ),
            );}),
          actions: [
            ElevatedButton(onPressed: (){
              getDownloadURL();
              var currentProject = Projects(ProjectName: namecontroller.text,
                  Details: detailcontroller.text,
                  Description: desccontroller.text,
                  ImageUrl: "assets/${imagecontroller.text}",
                  Websiteurl: websitecontroller.text,
                  id: namecontroller.text+(websitecontroller.text.length.toString()));
              _s.addProjectData(currentProject);

              getallProjects();
              Navigator.pop(context);
            }, child: Text("Add")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
          ],
        );

      }
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
                    child: const Center(child: OutlinedText(text: Text("PROJECTS/STARTUP",style: TextStyle(fontSize: 32),))),


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
                    for(int index=0;index<allProjects.length;index++)...[
                      Startupwidget(myConstants: myConstants, project: allProjects[index])
                    ],
            GestureDetector(
              onTap: (){
                addproject(context);

              },
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow:[BoxShadow(offset: Offset(1, 2),color: Colors.black /*myConstants.primaryColor*/,blurRadius: 5)],
                        color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(40))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: Icon(Icons.add)),
                        SizedBox(height: 10,),
                        Text("Add Project",style: GoogleFonts.poppins(fontSize: 20),)
                      ],
                    ),

                  ),
                ],
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

