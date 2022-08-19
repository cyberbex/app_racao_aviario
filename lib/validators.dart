import 'package:flutter/cupertino.dart';

class Validators {
  Validators._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String message) {
    return (value) {
      final valueCompare = valueEC?.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return message;
      }
      return null;
    };
  }

  static FormFieldValidator validaData(String message) {
    return (value) {
      String aux = value.toString();
      String strDia = value.split('/')[0];
      String strMes = value.split('/')[1];
      String strAno = value.split('/')[2];
      int dia = int.parse(strDia);
      int mes = int.parse(strMes);
      int ano = int.parse(strAno);

      if (aux.length != 10 ||
          aux.substring(2, 3) != '/' ||
          aux.substring(5, 6) != '/') {
        return message;
      }

      if (dia < 0 ||
          dia > 31 ||
          mes < 1 ||
          mes > 12 ||
          ano < 2022 ||
          ano > 2072) {
        return message;
      }

      return null;
    };
  }
}
