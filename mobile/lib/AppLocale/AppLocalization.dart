import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'AppLocalizationDelegte.dart';

class AppLocalizations {
    final Locale locale;

    AppLocalizations(this.locale);

    /// Helper method to keep the code in the widgets concise
    /// Localizations are accessed using an InheritedWidget "of" syntax
    static AppLocalizations of(BuildContext context) {
        return Localizations.of<AppLocalizations>(context, AppLocalizations);
    }

    /// Static member to have a simple access to the delegate from the MaterialApp
    static const LocalizationsDelegate<AppLocalizations> delegate = AppLocalizationsDelegate();

    Map<String, String> _localizedStrings;
    Map<String, String> _localizedDefaultStrings;

    /// Load the language JSON file from the "lang" folder
    /// By Default Load English File
    Future<bool> load() async {
        String jsonString = await rootBundle.loadString('i18n/${locale.languageCode}.json');
        String jsonStringDefault = await rootBundle.loadString('i18n/en.json');

        Map<String, dynamic> jsonMap = json.decode(jsonString);
        Map<String, dynamic> jsonDefaultMap = json.decode(jsonStringDefault);

        _localizedStrings = jsonMap.map((key, value) {
            return MapEntry(key, value.toString());
        });

        _localizedDefaultStrings = jsonDefaultMap.map((key, value) {
            return MapEntry(key, value.toString());
        });

        return true;
    }

    /// This method will be called from every widget which needs a localized text
    String translate(String key) {
        if(_localizedStrings[key] == null) {
            if(_localizedDefaultStrings[key] == null){
                return key;
            }
            return _localizedDefaultStrings[key];
        }
        return _localizedStrings[key];
    }

    /// Return Language Code
    bool checkRTLDirection(){
        if(locale.languageCode == 'en') {
            return true;
        }
        return false;
    }
}