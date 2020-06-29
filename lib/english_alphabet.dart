import 'dart:collection';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EnglishAlphabet extends StatefulWidget {
  @override
  _EnglishAlphabetState createState() => _EnglishAlphabetState();
}

List <String> listWordToBeGuessed = ["public", "palm" , "local" , "folk" , "community" , "capture","range", "swing" , "zebra" , "japan"];


// the primary chosen word
String word = "";

//the pressed letter on the screen
String letterPressed = "";
String value = "";

//Guess tries
int tries = 3;

// height of the animation button (again button)
double height = 400 ;

bool reveal = false;
bool win = false;

 final random = Random();



class _EnglishAlphabetState extends State<EnglishAlphabet> with TickerProviderStateMixin {
// letters button Controller
  AnimationController animationController;
  Animation animation;

  //(again button)Controller
AnimationController slideAnimationController;
Animation<double>slideAnimation;


  @override
  void initState() {
    super.initState();
    wordScreen();
    animationController = AnimationController(vsync:this,duration: Duration(milliseconds: 90));
    animation =  Tween(begin: 2.0,end: 0.0).animate(animationController)
    ..addListener((){
      setState(() {
      });
    })..addStatusListener((status){
      if(status == AnimationStatus.completed){
        animationController.reverse();
        }else if(status == AnimationStatus.dismissed){
        animationController.reset();
        }
      });
        slideAnimationController = AnimationController(
  duration: Duration(seconds: 2, ),vsync: this);
  slideAnimation = Tween<double>(
  begin: 490.0 , end: 30.0).animate(CurvedAnimation(parent: slideAnimationController,
  curve: Curves.fastLinearToSlowEaseIn))
  ..addListener((){
  setState(() {});});

  }


// function to chose the primary word
void wordScreen(){
 var value = List<String>.generate(1, (i)=>listWordToBeGuessed[random.nextInt(listWordToBeGuessed.length)]);
 for(int i=0 ; i < value.length ; i++){
      word = value[i] ;
     print(word);
 }
}



//function that return String list in the buttons
List lettersList(int o){
if(word == "public" || word ==  "palm"  ){
List <String> theLetter1 = [ "u" , "m", "h", "o" ,"⌫" , "b","f", "l" , "p" , "s","t", "i", "r","c" ,"a"];
value = theLetter1[o];
return theLetter1;
}
else if(word ==  "local" || word == "folk" ){
List <String> theLetter2 = ["b","f", "l" , "g" ,  "⌫" ,"c","n"  , "t" , "a" , "s", "e" , "k","i","o", "r"];
value = theLetter2[o];
return theLetter2;

}
else if(word == "community" || word == "capture" ){
List <String> theLetter3 = ["t", "g", "r","c" ,"⌫",  "u", "y" , "m","t", "n" , "p" , "a","o","e","i"];
value = theLetter3[o];
return theLetter3;}
else if(word == "range" ||word == "swing"  ){
List <String> theLetter4 = ["l" , "r" , "s","t","⌫", "i" , "w","e" , "f","d", "g" , "m" ,"y","n","a"];
value = theLetter4[o];
return theLetter4;
}
else if(word == "zebra" ||word == "japan"  ){
List <String> theLetter5 = ["b","f", "l" , "p" ,"⌫", "a" , "z" , "c","m", "e" , "d" , "s","j","k","n"];
value = theLetter5[o];
return theLetter5;}
}


//the Right guess
void winning(){
  if( word.compareTo(letterPressed)==0 ){
  slideAnimationController.forward();
    win = true;
    reveal =true;
   print("you win");}
}

//decrement the tries
void triedCounter(){
  if(letterPressed.length >= word.length && win != true  ){
  setState(() {
      tries -- ;
      letterPressed = "";
      print("o $tries");
      if(tries == 2){
      }
      else if(tries == 1){
      }
      // the wrong guess
      else if (tries == 0 ){
        letterPressed = "game over";
        reveal =true;
          slideAnimationController.forward();}
  });}
}

//to refresh the page and get new guess
void refresh(){
  wordScreen();
  setState(() {
  tries = 3;
  win = false;
  reveal = false;
  letterPressed = "";
});
slideAnimationController.reverse();
}

  @override
  void dispose() {
    slideAnimationController.dispose();
    animationController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
    elevation: 0.1,
    backgroundColor: Colors.grey,
    title: Text('English Alphabet'),),
      backgroundColor:  Colors.grey[300],
      body: Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
            Container(height: 30,
            padding: EdgeInsets.only( top :10.0 , left: 40 ),
            child: Row(children: <Widget>[
                    tries >= 3 ?  Image.asset("assets/heart.png" ) : Icon(Icons.clear )  ,
                     SizedBox(width: 13,),
                     tries >= 2 ? Image.asset("assets/heart.png" ) : Icon(Icons.clear )  ,
                     SizedBox(width: 13,),
                     tries >= 1 ? Image.asset("assets/heart.png" ) : Icon(Icons.clear )  ,
                             ],),),
            Padding(
              padding: const EdgeInsets.only( top :30.0 , bottom:  40),
              child: Text(reveal == false ? word.replaceAllMapped(RegExp(r'[rabfihbplainmrswcyz]'),
               (match){return ' _ ';}) : word, style: TextStyle(fontSize: 30), ),
            ),
            Container(
            child: Center(
            child: Text( win == false ?letterPressed : "You win" ,style: TextStyle(fontSize: 30) )),
            margin: const EdgeInsets.only( right :70.0 , left:  70),
            decoration: BoxDecoration(
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
                            spreadRadius: 1.0),]),
                            height: 90, width: 160,),
              Padding(
              padding: EdgeInsets.only(top:40),
                child: Container(height: 219,color: Colors.transparent,
                  child: GridView.count(crossAxisCount: 5,
    mainAxisSpacing: 9.0,crossAxisSpacing: 9.0,
    children: List.generate(15 , (index){
    List too = lettersList(index).map((m)=> m).toList();

    bool maybe(){
    if(index ==  too[index]){
      animationController.forward();
    return true;
    }}
    return lettCard(value , too[index] ,too[index] );
    }
    )),
                )),
            ],
          ),
        ),
        Positioned(
      top:height - slideAnimation.value *4.17  ,
        left: 30,
        right: 30,
        height: height - 178.0 ,
        child: Container(color: Colors.white.withOpacity(0.6),

      padding: EdgeInsets.only(top: 18, left: 16, right: 16,bottom: 16 ),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(iconSize: 100,icon: Icon(Icons.refresh),color: Colors.black,
              onPressed: (){refresh();},),
              Text("again", style:TextStyle(fontSize: 30, color: Colors.black),),

            ],
          ),
      )),
     ], ));

}

Widget imagee( ){
return Container(
child: Image.asset("assets/heart.png"),);
}

Widget lettCard(text ,String child , index){

int i ;

return GestureDetector(
  onTap: (){

  if (i != index){
  animationController.forward();
  }

//add the letters every time you press
  setState(() {
    letterPressed += text ;
    print(letterPressed);
  });
  winning();
     triedCounter();
  },
    child:Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container( height: 50, width: 50,
      decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                  color: i == index ?Colors.grey[500]: Colors.grey[700],
                                  offset:i == index ? Offset(4.0, 4.0):Offset(animation.value, animation.value)   ,
                                  blurRadius: i == index ? 15.0 : animation.value,
                                  spreadRadius: i == index ? 1.0: animation.value),
                              BoxShadow(
                                  color: Colors.white,
                                  offset: Offset(-4.0, -4.0),
                                  blurRadius: 15.0,
                                  spreadRadius: 1.0),]),
                                  child: Center(
                                    child: Text(child ,
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold ),),
                                  ),
 ),
    ),
  );
}
}
