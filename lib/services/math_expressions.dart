import 'package:math_expressions/math_expressions.dart';

class MathExprApi {
  static String evaluateExpr(String expression) {
    late String result;
    try {
      Parser p = Parser();
      Expression exp = p.parse(expression);

      ContextModel cm = ContextModel();
      result = '${exp.evaluate(EvaluationType.REAL, cm)}';
    } catch (e) {
      result = "Error";
    }

    return result;
  }
}
