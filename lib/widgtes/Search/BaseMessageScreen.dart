import 'package:flutter/material.dart';

class BaseMessageScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget child;
  BaseMessageScreen({this.title, this.subtitle, this.icon, this.child});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (icon != null)
                Icon(
                  icon,
                  size: 60.0,
                  color: Theme.of(context).primaryColor,
                ),
              SizedBox(height: 20.0),
              if (title != null)
                Text('$title',
                    style: TextStyle(
                      fontSize: 14.0,
                    )),
              SizedBox(height: 10.0),
              if (subtitle != null)
                Text(
                  '$subtitle',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
                ),
              SizedBox(
                height: 20.0,
              ),
              if (child != null) child,
            ],
          ),
        ),
      ),
    );
  }
}
