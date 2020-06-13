import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: CalPage(),
      // theme: ThemeData(primaryColor: Colors),
    );
  }
}

class CalPage extends StatefulWidget {
  @override
  _CalPageState createState() => _CalPageState();
}

class _CalPageState extends State<CalPage> {
  String equation = "0";
  String result = "0";
  String expression = "";
  
  Widget button(String buttonText) {
    return Expanded(
      child: MaterialButton(
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 25, color: Colors.black),
        ),
        color: Colors.white,
        elevation: 0.0,
        height: 90,
        highlightElevation: 0.0,
        onPressed:()=> buttonPressed(buttonText),
      ),
    );
  }

  buttonPressed(String text) {
    setState(() {
     
      if(text == "C"){
        equation = "0";
        result = "0";
      }
      else if(text == "⌫"){
        
        equation = equation.substring(0,equation.length - 1);
        if(equation.length==0){
          setState(() {
            equation="0";
          });
        }
      }
      else if(text=="+/-"){
        if(result=="0"){

        }else {
           double c = double.parse(result);
         c = -c;
          result = c.toString();
        }
      
      }
      else if(text == "="){
        if(equation=="0"){

        }else{
           expression = equation;
        expression = expression.replaceAll("×", "*");
        expression = expression.replaceAll("÷", "/");
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
          
        }catch(e){
          print(e);
          result = "Error";
        }
        }
       
      }else if(text =="00"){
        if(equation=="0"){}
        else{
          equation = equation + text;
        }
      }
      else {
        if(equation=="0"){
          if(text == "÷"|| text=="×"||text=="+"){

          }else if(text=="-"){
            equation = "0-";
          }
          else{equation = text;}
          
        } else {
          equation = equation + text;
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Divider(color: Colors.white,),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Text(equation,style:TextStyle(fontSize:30)),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            ),
            Expanded(child: Divider(color: Colors.white,)),
            Container(
              alignment: Alignment.centerRight,
              child: Text(result,style:TextStyle(fontSize:35,fontWeight: FontWeight.bold)),
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            ),
            Expanded(child: Divider(color: Colors.white,)),
            Row(
              children: [
                button("C"),
                button("+/-"),
                button("⌫"),
                button("÷"),
              ],
            ),
            Row(
              children: [
                button("7"),
                button("8"),
                button("9"),
                button("×"),
              ],
            ),
            Row(
              children: [
                button("4"),
                button("5"),
                button("6"),
                button("-"),
              ],
            ),
            Row(
              children: [
                button("1"),
                button("2"),
                button("3"),
                button("+"),
              ],
            ),
            Row(
              children: [button("0"), button("00"), button("."), button("=")],
            )
          ],
        ),
      ),
    );
  }
}
