import 'package:flutter_rekord_app/providers/BaseProvider.dart';
import 'package:flutter_rekord_app/models/Album.dart';

class AlbumProvider extends BaseProvider {
  AlbumProvider() {
    fetchAlbums();
  }

  Map<String, String> params = {};

  List<Album> _albums = <Album>[];
  List<Album> get albums => _albums;

  Album _album;
  Album get album => _album;

  int _page = 0;
  bool _hasMoreItems = true;

  void setHttpRequestPrams() {
    params.update(
      'page',
      (existingValue) => _page.toString(),
      ifAbsent: () => '1',
    );
  }

  void fetchAlbums() async {
    _page++;
    if (_page == 1) isLoaded = false;
    if (!_hasMoreItems) return;
    isLoadingMoreInProgress = true;

    notifyListeners();

    /// Setting request paramerters
    setHttpRequestPrams();

    /// Fetch items from server: pass endping and parameters
    List items = await fetch('albums', params);

    /// if no more items stop further request
    if (items.length == 0) {
      _hasMoreItems = false;
      notifyListeners();
      return;
    }

    items.forEach((item) {
      var newItem = new Album.fromJson(item);
      _albums.add(newItem);
    });

    isLoadingMoreInProgress = false;
    isLoaded = true;

    notifyListeners();
  }
}
