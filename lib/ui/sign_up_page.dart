import 'dart:ui';

import 'package:avinyaapp/app_state.dart';
import 'package:avinyaapp/modals/Classes.dart';
import 'package:avinyaapp/modals/constants.dart';
import 'package:avinyaapp/modals/widgets.dart';
import 'package:avinyaapp/services/services.dart';
import 'package:avinyaapp/ui/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignUpPage> {
  var _s = Services();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
        builder: (BuildContext , BoxConstraints ) {
          var myapp= context.watch<ApplicationState>();
          return GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
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
                              stops: [0.8, 0.95]).createShader(rect);
                        },
                        blendMode: BlendMode.dstIn,
                        child: Container(color: Color(0xeeeeeeee)),
                      )
                  ),
                  Positioned(
                      top: 80,right: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Signup",style: TextStyle(fontSize: 40),),
                          SizedBox(height: 20,),
                          Container(width: size.width*.6,height: 10,
                            child: ImageFiltered(imageFilter: ImageFilter.blur(sigmaY: 0,sigmaX: 2),
                                child: ShaderMask(
                                  shaderCallback: (rect) {
                                    return LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [Colors.black, Colors.black.withOpacity(0)],
                                        stops: [0.2, 0.9]).createShader(rect);
                                  },
                                  blendMode: BlendMode.dstOut,
                                  child: Container(color: Colors.black),
                                )
                            ),),
                        ],)),
                  Positioned(top:150,child: SizedBox(
                    width: size.width*.92,
                    height: size.height*.8,
                    child: Center(
                      child: SizedBox(
                        width: size.width*.8,
                        height: size.height*.7,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Center(child: Text("AVINYA", style: TextStyle(color: myConstants.DarkBlue,fontSize: 50),)),
                              ReusableTextfields(controller: myapp.namecontroller, isPassword: false, icon: Icons.person, text: "User Name"),
                              SizedBox(height: 40,),
                              ReusableTextfields(controller: myapp.emailController, isPassword: false, icon: Icons.message, text: "Email id"),
                              SizedBox(height: 40,),
                              TextField(
                                controller: myapp.datecontroller,
                                decoration: InputDecoration(
                                  fillColor: const Color(0xFFD9D9D9),
                                  filled: true,
                                  hintText: "Date Of Birth",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
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
                                      myapp.datecontroller.text=formattedDate;
                                      myapp.notifyListeners();
                                    });
                                  }
                                },

                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text("Choose Role",style: TextStyle(fontSize: 20),),
                                  Spacer(),
                                  DropdownButton(
                                      value: myapp.dropdown,
                                      icon: Icon(Icons.person),
                                      underline: Container(height: 2,width: size.width,color: Colors.black,),
                                      items: myapp.roleselection.map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? value){
                                        myapp.dropdown=value!;
                                        myapp.notifyListeners();
                                      }),
                                ],
                              ),
                              SizedBox(height: 30,),
                              ReusableTextfields(controller: myapp.passwordcontroller, isPassword: true, icon: Icons.lock, text: "Password"),
                              SizedBox(height: 40,),
                              ReusableTextfields(controller: myapp.confirmpasswordcontroller, isPassword: true, icon: Icons.lock_open, text: "Confirm Password"),
                              SizedBox(height: 40,),
                              Center(child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(backgroundColor: Colors.black54,foregroundColor: Colors.white),
                                  onPressed: (){
                                    if(myapp.passwordcontroller.text==myapp.confirmpasswordcontroller.text && myapp.namecontroller.text!=null && myapp.datecontroller.text!=null &&
                                    myapp.emailController.text!="" && myapp.passwordcontroller.text!="" && myapp.confirmpasswordcontroller.text!="") {
                                      var currentuser = Users(
                                          Username: myapp.namecontroller.text,
                                          emailid: myapp.emailController.text,
                                          Dob: myapp.datecontroller.text,
                                          role: myapp.dropdown,
                                          id: myapp.emailController.text+(myapp.passwordcontroller.text.length.toString()));
                                      FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                          email: myapp.emailController.text,
                                          password: myapp.passwordcontroller.text)
                                          .then((value) {
                                            print("Created user");
                                            FirebaseAuth.instance.currentUser?.updateDisplayName(myapp.namecontroller.text);
                                        _s.addUser(currentuser);
                                        myapp.namecontroller.clear();
                                        myapp.emailController.clear();
                                        myapp.datecontroller.clear();
                                        myapp.passwordcontroller.clear();
                                        myapp.confirmpasswordcontroller.clear();
                                        myapp.dropdown="Student/Member";
                                        myapp.notifyListeners();
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    LoginPage()));
                                      }).onError((error, stackTrace) {
                                        print("Error: ${error.toString()}");
                                      });
                                    }
                                    else if(myapp.passwordcontroller.text!=myapp.confirmpasswordcontroller.text){
                                      final snackbar = SnackBar(content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text("Passwords dont match"),
                                      ));
                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    }
                                    else{
                                      final snackbar = SnackBar(content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: const Text("Please fill all the fields"),
                                      ));
                                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                                    }
                              }, child: Text("Register",style: TextStyle(fontFamily: "Open Sans",fontSize: 32),))),


                            ],
                          ),
                        ),
                      ),
                    ),
                  ),),
                ],
              ),

            ),
          );});
  }
}
