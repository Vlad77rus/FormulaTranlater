
import 'class_FormulaTranslater.dart';


void main(List<String> arguments) {


  var ft = FormulaTranslater (strformula: '((4+(2x+3)/15.56y)-4)/-10.6', mapParam: {'x': 10.0, 'y':20, 'z':30});
  print("Пример- : ${ft.getResult()}");
  print('${ft.getErrors()}\n');

  var ft1 = FormulaTranslater (strformula: '-4/-4-4*-4.03');
  print("Пример-5: ${ft1.getResult()}");
  print('${ft1.getErrors()}\n');

  var ft2 = FormulaTranslater (strformula: '(-4)/(-4)-x*(-4.03)');
  print("Пример-2: ${ft2.getResult()}");
  print('${ft2.getErrors()}\n');

  var ft3 = FormulaTranslater (strformula: '(x/-3)-(-43)*-34.03', mapParam: {"x" : 10});
  print("Пример-3: ${ft3.getResult()}");
  print('${ft3.getErrors()}\n');

  var ft4 = FormulaTranslater (strformula: '-(20*(-3x)*4x-1)*-1x', mapParam: {"x" : -10});
  print("Пример-4: ${ft4.getResult()}");
  print('${ft4.getErrors()}\n');

  var ft5 = FormulaTranslater (strformula: '10*5+4/2-1', mapParam: {"x" : 10});
  print("!! Пример из д.з. !!: ${ft5.getResult()}");
  print('${ft5.getErrors()}\n');

  var ft6 = FormulaTranslater (strformula: '(x*3-5)/5', mapParam: {"x" : 10});
  print("!! Пример из д.з. !!: ${ft6.getResult()}");
  print('${ft6.getErrors()}\n');

  var ft7 = FormulaTranslater (strformula: '3*x+15/(3+2)', mapParam: {"x" : 10});
  print("!! Пример из д.з. !! : ${ft7.getResult()}");
  print('${ft7.getErrors()}\n');

  var ft8 = FormulaTranslater (strformula: '-4(20(-3x)y(-15*-12y))', mapParam: {"x" : -10, "y" : 4});
  print("Пример-8 : ${ft8.getResult()}");
  print('${ft8.getErrors()}\n');

  var ft9 = FormulaTranslater (strformula: '----241.0*-1', mapParam: {"x" : -10, "y" : 4}); //такие штуки считает калькулятор в Ubuntu -"Калькулятор с финансовым и научным режимами. версия 41.1"
  print("Пример-9 : ${ft9.getResult()}");
  print('${ft9.getErrors()} \n');
  
  var ft10 = FormulaTranslater (strformula: '(x)(z(4+(2x+3)y/15.56y)-4)/10.6', mapParam: {"x" : -10, "y" : 4 ,  'z':30});
  print("Пример-10 : ${ft10.getResult()}");
  print('${ft10.getErrors()}\n');

}
