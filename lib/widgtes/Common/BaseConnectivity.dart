import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rekord_app/widgtes/Search/BaseMessageScreen.dart';

// Widget Name: Base Connectivity
// @version: 1.0.0
// @since: 1.0.0
// Description: A base widget to checked internet connectivity

class BaseConnectivity extends StatelessWidget {
  final Widget child;
  const BaseConnectivity({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget builderChild,
      ) {
        final bool connected = connectivity != ConnectivityResult.none;
        return connected
            ? child
            : BaseMessageScreen(
                icon: Icons.perm_scan_wifi,
                title: 'No Internet',
              );
      },
      child: Container(),
    );
  }
}
