import 'dart:async';
import 'package:http/http.dart' as https;

class HttpModel{
    static Future<String> getData(String url) async {
        Completer<String> completer = new Completer();
        https.get(url).then((response) {
            if (response.statusCode == 200) {
                completer.complete(response.body);
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