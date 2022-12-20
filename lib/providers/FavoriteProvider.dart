import 'package:flutter_rekord_app/models/Album.dart';
import 'package:flutter_rekord_app/models/Track.dart';
import 'package:flutter_rekord_app/providers/BaseProvider.dart';

import 'package:localstorage/localstorage.dart';

const String trackLocalStorageSearch = 'TrackLocalStorageSearch';
const String trackFavoriteList = 'TrackFavoriteList';
const String albumLocalStorageSearch = 'AlbumLocalStorageSearch';
const String albumFavoriteList = 'AlbumFavoriteList';

class FavoriteProvider extends BaseProvider {
  List<Track> _favoriteTracks = [];
  List<Track> get favoriteTracks => _favoriteTracks;
  List<Album> _favoriteAlbums = [];
  List<Album> get favoriteAlbums => _favoriteAlbums;

  FavoriteProvider() {
    getFavourites();
  }

  setFavoritesTracks(List<Track> favoriteTracks) {
    print(favoriteTracks);
    _favoriteTracks = favoriteTracks;
    notifyListeners();
  }

  setFavoritesAlbums(List<Album> favoriteAlbums) {
    print(favoriteTracks);
    _favoriteAlbums = favoriteAlbums;
    notifyListeners();
  }

  addToFavouritesTrack(Track track) {
    if (_favoriteTracks.contains(track)) {
      _favoriteTracks.remove(track);
    } else {
      _favoriteTracks.add(track);
    }
    saveTrackData();
    notifyListeners();
  }

  addToFavouritesAlbum(Album album) {
    if (_favoriteAlbums.contains(album)) {
      _favoriteAlbums.remove(album);
    } else {
      _favoriteAlbums.add(album);
    }
    saveAlbumData();
    notifyListeners();
  }

  saveTrackData() async {
    LocalStorage localStorage = LocalStorage(trackLocalStorageSearch);
    await localStorage.ready;
    localStorage.setItem(trackFavoriteList, _favoriteTracks);
  }

  saveAlbumData() async {
    LocalStorage localStorage = LocalStorage(albumLocalStorageSearch);
    await localStorage.ready;
    localStorage.setItem(albumFavoriteList, _favoriteAlbums);
  }

  getFavourites() async {
    isLoaded = false;
    notifyListeners();
    LocalStorage localStorage = LocalStorage(trackLocalStorageSearch);
    await localStorage.ready;
    List<Track> favoriteList =
        (localStorage.getItem(trackFavoriteList) ?? []).map<Track>((item) {
      return new Track.fromJson(item);
    }).toList();
    LocalStorage albumStorage = LocalStorage(albumLocalStorageSearch);
    await albumStorage.ready;
    List<Album> favoriteListalbum =
        (albumStorage.getItem(albumFavoriteList) ?? []).map<Album>((item) {
      return new Album.fromJson(item);
    }).toList();

    _favoriteTracks = favoriteList;
    _favoriteAlbums = favoriteListalbum;
    isLoaded = true;
    notifyListeners();
  }

  isFavouitedTrack(track) {
    return _favoriteTracks.contains(track);
  }

  isFavouitedAlbum(album) {
    return _favoriteAlbums.contains(album);
  }
}
