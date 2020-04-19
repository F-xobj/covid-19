import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as https;

class HttpModel{
    static Future<String> getData(String url) async {
        Completer<String> completer = new Completer();
        https.get(url).then((response) {
            if (response.statusCode == 200) {
                completer.complete(response.body);
            }
            else if(response.statusCode == 400) {
                throw Exception('Invalied');
            }
            else {
                throw Exception('Invalied');
            }
        }).catchError((err) {
            completer.completeError(err);
        });
        return completer.future;
    }
}