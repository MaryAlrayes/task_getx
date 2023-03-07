import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task/core/errors/exceptions.dart';

class DecodeResponse {

  static dynamic decode(http.Response response) {
    print('status code ${response.statusCode}');

    if (response.statusCode >= 200 && response.statusCode <= 299) {

      return json.decode(( response.body)) as dynamic;
    } else {

      final errorData = jsonDecode(response.body);
      String errorMessage = errorData['data']['error'];
      throw CustomException(message: errorMessage);
    }
  }
}
