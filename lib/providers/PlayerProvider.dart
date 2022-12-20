import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rekord_app/mixins/BaseMixins.dart';
import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Track.dart';

class PlayerProvider extends ChangeNotifier with BaseMixins {
  final AssetsAudioPlayer player = AssetsAudioPlayer();

  PlayerProvider() {
    player.playlistAudioFinished.listen((Playing playing) {
      next(action: false);
    });

    AssetsAudioPlayer.addNotificationOpenAction((notification) {
      //custom action
      return false; //true : handled, does not notify others listeners
      //false : enable others listeners to handle it
    });
  }

  Album _currentAlbum;
  Album get currentAlbum => _currentAlbum;

  Album _playlist;
  Album get playlist => _playlist;

  Track _currentTrack;
  Track get currentTrack => _currentTrack;

  bool _loopMode = false;
  bool get loopMode => _loopMode;
  bool _loopPlaylist = false;
  bool get loopPlaylist => _loopPlaylist;
  bool _isTrackLoaded = true;
  bool get isTrackLoaded => _isTrackLoaded;
  int _currentIndex;
  int get currentIndex => _currentIndex;
  set currentAlbum(album) {
    _currentAlbum = album;
    notifyListeners();
  }

  int _sessionId;
  int get sessionId => _sessionId;

  int tIndex;

  setBuffering(index) {
    tIndex = index;
  }

  playOrPause() async {
    try {
      await player.playOrPause();
    } catch (t) {}
  }

  isFirstTrack() {
    return _currentIndex == 0;
  }

  isLastTrack(next) {
    return next == _currentAlbum.tracks.length;
  }

  /// Next Track:
  /// Action will be false if used with playlistAudioFinished listener
  /// A track can be next by action or on playlistAudioFinished
  next({action: true}) {
    int next = _currentIndex + 1;
    if (!action && _loopMode && isLastTrack(next) && _loopPlaylist) {
      setPlaying(_currentAlbum, 0);
      play(0);
    } else if (!action && _loopMode && !_loopPlaylist) {
      setPlaying(_currentAlbum, _currentIndex);
      play(_currentIndex);
    } else {
      play(next);
    }
  }

  prev() {
    int pre = _currentIndex - 1;
    if (pre <= _currentAlbum.tracks.length) {
      play(pre);
    }
  }

  /// Tracks Loop:
  /// Loop a single track or complete playlist
  ///
  int c = 0;
  handleLoop() {
    c++;
    if (c == 1) {
      _loopMode = true;
      _loopPlaylist = true;
    } else if (c == 2) {
      _loopMode = true;
      _loopPlaylist = false;
    } else if (c > 2) {
      _loopMode = _loopPlaylist = false;
      c = 0;
    }
  }

  /// Playlist Shuffing:
  /// Make a copy of original before shuffle
  ///
  Album _beforeShuffling;
  bool _shuffled = false;
  bool get shuffled => _shuffled;
  handleShuffle() {
    _shuffled = !_shuffled;
    List<Track> tracks = _currentAlbum.tracks;
    _beforeShuffling = _currentAlbum;
    var shuffledTracks = shuffle(tracks);
    if (_shuffled) {
      Album album = new Album(
        _currentAlbum.id,
        _currentAlbum.title,
        _currentAlbum.content,
        _currentAlbum.media,
        shuffledTracks,
      );
      _currentAlbum = album;
    } else {
      _currentAlbum = _beforeShuffling;
    }
  }

  /// Play Track
  /// Play track and set current track index
  ///
  play(index) async {
    // player.stop();
    try {
      _currentTrack = _currentAlbum.tracks[index];
      notifyListeners();
      await _open(_currentAlbum.tracks[index]);
      _currentIndex = index;
    } catch (t) {
      //mp3 unreachable
    }
  }

  isSameAlbum() {
    return _playlist.id == _currentAlbum.id;
  }

  isTrackInProgress(Track track) {
    return player.isPlaying.value &&
        player.current.value != null &&
        player.current.value.audio.assetAudioPath == track.url;
  }

  isLocalTrackInProgress(filePath) {
    return player.isPlaying.value &&
        player.current.value != null &&
        player.current.value.audio.assetAudioPath == filePath;
  }

  bool isPlaying() {
    return player.isPlaying.value;
  }

  void audioSessionListener() {
    player.audioSessionId.listen((sessionId) {
      _sessionId = sessionId;
    });
  }

  _open(track) async {
    var metas = Metas(
      title: track.title,
      artist: track.artist.length > 0 ? track.artist[0].name : null,
      image: track.media != null
          ? MetasImage.network(track.media.thumbnail)
          : null, //can be MetasImage.network
    );

    await player.open(
      Audio.network(track.url, metas: metas),
      showNotification: true,
      notificationSettings: NotificationSettings(
        prevEnabled: isFirstTrack(),
        // nextEnabled: !isLastTrack(_currentIndex + 1),
        customPrevAction: (player) => prev(),
        customNextAction: (player) => next(),
        customPlayPauseAction: (player) => playOrPause(),
        customStopAction: (player) => player.stop(),
      ),
    );
  }

  handlePlayButton({album, Track track, index}) async {
    //Disable shuffling
    _shuffled = false;

    setBuffering(index);

    try {
      if (isTrackInProgress(track) || isLocalTrackInProgress(track.localPath)) {
        player.pause();
      } else {
        _isTrackLoaded = false;
        notifyListeners();
        track.localPath != null
            ? await player.open(Audio.file(track.localPath))
            : await _open(track);
        _isTrackLoaded = true;
        notifyListeners();
        setPlaying(album, index);
      }
    } catch (t) {
      //mp3 unreachable
    }
  }

  setPlaying(Album album, int index) {
    _currentAlbum = album;
    _currentIndex = index;
    _currentTrack = _currentAlbum.tracks[index];
  }

  String getTrackThumbnail() {
    String image = '';
    if (_currentTrack.media != null && _currentTrack.media.thumbnail != null) {
      image = _currentTrack.media.thumbnail;
    } else if (_currentAlbum.media != null &&
        _currentAlbum.media.thumbnail != null) {
      image = _currentAlbum.media.thumbnail;
    }
    return image;
  }

  String getTrackCover() {
    String image = '';
    if (_currentTrack.media != null && _currentTrack.media.cover != null) {
      image = _currentTrack.media.cover;
    } else if (_currentAlbum.media != null &&
        _currentAlbum.media.cover != null) {
      image = _currentAlbum.media.cover;
    } else {
      image = getTrackThumbnail();
    }
    return image;
  }
}
