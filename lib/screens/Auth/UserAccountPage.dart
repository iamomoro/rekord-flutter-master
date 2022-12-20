import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/providers/AuthProvider.dart';
import 'package:flutter_rekord_app/providers/ThemeProvider.dart';
import 'package:flutter_rekord_app/widgtes/Common/BaseImage.dart';
import 'package:flutter_rekord_app/widgtes/Common/CustomCircularProgressIndicator.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:provider/provider.dart';

class UserAccountPage extends StatelessWidget with BaseMixins {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    GlobalConfiguration cfg = new GlobalConfiguration();

    var themeProvider = Provider.of<ThemeProvider>(context);
    return new Scaffold(
      appBar: new AppBar(
        title: Text($t(context, 'account')),
        elevation: 0.0,
      ),
      body: provider.isLoaded
          ? SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: provider.isLoggedIn
                        ? ListTile(
                            leading: Container(
                              height: 40,
                              width: 40,
                              child: BaseImage(
                                radius: 5,
                                height: 40,
                                width: 40,
                                imageUrl: provider.user.avatar,
                              ),
                            ),
                            title: Text(provider.user.firstName),
                            subtitle: Text(provider.user.email),
                            trailing: Icon(Icons.edit),
                            onTap: () => Navigator.of(context).pushNamed(
                              AppRoutes.profileEditRoute,
                              arguments: '1', //user.id
                            ),
                          )
                        : Column(
                            children: <Widget>[
                              ListTile(
                                title: Text($t(context, 'sign_in')),
                                leading: Icon(
                                  Icons.verified_user,
                                  size: 22,
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.loginRoute),
                              ),
                              Divider(height: 0),
                              ListTile(
                                title: Text($t(
                                  context,
                                  'create_new_Account',
                                )),
                                leading: Icon(
                                  Icons.account_circle,
                                  size: 22,
                                ),
                                onTap: () => Navigator.pushNamed(
                                    context, AppRoutes.registerRoute),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 10),
                  if (provider.isLoggedIn)
                    Card(
                      elevation: 2,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text($t(
                              context,
                              'your_payments',
                            )),
                            leading: Icon(
                              Icons.monetization_on,
                              size: 22,
                            ),
                            onTap: () => {},
                          ),
                          Divider(height: 0),
                          ListTile(
                            title: Text($t(
                              context,
                              'save_payments',
                            )),
                            leading: Icon(
                              Icons.credit_card,
                              size: 22,
                            ),
                            onTap: () => {},
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      children: <Widget>[
                        cfg.getValue("allowDownload")
                            ? ListTile(
                                title: Text($t(context, 'download')),
                                leading: Icon(
                                  Icons.download_sharp,
                                  size: 22,
                                ),
                                onTap: () => {
                                  Navigator.pushNamed(
                                      context, AppRoutes.downloadScreenRoute)
                                },
                              )
                            : Divider(
                                height: 0,
                              ),
                        ListTile(
                          title: Text($t(context, 'help')),
                          leading: Icon(
                            Icons.help,
                            size: 22,
                          ),
                          onTap: () => {},
                        ),
                        ListTile(
                          title: Text($t(context, 'rate')),
                          leading: Icon(
                            Icons.star,
                            size: 22,
                          ),
                          onTap: () => {},
                        ),
                        Divider(height: 0),
                        ListTile(
                          title: Text($t(
                            context,
                            'about',
                          )),
                          leading: Icon(
                            Icons.info,
                            size: 22,
                          ),
                          onTap: () => {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  if (provider.isLoggedIn)
                    Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              $t(
                                context,
                                'sign_out',
                              ),
                            ),
                            leading: Icon(
                              Icons.account_circle,
                              size: 22,
                            ),
                            onTap: () => provider.logout(),
                          ),
                        ],
                      ),
                    ),
                  Card(
                    margin: EdgeInsets.all(0),
                    child: ListTile(
                      title: Text($t(
                        context,
                        'mode_String',
                      )),
                      trailing: Switch(
                          value: themeProvider.darkMode,
                          onChanged: (val) {
                            themeProvider.toggleChangeTheme();
                          }),
                      leading: Icon(
                        Icons.star,
                        size: 22,
                      ),
                      onTap: () => {},
                    ),
                  ),
                ],
              ),
            )
          : CustomCircularProgressIndicator(),
    );
  }
}
