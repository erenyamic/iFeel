import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ifeel/createAccount.dart';
import 'package:ifeel/homepage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:ifeel/googleSignIn.dart';


class loginPage extends StatefulWidget{
  State createState()=>_loginPage();
}
class _loginPage extends State{

  var t1=TextEditingController();
  var t2=TextEditingController();
  var _auth;var _obScure=true;var sayac=1;
  IconData icon=Icons.remove_red_eye_outlined;

  void girisYap(){
    if(t1.text!=""&&t2.text!=""){
      try {
        _auth.signInWithEmailAndPassword(
            email: t1.text,
            password: t2.text
        ).catchError((dynamic error){
          if(error.toString().contains("invalid-email")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Geçersiz email !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }else if(error.toString().contains("user-disabled")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Kullanıcı aktif değil !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }else if(error.toString().contains("user-not-found")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Kullanıcı bulunamadı !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }else if(error.toString().contains("wrong-password")){
            var _snackBar=new SnackBar(content: Row(children: [
              Icon(Icons.warning_amber,color: Colors.white,),
              Padding(padding: EdgeInsets.only(left: 10),child: Text("Şifre yanlış !",style: TextStyle(fontWeight: FontWeight.bold),),)
            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
          }
        }).then((value){
          if(_auth.currentUser!.emailVerified){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
              return homepage();
            }), (route) => false);
          }else{
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                backgroundColor: Colors.transparent,
                actions: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Icon(Icons.warning_amber,size: 100,color: Colors.red,),),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Text("Email adresinizi doğrulamalısınız !"),),
                        Padding(padding: EdgeInsets.symmetric(vertical: 10,horizontal: 35),child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                          Padding(padding: EdgeInsets.only(right: 5),child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),onPressed: ()async{
                            await _auth.currentUser!.sendEmailVerification();
                            var _snackBar=new SnackBar(content: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                              Icon(Icons.warning_amber,color: Colors.white,),
                              Padding(padding: EdgeInsets.only(left: 10),child: Text("Email doğrulama linki maile gönderildi",style: TextStyle(fontWeight: FontWeight.bold),),)
                            ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
                            ScaffoldMessenger.of(context).showSnackBar(_snackBar);
                            Navigator.pop(context);
                          }, child: Text("Doğrula")),),
                          Padding(padding: EdgeInsets.only(left: 5),child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey)),onPressed: (){Navigator.pop(context);}, child: Text("İptal")),),
                        ],),),
                      ],
                    ),
                  )
                ],
              );
            });
          }
        });
      }catch (e) {
        print(e.toString());
      }
    }else{
      var _snackBar=new SnackBar(content: Row(children: [
        Icon(Icons.warning_amber,color: Colors.white,),
        Padding(padding: EdgeInsets.only(left: 10),child: Text("Boş bırakılamaz !",style: TextStyle(fontWeight: FontWeight.bold),),)
      ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }


  }


  void sifreYenileme() async{
    if(t1.text!=""){
      await FirebaseAuth.instance.sendPasswordResetEmail(email: t1.text);
      var _snackBar=new SnackBar(content: Row(children: [
        Icon(Icons.check,color: Colors.white,),
        Padding(padding: EdgeInsets.only(left: 10),child: Text("Şifre yenileme emailinize gönderildi !\nSpam kutunuzu kontrol ediniz.",style: TextStyle(fontWeight: FontWeight.bold),),)
      ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
    else{
      var _snackBar=new SnackBar(content: Row(children: [
        Icon(Icons.warning_amber,color: Colors.white,),
        Padding(padding: EdgeInsets.only(left: 10),child: Text("Şifre yenileme için email giriniz !",style: TextStyle(fontWeight: FontWeight.bold),),)
      ],),backgroundColor: Color.fromRGBO(237, 125, 105, 1.0),);
      ScaffoldMessenger.of(context).showSnackBar(_snackBar);
    }
  }

  void googleGiris(){
    final provider=Provider.of<GoogleSignInProvider>(context,listen: false);
    provider.googleLogin(context);
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        actions: [
          Center(child: CircularProgressIndicator(),),
        ],backgroundColor: Colors.transparent,
      );
    });
  }


  @override
  void initState(){
    _auth=FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:Container(
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
                  height: MediaQuery.of(context).size.height/1.8,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 35,right: 35,top: 35,bottom: 5),child: Align(child: Text(
                        "Giriş Yap",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                      ),alignment: Alignment.topLeft,)),
                      Padding(padding: EdgeInsets.only(left: 35,right: 35),child: Align(child: Text(
                        "iFeel'i kullanmak için giriş yapın.",style: TextStyle(color: Colors.grey.shade800),
                      ),alignment: Alignment.topLeft,)),
                      Padding(padding: EdgeInsets.only(top: 25,bottom: 5,left: 35,right: 35),child: Align(alignment: Alignment.center,child: TextField(controller: t1,decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),labelText: "Email",prefixIcon: Icon(Icons.email,color: Color.fromRGBO(237, 125, 105, 1.0),)
                      ),),),),
                      Padding(padding: EdgeInsets.only(top: 5,bottom: 5,left: 35,right: 35),child: Align(alignment: Alignment.center,child: TextField(obscureText: _obScure,controller: t2,decoration: InputDecoration(
                          labelText: "Şifre",
                          prefixIcon: Icon(Icons.lock,color: Color.fromRGBO(237, 125, 105, 1.0),),
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15))
                      ),),),),
                      Padding(padding: EdgeInsets.only(left: 35,right: 35),child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                        InkWell(onTap: googleGiris,child: Align(alignment: Alignment.centerLeft,child: Text("Google ile giriş",style: TextStyle(color: Color.fromRGBO(213, 113, 95, 1.0),decoration: TextDecoration.underline),),),),
                        InkWell(onTap: sifreYenileme,child: Align(alignment: Alignment.centerRight,child: Text("Şifremi Unuttum",style: TextStyle(color:Color.fromRGBO(213, 113, 95, 1.0),decoration: TextDecoration.underline),),),),
                      ],),),
                      Padding(padding: EdgeInsets.only(bottom: 5,top: 10),child: Align(alignment: Alignment.center,child: SizedBox(width: 120,child: ElevatedButton(onPressed: girisYap, child: Text("Giriş Yap"),style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15,horizontal: 30)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(237, 125, 105, 1.0))
                      ),),)),),
                      Padding(padding: EdgeInsets.only(bottom: 30),child: Align(alignment: Alignment.center,child: SizedBox(width: 120,child: ElevatedButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>createAccount()));
                      }, child: Text("Kayıt Ol"),style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 30,vertical: 15)),shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),backgroundColor: MaterialStatePropertyAll(Color.fromRGBO(237, 125, 105, 1.0))
                      ),),),),),
                    ],
                  ),
                ),
              )
          )
      )
    );
  }
}