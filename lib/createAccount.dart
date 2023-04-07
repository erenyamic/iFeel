import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'package:ifeel/loginPage.dart';
import 'package:ifeel/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class createAccount extends StatefulWidget{
  State createState()=> CreateAccount();
}
class CreateAccount extends State{

  var t1=TextEditingController();
  var t2=TextEditingController();
  var _auth;var _obScure=true;
  var sayac=1;
  IconData icon=Icons.remove_red_eye_outlined;

  void kayitOl(){
    if(t1.text!=""&&t2.text!=""){
      try{
        _auth.createUserWithEmailAndPassword(email: t1.text, password: t2.text).catchError((dynamic onError){
          if(onError.toString().contains("email-already-in-use")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Email zaten kullanılıyor !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }else if(onError.toString().contains("invalid-email")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Geçersiz email !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }else if(onError.toString().contains("operation-not-allowed")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("İzin hatası !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }else if(onError.toString().contains("weak-password")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Şifre zayıf !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }
        }).then((value)async{
          if(!_auth.currentUser!.emailVerified){
                await _auth.currentUser!.sendEmailVerification();
            var _snackBar=new SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Email doğrulama linki maile gönderildi",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);

                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                  return loginPage();
                }), (route) => false);
          }else{
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
              return loginPage();
            }), (route) => false);
          }
        });

      }catch(e){
        print(e.toString());
      }
    }else{
      var _snackbar=new SnackBar(content: Row(children: [
        Icon(Icons.warning_amber,color: Colors.white,),
        Padding(padding: EdgeInsets.only(left: 10),child: Text("Boş bırakılamaz !",style: TextStyle(fontWeight: FontWeight.bold),),)
      ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
      ScaffoldMessenger.of(context).showSnackBar(_snackbar);
    }

  }
  @override
  void initState(){
    _auth=FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child:Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/img/login_background2.png"),
              fit: BoxFit.cover
            )
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40.0),topRight: Radius.circular(40.0))
              ),
              height: MediaQuery.of(context).size.height/2,
              width: double.infinity,
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(left: 35,right: 35,top: 35,bottom: 5),child: Align(child: Text(
                    "Üye Ol",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                  ),alignment: Alignment.topLeft,)),
                  Padding(padding: EdgeInsets.only(left: 35,right: 35),child: Align(child: Text(
                    "iFeel'e giriş yapmak için üye olun.",style: TextStyle(color: Colors.grey.shade800),
                  ),alignment: Alignment.topLeft,)),
                  Padding(padding: EdgeInsets.only(top: 25,bottom: 5,left: 35,right: 35),child: Align(alignment: Alignment.center,child: TextField(controller: t1,decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),labelText: "Email",prefixIcon: Icon(Icons.email,color: Color.fromRGBO(237, 125, 105, 1.0),)
                  ),),),),
                  Padding(padding: EdgeInsets.only(top: 5,bottom: 5,left: 35,right: 35),child: Align(alignment: Alignment.center,child: TextField(obscureText: _obScure,controller: t2,decoration: InputDecoration(
                    labelText: "Şifre",
                      suffixIcon: InkWell(onTap: (){
                        setState(() {
                          if(sayac%2==0){
                            _obScure=true;
                            icon=Icons.remove_red_eye_outlined;
                          }

                          else{
                            _obScure=false;
                            icon=FontAwesomeIcons.eyeSlash;
                          }

                          sayac++;
                        });
                      },child: Icon(icon),),
                    prefixIcon: Icon(Icons.lock,color: Color.fromRGBO(237, 125, 105, 1.0),),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                  ),),),),
                  Padding(padding: EdgeInsets.only(top: 10,bottom: 5),child: Align(alignment: Alignment.center,child: SizedBox(width: 120,child: ElevatedButton(onPressed: kayitOl, child: Text("Kayıt Ol"),style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30,vertical: 15)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(237, 125, 105, 1.0))
                  ),),),),),
                  Padding(padding: EdgeInsets.only(bottom: 30),child: Align(alignment: Alignment.center,child: SizedBox(width: 120,child: ElevatedButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>loginPage()));
                  }, child: Text("Giriş Yap"),style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15,horizontal: 30)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(237, 125, 105, 1.0))
                  ),),)),)
                ],
              ),
            ),
          )
        )
      )
    );
  }
}