import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:avinyaapp/services/services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminSettingsPage extends StatefulWidget {
  const AdminSettingsPage({Key? key}) : super(key: key);

  @override
  State<AdminSettingsPage> createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  _AdminSettingsPageState(){
    getcodes();
  }
  Future<void> getcodes() async{
    List temp= await _s.getallCodes() as List;
    print(temp[0]);
    setState(() {
      AllCodes=temp;
    });
  }
  List AllQuotes=["Technology was the key to my freedom."];
  List AllCodes=["Loading"];
  Services _s=Services();
  @override
  Widget build(BuildContext context) {
    var quotecontroller = TextEditingController();
    var codecontroller= TextEditingController();
    Size size= MediaQuery.of(context).size;
    int notificationno=35;
    Constants myConstants= Constants();
    return Scaffold(
      backgroundColor: Color(0xeeeeeeee),
      appBar: AppBar(
        leading: Profileroute(),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                boxShadow: [
                  BoxShadow(color: Colors.black,blurRadius: 2,offset: Offset(0,6))
                ]
              ),
              height: size.height*0.4,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(child: Text("Quotes",style: GoogleFonts.poppins(fontSize: 30),)),
                    SizedBox(height: 20,),
                    Container(height: size.height*0.2,width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        border: Border.all(width: 2)
                      ),
                    child: ListView.builder(
                        itemCount: AllQuotes.length,
                        itemBuilder: (BuildContext context, int index){
                          return Container(child: Center(child: Text((index+1).toString()+". "+AllQuotes[index],style: GoogleFonts.poppins(fontSize: 24),)),);

                    }),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: quotecontroller,
                            decoration: InputDecoration(
                              labelText: "Enter new Quote",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        SizedBox(width:60,height:60,child: ElevatedButton(onPressed: (){}, child: Icon(Icons.add,color: Colors.black,)))
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(color: Colors.black,blurRadius: 2,offset: Offset(0,6))
                  ]
              ),
              height: size.height*0.4,
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Center(child: Text("Premium Codes",style: GoogleFonts.poppins(fontSize: 30),)),
                    SizedBox(height: 20,),
                    Container(height: size.height*0.2,width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 2)
                      ),
                      child: ListView.builder(
                          itemCount: AllCodes.length,
                          itemBuilder: (BuildContext context, int index){
                            return Container(child: Center(child: Text((index+1).toString()+". "+AllCodes[index],style: GoogleFonts.poppins(fontSize: 24),)),);

                          }),
                    ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Expanded(
                          child: TextField(
                            controller: codecontroller,
                            decoration: InputDecoration(
                              labelText: "Enter new Code",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        SizedBox(width:60,height:60,child: ElevatedButton(onPressed: () async {
                          print(codecontroller.text);
                          await _s.addcode(codecontroller.text);
                          getcodes();
                          setState(() {
                            codecontroller.clear();

                          });
                        }, child: Icon(Icons.add,color: Colors.black,)))
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
