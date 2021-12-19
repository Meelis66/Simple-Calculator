import 'package:km_to_miles/services/math_expressions.dart';

class CalcController{
  String equation = "0";
  String result = "0";
  String expression = "";

calculate(String input) {
  
  if (input == "C") {
    equation = "0";
    result = "0";
  } else if (input == "←") {
    equation = equation.substring(0, equation.length - 1);
    if (equation == "") {
      equation = "0";
    }
  } else if (input == "=") {
    expression = equation;
    //expression = equation.replaceAll('×', '*'); //Ei toimi millegipärast
    expression = equation.replaceAll('÷', '/');

    result = MathExprApi.evaluateExpr(expression);
  } else {
    if (equation == "0") {
      equation = input;
    } else {
      equation = equation + input;
    }
  }
}
}
