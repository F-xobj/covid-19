import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:covied_19/Exception/InternetException.dart';
import 'package:covied_19/Model/HttpModel.dart';
import 'package:covied_19/class/BaseScreenCls/Covid-19-statisticCls.dart';
import 'package:covied_19/class/CountryStatisticDetails/CountryStatisticDetalsCls.dart';
import 'package:flutter/material.dart';

class CovidVm {

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
                HttpModel.getData('https://api.covid19api.com/summary').then((strData){
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

    static Future<CountryStatisticDetals> getCountryStatisticsByDateAndStatus({
        @required String country,
        @required String startDate,
        @required String endDate,
    }) async {
        Completer<CountryStatisticDetals> completer = new Completer();
        String url = "https://api.covid19api.com/country/$country?from=$startDate&to=$endDate";

        checkNetworkConnection().then((flag) {
            if(flag) {
                HttpModel.getData(url).then((strData){
                    List data = jsonDecode(strData);
                    CountryStatisticDetals countryStatisticDetals = CountryStatisticDetals.fromJson(data);
                    completer.complete(countryStatisticDetals);
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