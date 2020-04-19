import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'AppLocale/AppLocalization.dart';
import 'Screen/BaseScreen.dart';
import 'Theme/AppColor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            supportedLocales: [
                    Locale('en', 'US'),
                    Locale('ar', ''),
                ],
                localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                ],
            theme: ThemeData(
                primaryColor: PRIMARY_COLOR,
                primaryColorLight: LIGHT_PRIMARY_COLOR,
                primaryColorDark: DARK_PRIMARY_COLOR,
                accentColor: ACCECNT_COLOR,
                errorColor: NIGATIVE_COLOR,
                backgroundColor: BACKGROUND,
                buttonColor: SECONDARY_COLOR,
                focusColor: DARK_SECONDARY_COLOR,
            ),
            home: BaseScreen(),
        );
    }
}

