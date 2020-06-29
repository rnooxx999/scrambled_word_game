import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrambled_word_game/arabic_alphabet.dart';
import 'package:scrambled_word_game/english_alphabet.dart';


class MainPage extends StatefulWidget {
MainPage({Key key ,this.title}):super (key:key);
final String title;


  @override
  _MainPageState createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> {



final boxShadow = BoxDecoration(
 color: Colors.grey[300],
 boxShadow: [
 BoxShadow(
color: Colors.grey[500],
offset: Offset(4.0, 4.0),
 blurRadius: 15.0,
 spreadRadius: 1.0),
BoxShadow(
color: Colors.white,
 offset: Offset(-4.0, -4.0),
 blurRadius: 15.0,
  spreadRadius: 1.0),]);



  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
    appBar: AppBar(
    elevation: 0.1,
    backgroundColor: Colors.grey,
    title: Text('Main Page'),),
    body: Center(
      child: Container(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(child:Container(
          padding: EdgeInsets.all(30),
           width: 300 ,
            height: 100,
            decoration: boxShadow,
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Text("English Alphabet" , style:TextStyle(fontSize: 19, color: Colors.black),),],),),
                onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return EnglishAlphabet();}));
          } ,),
          GestureDetector(child:Container(
             width: 300 ,
            height: 100,
            decoration: boxShadow,
            child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
              Text("الحروف العربية", style:TextStyle(fontSize: 19, color: Colors.black),),],),),
                onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ArabicAlphabet();}));
          } ,),
          ],
      ),
      ),
    ),
    );
  }
}
