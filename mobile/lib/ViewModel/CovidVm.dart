import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:covied_19/Exception/InternetException.dart';
import 'package:covied_19/Model/HttpModel.dart';
import 'package:covied_19/class/Covid-19-statistic.dart';

class CovidVm {
    static String url = 'https://api.covid19api.com/summary';

    static Future<bool> checkNetworkConnection() async {
        Completer<bool> completer = new Completer();
        Connectivity().checkConnectivity().then((connectivityResult){
            if(connectivityResult == ConnectivityResult.none) {
                completer.complete(false);
            }
            else {
                completer.complete(true);
            }
        });
        return completer.future;
    }

    static Future<Covid> getCovidStatistics() async {
        Completer<Covid> completer = new Completer();

        checkNetworkConnection().then((flag) {
            if(flag) {
                HttpModel.getData(url).then((strData){
                    Map map = jsonDecode(strData);
                    Covid covid = Covid.fromJson(map);
                    completer.complete(covid);
                }).catchError((error){
                    completer.completeError(error);
                });
            }
            else {
                completer?.completeError(InternetException(''));
            }
        });

        return completer.future;
    }
}