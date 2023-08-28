
String formula = '(x)(z774+(2xjd+377)y/15.56y)-4)/10.6u';
Map<String, double> param = {'x': 10.0, 'y':20, 'z':30};
String form = '-4/-34-43*-34.03';
List<String> matSigns = ['0','1','2','3', '4', '5','6','7','8', '9','.','+','-','*', '/','(',')']; 
List<String> SINrh = matSigns.sublist(11,16);
String formulaErrors = '';
int codeError = 0;


List masStroka({required String str}){
  List <String> masStr= [];
  List<String> DIG = matSigns.sublist(0,11);
  List<String> SIN = matSigns.sublist(11,17);
  String temp = '';
  bool dig = false;
  bool par = false;

  for (String i in str.split('')){
      if (SIN.contains(i)){
        if (temp.isNotEmpty){
          masStr.add(temp);  
          temp =''; dig = false; par = false;
        }
        masStr.add(i);
      }
      else if (DIG.contains(i)){
              if (temp.isNotEmpty && par) {
                masStr.add(temp);  
                temp =''; par = false;
        }
          temp += i; dig = true; 
        }
      else{
        if (temp.isNotEmpty && dig) {
          masStr.add(temp);  
          temp =''; dig = false;
        }
        par = true;
        temp += i;
      }
  }
  if (temp.isNotEmpty){masStr.add(temp);}
  return masStr ;
}


double GetSolution ({required String upformula}){
  print("GetSolution  vhod - $upformula");
      upformula=minusminus(str: upformula);
  //  print("GetSolution  minusmin - $upformula");
      List<double> num = [];
      List<String> sings = []; 
      List<String> DIG = matSigns.sublist(0,11);
      List<String> SIN = matSigns.sublist(11,15);
      String tmp = '';

      if (codeError == 0){ 
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
        
  print("Get-Solution - $tmp , $num, ${sings.length}"); 
  //      
        if (num.length-sings.length == 1 ){
          int tmp = sings.length; 
          double res = 0;
          if (num.length == 1 && sings.isEmpty){
            res = num[0];
          }
          for (int k=1 ; k<=tmp; k++){
  print("object!!!!!!!!!!!!!!!!!!!");
  print("$num, $sings, $res, $tmp"); 
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
                res = num[id]/num[id+1];
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
                if (sings[id]=='+'){
                  res = num[id]+num[id+1];
                }
                if (sings[id]== '-') {
                  res = num[id]-num[id+1];
                } 
                //res = num[id]+num[id+1];
              }  
            }
            num.removeAt(id+1);
            num.removeAt(id);
            sings.removeAt(id);
            num.insert(id, res);
   print("$num, $sings, $res");   

          } 
   print("Get-Solution - $res");    
          return res;  
        } 
        else { 
          codeError = 5;
          formulaErrors = "Чтото не так со знаками";
          return 0;   
        } 
      }
      else {
        codeError = 4;
        return 0;
      } 
    }




String minusminus ({required String str}){
  //print("vhod - $str");
    int k = 0;
      k = str.indexOf('--');
      if (k == -1){
        print("Krainaya $str");
        return str;
      }
        if (k==0) {
          str = str.substring(k+2);
        }
        else{
          str = str.substring(0,k)+"+"+str.substring(k+2);
        }
        str = minusminus(str: str);   
  return str;    
}

void main(List<String> arguments) {

print(masStroka(str: '-20-3*4-1*-1' ));
print(masStroka(str: formula));
 
//print("GetSolution - $codeError- ${GetSolution(upformula: '-20-3*4-1*-1')}");

//print('GetSolution -$codeError- ${GetSolution(upformula: '---241.0*-1')}');


// print(minusminus(str:  '--10'));
// List<String> DIG = matSigns.sublist(0,11);
// List<String> SIN = matSigns.sublist(11,15);
// print(SIN);
// print(DIG);
// print(matSigns[15]);
// print(matSigns[16]);
}  