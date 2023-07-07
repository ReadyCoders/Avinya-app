import 'dart:ui';

import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/ui/StudentHomepage/student_homepage.dart';
import 'package:avinyaapp/ui/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;
    var myapp = context.watch<ApplicationState>();
    return LayoutBuilder(
      builder: (BuildContext , BoxConstraints ) {
       return Scaffold(
         resizeToAvoidBottomInset: false,
         backgroundColor: Color(0xeeeeeeee),
         //appBar: AppBar(backgroundColor:  Color(0xdddddddd),title: Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),),
         body: Stack(
           alignment: Alignment.bottomCenter,
           fit: StackFit.expand,
           children: <Widget>[
             Image.asset("assets/UserBG.jpeg",height: size.height,fit: BoxFit.cover,alignment: Alignment.bottomCenter,),
             ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 10,sigmaX: 10),
                 child: ShaderMask(
                   shaderCallback: (rect) {
                     return LinearGradient(
                         begin: Alignment.topCenter,
                         end: Alignment.bottomCenter,
                         colors: [Colors.black, Colors.black.withOpacity(0)],
                         stops: [0.7, 0.9]).createShader(rect);
                   },
                   blendMode: BlendMode.dstIn,
                   child: Container(color: Color(0xeeeeeeee)),
                 )
             ),
             Positioned(
                 top: 100,left: 20,
                 child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 Text("Login",style: TextStyle(fontSize: 40),),
                 SizedBox(height: 20,),
                 Container(width: size.width*.5,height: 10,
                     child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 0,sigmaX: 2),
                     child: ShaderMask(
                       shaderCallback: (rect) {
                         return LinearGradient(
                             begin: Alignment.centerLeft,
                             end: Alignment.centerRight,
                             colors: [Colors.black, Colors.black.withOpacity(0)],
                             stops: [0.4, 0.95]).createShader(rect);
                       },
                       blendMode: BlendMode.dstIn,
                       child: Container(color: Colors.black),
                     )
                 ),),
               ],)),
             Positioned(top:100,child: SizedBox(
               width: size.width*.92,
               height: size.height*.7,
               child: Center(
                 child: Container(
                   width: size.width*.8,
                   height: size.height*.4,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       //Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),

                       TextFormField(
                         decoration: InputDecoration(
                           labelText: "Email id",
                           border: OutlineInputBorder(),

                         ),
                         onChanged: (text){
                           myapp.namecontroller.text=text;
                           myapp.notifyListeners();
                         },
                       ),
                       SizedBox(height: 40,),
                       TextField(
                         obscureText: true,
                         //initialValue: "Password",
                         decoration: InputDecoration(
                           labelText: "Password",
                           border: OutlineInputBorder()
                         ),
                         onChanged: (text){
                           myapp.passwordcontroller.text=text;
                           myapp.notifyListeners();
                         },
                       ),
                       SizedBox(height: 20,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(child: Text("Forgot Password",style: TextStyle(fontSize:20,color:Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),), onPressed: () {  },),

                         ],
                       ),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           TextButton(child: Text("I Dont Have An Account",style: TextStyle(fontSize:20,color:Colors.blue,decoration: TextDecoration.underline,decorationColor: Colors.blue),),
                             onPressed: (){
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                             },)
                         ],
                       ),

                       SizedBox(height: 20,),
                       Center(child: ElevatedButton(
                         onPressed: (){
                           print(myapp.namecontroller.text);
                           print(myapp.passwordcontroller.text);
                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePageStudentsMembers()));
                         },
                         child: Text("LOGIN",style: TextStyle(fontFamily: "Open Sans",fontSize: 32),),style: ElevatedButton.styleFrom(backgroundColor: Colors.black54,foregroundColor: Colors.white),)),
                       SizedBox(height: 30,),

                     ],
                   ),
                 ),
               ),
             ),),
           ],
         ),

       );});
  }
}
