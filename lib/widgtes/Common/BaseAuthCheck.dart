import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/providers/AuthProvider.dart';
import 'package:provider/provider.dart';

class BaseAuthCheck extends StatelessWidget {
  final Widget child;
  final Widget redirect;
  const BaseAuthCheck({this.child, this.redirect, key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider provider = Provider.of<AuthProvider>(context);
    return Container(
      child: provider.isLoggedIn ? redirect : child,
    );
  }
}
