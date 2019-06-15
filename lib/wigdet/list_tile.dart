import 'package:flutter/material.dart';


class ListTileDefault extends StatelessWidget {
  Widget leading;
  Widget child;
  Widget trailing;
  double progressBarValue;
  bool isDefault;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.all(16.0).copyWith(bottom: 8.0, top: 24.0),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 0.3),
            ),
            child: ListTile(
              contentPadding:
                  EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
              leading: leading,
              title: child,
              trailing: trailing,
            ),
          ),
        ),
        isDefault ? 
          Positioned(
            right: 24,
            top: 8,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius:
                    BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 4.0, horizontal: 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Default",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        : Container(),
      ],
    );
  }
}