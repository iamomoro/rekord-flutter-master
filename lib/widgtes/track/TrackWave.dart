// import 'package:flutter/material.dart';
// import 'package:flutter_rekord_app/providers/PlayerProvider.dart';
//
// import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
//
// class TrackWave extends StatelessWidget {
//   final int sessionId;
//
//   TrackWave(this.sessionId);
//
//   canAccessMicrophone() async {
//     return await Permission.microphone.request().isGranted;
//     // Use location.
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var playerProvider = Provider.of<PlayerProvider>(context, listen: false);
//
//     return playerProvider.player.isPlaying.value
//         ? FutureBuilder(
//             future:
//                 canAccessMicrophone(), // a previously-obtained Future<String> or null
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               print(snapshot.data);
//               return snapshot.hasData && sessionId != null
//                   ? Visualizer(
//                       builder: (BuildContext context, List<int> wave) {
//                         return wave.length > 0
//                             ? new CustomPaint(
//                                 painter: new BarVisualizer(
//                                   waveData: wave,
//                                   height: MediaQuery.of(context).size.height,
//                                   width: MediaQuery.of(context).size.width,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                                 child: new Container(),
//                               )
//                             : Container();
//                       },
//                       id: sessionId,
//                     )
//                   : Container();
//             })
//         : Container();
//   }
// }
