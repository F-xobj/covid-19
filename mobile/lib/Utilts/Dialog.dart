import 'package:covied_19/AppLocale/AppLocalization.dart';
import 'package:covied_19/Theme/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OwnDialog {
    //Show Alert Warning Dialog With Ok Button
    static Future<void> showAlertDialog(BuildContext context,String message) {
        return showDialog<void> (
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                    title:Column (
                        children: <Widget>[
                            Text(
                                AppLocalizations.of(context).translate('warnings'),
                                style: TextStyle(
                                    color: NIGATIVE_COLOR,
                                    fontSize: 18
                                ),
                            ),
                            new Container(
                                margin: EdgeInsets.only(top: 8,bottom: 8),
                                height: 0.5,
                                color: TITLE_DARK,
                            )
                        ],
                    ),
                    content: Text(
                                AppLocalizations.of(context).translate(message),
                                style: TextStyle(
                                    color: TITLE_DARK,
                                    fontSize: 18
                                ),
                            ),
                    actions: <Widget>[
                        FlatButton(
                            child: Text(
                                AppLocalizations.of(context).translate('ok'),
                                style: TextStyle(
                                    color: PRIMARY_COLOR,
                                    fontSize: 18
                                ),
                            ),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
    }

    //Show Dialog With Text , Image And Ok Button
    static Future<void> customDialog(BuildContext context, String message , Widget widget) {
        return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
                return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0))
                    ),
                    contentPadding: EdgeInsets.only(top: 10.0),
                    content: Container(
                        width: 300.0,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                widget,
                                Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Center(
                                        child:Text(
                                            AppLocalizations.of(context).translate(message),
                                            style: TextStyle(
                                                color: TITLE_DARK,
                                                fontSize: 18
                                            ),
                                        )
                                    )
                                ),
                                InkWell(
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                                        decoration: BoxDecoration(
                                            color: PRIMARY_COLOR,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(32.0),
                                                bottomRight: Radius.circular(32.0)),
                                        ),
                                        child: Text(
                                            AppLocalizations.of(context).translate('ok'),
                                            style: TextStyle(
                                                color: BACKGROUND,
                                                fontSize: 18
                                            ),
                                            textAlign: TextAlign.center,
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    ),
                );
        });
    }

    static Future<void> showWaitingDialog(BuildContext context) {
        return showDialog<void>(
            context: context,
            barrierDismissible: false,
            builder: (context) {
                return AlertDialog(
                content: Flex(
                    direction: Axis.horizontal,
                    children: <Widget>[
                    CircularProgressIndicator(
                        backgroundColor: BACKGROUND,
                        valueColor: new AlwaysStoppedAnimation<Color>(PRIMARY_COLOR)
                    ),
                    Padding(padding: EdgeInsets.only(left: 15),),
                    Flexible(
                        flex: 8,
                        child: Text(
                            AppLocalizations.of(context).translate('waiting'),
                            style: TextStyle(
                                color: PRIMARY_COLOR,
                                fontSize: 18
                            ),
                        )),
                    ],
                ),
                );
            });
        }
}