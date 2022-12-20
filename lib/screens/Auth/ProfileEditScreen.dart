import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rekord_app/config/AppValidation_rules.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/User.dart';
import 'package:flutter_rekord_app/providers/AuthProvider.dart';
import 'package:flutter_rekord_app/providers/UsersProvider.dart';
import 'package:flutter_rekord_app/widgtes/Common/ImageInput.dart';
import 'package:flutter_rekord_app/widgtes/common/BaseBlocButton.dart';

import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key key}) : super(key: key);

  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> with BaseMixins {
  final Map<String, dynamic> formData = {'name': 'Sara Doe'};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  User user;

  Widget _buildNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: $t(context, 'f_name')),
      validator: (value) => validateName(value),
      initialValue: user.firstName,
      onSaved: (String value) {
        formData['first_name'] = value;
      },
    );
  }

  Widget _buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: $t(context, 'l_name')),
      validator: (value) => validateName(value),
      initialValue: user.lastName,
      onSaved: (String value) {
        formData['last_name'] = value;
      },
    );
  }

  _submit(provider) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    try {
      var response = await provider.updateUser(formData);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return Flushbar(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
          icon: Icon(
            Icons.check_circle_outline,
            color: Colors.greenAccent,
          ),
          duration: Duration(seconds: 3),
          titleText: Text($t(context, 'profile_update')),
          flushbarPosition: FlushbarPosition.TOP,
          messageText: Text($t(context, 'profile_update_msg')),
        );
      }
    } catch (error) {}
  }

  void _setImage(File image) {
    formData['avatar'] = image;
  }

  _buildPageContent(BuildContext context, UsersProvider provider) {
    var scaffold = Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text($t(context, 'edit_profile')),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey, //Works with statefull widget
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ImageInput(onSelect: _setImage, imageUrl: user.avatar),
              SizedBox(height: 100),
              _buildNameField(),
              SizedBox(height: 20),
              _buildLastNameField(),
              SizedBox(height: 20),
              BaseBlockButton(
                isLoaded: provider.isLoaded,
                color: Theme.of(context).primaryColor,
                label: $t(context, 'save'),
                textColor: Colors.white,
                onPressed: () => _submit(provider),
              ),
              Container(
                margin: new EdgeInsets.only(left: 50.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    //  _buildPasswordField(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    return scaffold;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<AuthProvider>(context).user;
    UsersProvider userProvider = Provider.of<UsersProvider>(context);
    return _buildPageContent(context, userProvider);
  }
}
