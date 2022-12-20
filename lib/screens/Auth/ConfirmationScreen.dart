import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/widgtes/Search/BaseMessageScreen.dart';

class ConfirmationScreen extends StatelessWidget with BaseMixins {
  const ConfirmationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: BaseMessageScreen(
            title: $t(context, 'register_title'),
            subtitle: $t(
              context,
              'register_title',
            ),
            icon: Icons.check_box,
            child: FlatButton.icon(
                icon: Icon(
                  EvilIcons.arrow_right,
                  color: Theme.of(context).primaryColor,
                ),
                label: Text(
                  $t(context, 'sign_in'),
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).primaryColor),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.loginRoute);
                })),
      ),
    );
  }
}
