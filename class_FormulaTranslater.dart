class FormulaTranslater{
 
 // Класс "Вычислитель формул".
 // Ввод математическая формула-строку тип String, Список Параметров тип Map<String, double> - необязательно к вводу
 // Для получения результа getResult() - результат double может быть null тогда:
 // Для получения информации об ошибке getErrors() - String - Содержит код ошибки и описание. 
 // Ограничение : параметр - одна буква английского алфавита, соответсвенно их количесво ограниченно англ. алфавитом. 

 String strformula;
 Map<String, double>? mapParam;

 int _codeError = 0;
 String _formulaErrors = 'Нет ошибок';
 final List<String> _matSigns = ['0','1','2','3', '4', '5','6','7','8', '9','.','+','-','*', '/','(',')']; 
 
  //Конструктор класса
  FormulaTranslater({required this.strformula, this.mapParam});
 
  //Выдача результата -double или null
  double? getResult(){
    double tmp =_result(strformula: strformula, mapParam: mapParam);
    if (_codeError == 0){
      return tmp;
    }
    else{
      return null;
    } 
  }

  //Информация о ошибке String
  String getErrors(){
    return "[code-$_codeError]- $_formulaErrors";
  }

  // вспомогательная функция. Вычисляет результат математического выражения.
  // выражение не содержит скобок и параметров.
  // Ввод строка-формула -> результат вычисления - вещественное число  
  double _getSolution ({required String upformula}){  
      
      List<double> num = [];
      List<String> sings = []; 
      List<String> DIG = _matSigns.sublist(0,11);
      List<String> SIN = _matSigns.sublist(11,15);
      String tmp = '';

      upformula=_minusminus(str: upformula); // Замена -- на +
      
      // Создание списков чисел и там действий
      if (_codeError == 0){ 
        for (int i=0; i < upformula.length; i++){
          if (DIG.contains(upformula.split('')[i])){ 
            tmp += upformula.split('')[i];
          } 
          if (SIN.contains(upformula.split('')[i])){    
            if (tmp != '' && tmp !='-'){
              num.add(double.parse(tmp));
            }
            if (i == 0){
              tmp = "-";
            }
            if (i !=0 ){
              if (upformula.split('')[i] == '-' &&  SIN.contains(upformula.split('')[i-1])){
                tmp = '-';  

              }
              else if (upformula.split('')[i] == '-' &&  !SIN.contains(upformula.split('')[i-1])){
                tmp = '-';
                sings.add('+');  
              }
              else {
                sings.add(upformula.split('')[i]);
                tmp = '';
              }
            } 
          }
        }   
        if (tmp != '' && tmp != '-'){
          num.add(double.parse(tmp));
        } 

        // Вычичсление    
        if (num.length-sings.length == 1 ){
          int tmp = sings.length; 
          double res = 0;
          if (num.length == 1 && sings.isEmpty){
            res = num[0];
          }
          for (int k=1 ; k<=tmp; k++){
            int id = 0;
            for (int i=0; i<sings.length; i++){
              if (sings[i] == '*' || sings[i] == '/' ){
                id = i;
                break;
              }
              id = -1;
            }
            if (id != -1){
              if (sings[id]=='/'){
                if (num[id+1]==0){
                  _codeError = 6;
                  _formulaErrors = "Деление на 0";
                  return 0;
                }
                else{ 
                res = num[id]/num[id+1];
                }
              }
              if (sings[id]== '*') {
                res = num[id]*num[id+1];
              } 
            }
            else{
              id = 0;
              if (num.length == 1){
                res = num[id];
                break;
              }
              else{
                res = num[id]+num[id+1];
              }  
            }
            num.removeAt(id+1);
            num.removeAt(id);
            sings.removeAt(id);
            num.insert(id, res);
          }   
          return res;  
        } 
        else { 
          _codeError = 5;
          _formulaErrors = "Чтото не так со знаками";
          return 0;   
        } 
      }
      else {
        _codeError = 4;
        return 0;
      } 
    }
  
    // Вспомогательная функция. Добавление параметров в математическую формулу.
    // Ввод строка-формула и словарь параметров -> строка-формула только числа
    String _addParam ({required String formula, required Map<String, double> param } ){
      
    List<String> SINrh1 = _matSigns.sublist(11,16);
    List<String> SINrh2 = _matSigns.sublist(11,17);
    SINrh2.remove('(');

      for (int i=0; i < formula.length; i++){
        if (!_matSigns.contains(formula.split('')[i])) {
          String stTmp1 = formula.substring(0,i);
          String stTmp2 = formula.substring(i+1);
          if (stTmp1 != ''){
            if (!SINrh1.contains(stTmp1.split('').last)){
              stTmp1 = '$stTmp1*';
            }
          } 
          if (stTmp2 != ''){    
            if (!SINrh2.contains(stTmp2.split('').first)){
              stTmp2 = '*$stTmp2';
            }
          }
          formula = stTmp1+param[formula.split('')[i]].toString()+stTmp2;   
        } 
      }  
      return formula;
    }

    // Основная функция вычисления, она же вызывает все вспомогательные и
    // осуществляет начальную проверку.
    double _result ({required strformula, mapParam}){

      Set<String> noparam = {};
      int opScobki = 0;
      int clScobki = 0;
      List<String> SINup = _matSigns.sublist(11,16);
      List<String> SINcl = _matSigns.sublist(11,17);
      int j = 0;

      for (var i in strformula.split('') ) {   
        if (_matSigns.contains(i)){ 
          if (i == _matSigns[15]){
            opScobki += 1;
            if (j != 0){
              if (!SINup.contains(strformula.split('')[j-1])){ 
                strformula = strformula.substring(0, j)+'*'+strformula.substring(j);
                j += 1;
              } 
            }
          }
          if (i == _matSigns[16]){
            clScobki += 1;
            if (j != strformula.length-1){
              if (!SINcl.contains(strformula.split('')[j+1])){
                strformula = strformula.substring(0, j+1)+'*'+strformula.substring(j+1);
                j += 1;
              } 
            } 
          }
        }
        else {
          if (mapParam != null){
            if (!mapParam!.keys.contains(i)){
              noparam.add(i);  
            }
            if (noparam.isNotEmpty) {
              _codeError = 2;
              String s = noparam.join(', ');
              _formulaErrors = "Cписок параметров не полный, нет : $s";
            }  
          }
          else{
            _codeError = 1;
            _formulaErrors = "В формуле присутствуют параметры, однако список параментов не задан";
          }
        }  
      j += 1;  
      } 
      if (_codeError == 0){
        if (opScobki == clScobki){
          if (mapParam != null){
            strformula = _addParam(formula: strformula, param: mapParam!);
          }
          if (clScobki > 0){  
            bool redflag = false;
            int begin = 0;
            int end = 0; 
            for (int i=0; i < clScobki; i++){
              for (int j=0 ; j < strformula.length; j++) {
                if (strformula.split('')[j] == _matSigns[15]){
                  redflag = true;
                  begin = j; 
                } 
                if (redflag){
                  if (strformula.split('')[j] == _matSigns[16]){
                    redflag = false;
                    end = j;
                  } 
                }
              }       
              strformula = strformula.substring(0 , begin)+ _getSolution(upformula: strformula.substring(begin+1, end)).toString()+ strformula.substring(end+1);        
            }
            return _getSolution(upformula: strformula);
          }
          else {   
            return _getSolution(upformula: strformula);
          } 
        }     
        else{
          _codeError = 3;
          _formulaErrors = "В формуле чтото не так со скобоками";
        }           
      }
    return 01.0; 
    }

    // Рекурсивная функция проверки дублирования знака минус.
    // Проверяет строрку на -- и меняет их на +
    String _minusminus ({required String str}){
      int k = 0;
        k = str.indexOf('--');
        if (k == -1){ 
          return str;
        }
          if (k==0) {
            str = str.substring(k+2);
          }
          else{
            str = "${str.substring(0,k)}+${str.substring(k+2)}";
          }
        str = _minusminus(str: str);   
    return str;    
  }

}


