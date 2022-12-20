import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/config/AppRoutes.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/providers/BaseProvider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:path_provider/path_provider.dart';

const String trackLocalDownloadStorageSearch =
    'TrackLocalDownloadStorageSearch';
const String trackDownloadList = 'TrackDownloadList';

class DownloadProvider extends BaseProvider with BaseMixins {
  String finaltime = '';

  getCurrenttime() {
    var time = new DateTime.now().toString();

    var timeParse = DateTime.parse(time);

    var formattedtime =
        "${timeParse.hour}-${timeParse.minute}-${timeParse.second}";

    finaltime = formattedtime.toString();
  }

  List<Track> _downloadSongs = [];
  List<Track> get downloadSongs => _downloadSongs;

  var dio = Dio();
  bool isDownload = false;
  var downloadingProgress = '0';
  double isDone = 0.0;

  DownloadProvider() {
    getDownloads();
  }

  setDownloadSongs(List<Track> downloadSongs) {
    _downloadSongs = downloadSongs;
    notifyListeners();
  }

  downloadAudio(Track song, BuildContext context) async {
    if (song.type == 'upload') {
      if (!isDownloadSong(song)) {
        getCurrenttime();
        isDownload = true;
        Flushbar(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
          icon: Icon(
            Icons.download_outlined,
            color: Theme.of(context).primaryColor,
          ),
          duration: Duration(seconds: 5),
          flushbarPosition: FlushbarPosition.TOP,
          titleText: Text($t(context, 'download_msg')),
          messageText: Text($t(context, 'download_sub')),
        ).show(context);
        notifyListeners();

        final tempDir = await getExternalStorageDirectory();
        final downloadPath = tempDir.path + "/ ${song.id}$finaltime";
        print(downloadPath);

        await downloadFileTo(
            dio: dio,
            url: song.url,
            savePath: downloadPath,
            progressFunction: (received, total) {
              if (total != -1) {
                downloadingProgress =
                    (received / total * 100).toStringAsFixed(0);
                isDone = received / total * 100;

                notifyListeners();
              }
            });
        if (isDone == 100.0) {
          Flushbar(
            onTap: (s) {
              Navigator.pushNamed(context, AppRoutes.downloadScreenRoute);
            },
            backgroundColor:
                Theme.of(context).colorScheme.surface.withOpacity(0.8),
            icon: Icon(
              Icons.download_done_outlined,
              color: Theme.of(context).primaryColor,
            ),
            duration: Duration(seconds: 13),
            flushbarPosition: FlushbarPosition.TOP,
            titleText: Text($t(context, 'complete')),
            messageText: Text($t(context, 'complete_msg')),
          ).show(context);
          song.localPath = downloadPath;
          addToDownloadSong(song);
          notifyListeners();
        }
      } else {
        Flushbar(
          backgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.8),
          icon: Icon(
            Icons.warning_amber_outlined,
            color: Theme.of(context).primaryColor,
          ),
          duration: Duration(seconds: 13),
          flushbarPosition: FlushbarPosition.TOP,
          titleText: Text($t(context, 'ops')),
          messageText: Text($t(context, 'already_download')),
        ).show(context);
      }
    } else {
      Flushbar(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
        icon: Icon(
          Icons.error_outline,
          color: Theme.of(context).primaryColor,
        ),
        duration: Duration(seconds: 13),
        flushbarPosition: FlushbarPosition.TOP,
        titleText: Text($t(context, 'ops')),
        messageText: Text($t(context, 'flushBar_error_msg')),
      ).show(context);
    }
  }

  Future downloadFileTo(
      {Dio dio,
      String url,
      String savePath,
      Function(int received, int total) progressFunction}) async {
    try {
      final Response response = await dio.get(
        url,
        onReceiveProgress: progressFunction,

        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      );
      print(response.headers);
      final File file = File(savePath);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
    } catch (e) {
      print(e);
    }
  }

  addToDownloadSong(Track song) {
    _downloadSongs.add(song);

    saveSongData();
    notifyListeners();
  }

  saveSongData() async {
    LocalStorage localStorage = LocalStorage(trackLocalDownloadStorageSearch);
    await localStorage.ready;
    localStorage.setItem(trackDownloadList, _downloadSongs);
  }

  getDownloads() async {
    isLoaded = false;
    notifyListeners();
    LocalStorage localStorage = LocalStorage(trackLocalDownloadStorageSearch);
    await localStorage.ready;
    List<Track> downloadList =
        (localStorage.getItem(trackDownloadList) ?? []).map<Track>((item) {
      return new Track.fromJson(item);
    }).toList();

    _downloadSongs = downloadList;

    isLoaded = true;
    notifyListeners();
  }

  isDownloadSong(song) {
    return _downloadSongs.contains(song);
  }

  removeSong(Track song) {
    if (_downloadSongs.contains(song)) {
      Directory dir = Directory(song.localPath);
      dir.deleteSync(recursive: true);
      _downloadSongs.remove(song);
      saveSongData();
      notifyListeners();
    }
  }
}
