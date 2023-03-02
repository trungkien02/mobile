import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.white,
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.bottomRight,
                child: Text(
                  text,
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal),
                ),
              ),
            ),
            Row(
              //set margin for all the buttons
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                customOutlineButton("7"),
                customOutlineButton("8"),
                customOutlineButton("9"),
                customOutlineButton("/"),
              ],
            ),
            Row(
              children: <Widget>[
                customOutlineButton("4"),
                customOutlineButton("5"),
                customOutlineButton("6"),
                customOutlineButton("x"),
              ],
            ),
            Row(
              children: <Widget>[
                customOutlineButton("1"),
                customOutlineButton("2"),
                customOutlineButton("3"),
                customOutlineButton("-"),
              ],
            ),
            Row(
              children: <Widget>[
                customOutlineButton("0"),
                customOutlineButton("."),
                customOutlineButton("="),
                customOutlineButton("+"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget customOutlineButton(String val) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => btnClicked(val),
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.all(20.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(250.0),
          ),
        ),
        child: Text(
          val,
          style: TextStyle(fontSize: 35.0, color: Colors.teal),
        ),
      ),
    );
  }
  dynamic text = "0";
  dynamic num1 = 0;
  dynamic num2 = 0;

  dynamic result = "";
  dynamic finalResult = "";
  dynamic opp = "";
  dynamic preOpp = "";
  void btnClicked(String btnText) {
    if (btnText == 'C') {
      text = '0';
      num1 = 0;
      num2 = 0;
      result = '';
      finalResult = '';
      opp = '';
      preOpp = '';
    } else if (opp == '=' && btnText == '=') {
      if (preOpp == '+') {
        finalResult = add();
      }
      else if (preOpp == '-') {
        finalResult = sub();
      }
      else if (preOpp == 'x') {
        finalResult = mul();
      }
      else if (preOpp == '/') {
        finalResult = div();
      }
    } else
    if (btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' ||
        btnText == '=') {
      if (num1 == 0) {
        num1 = double.parse(result);
      } else {
        num2 = double.parse(result);
      }
      if (opp == '+') {
        finalResult = add();
      } else if (opp == '-') {
        finalResult = sub();
      } else if (opp == 'x') {
        finalResult = mul();
      } else if (opp == '/') {
        finalResult = div();
      }
      preOpp = opp;
      opp = btnText;
      result = '';

    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }
  String add() {
    result = (num1 + num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String sub() {
    result = (num1 - num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (num1 * num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (num1 / num2).toString();
    num1 = double.parse(result);
    return doesContainDecimal(result);
  }
  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}