import 'package:flutter/material.dart';

enum SnackbarCustomEnum { INFO, SUCCESS, ERROR }

class SnackbarCustomModel {
  String title;
  String message;
  SnackbarCustomEnum status;
  SnackbarCustomModel({
    required this.title,
    required this.message,
    this.status = SnackbarCustomEnum.INFO,
  });
}

class SnackbarCustom {
  static void show(BuildContext context,
      {required SnackbarCustomModel snackbarCustomModel}) {
    ScaffoldMessenger.of(context).showSnackBar(
      _snackbarCustomLayout(context, snackbarCustomModel: snackbarCustomModel),
    );
  }

  static SnackBar _snackbarCustomLayout(BuildContext context,
      {required SnackbarCustomModel snackbarCustomModel}) {
    var mediaQuery = MediaQuery.of(context);
    var textStyle = TextStyle(color: Colors.grey[400]);
    styleStatus(SnackbarCustomEnum snackbarCustomEnum) {
      switch (snackbarCustomEnum) {
        case SnackbarCustomEnum.SUCCESS:
          return {
            "icon": Icons.check,
            "color": Colors.green,
          };
        case SnackbarCustomEnum.INFO:
          return {
            "icon": Icons.info_outline,
            "color": Colors.lightBlue,
          };
        case SnackbarCustomEnum.ERROR:
          return {
            "icon": Icons.error_outline,
            "color": Colors.red,
          };
      }
    }
    return SnackBar(
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      elevation: 1,
      content: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(5),
          gradient: new LinearGradient(
            stops: [0.02, 0.02],
            colors: [
              styleStatus(snackbarCustomModel.status)["color"] as Color,
              Colors.white
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(
                  styleStatus(snackbarCustomModel.status)["icon"] as IconData,
                  color:
                      styleStatus(snackbarCustomModel.status)["color"] as Color,
                  size: 28,
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snackbarCustomModel.title,
                        style: textStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        snackbarCustomModel.message,
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: textStyle.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}