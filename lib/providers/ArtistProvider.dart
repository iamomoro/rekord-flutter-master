import 'package:flutter_rekord_app/models/Artist.dart';
import 'package:flutter_rekord_app/providers/BaseProvider.dart';

class ArtistProvider extends BaseProvider {
  ArtistProvider() {
    fetchArtists();
  }
  Map<String, String> params = {};

  List<Artist> _artists = <Artist>[];
  List<Artist> get artists => _artists;

  Artist _artist;
  Artist get artist => _artist;

  bool isLoaded = false;
  int _page = 0;
  bool _hasMoreItems = true;

  void setHttpRequestPrams() {
    params.update(
      'page',
      (existingValue) => _page.toString(),
      ifAbsent: () => '1',
    );
  }

  void fetchArtists() async {
    _page++;
    if (_page == 1) isLoaded = false;
    if (!_hasMoreItems) return;
    isLoadingMoreInProgress = true;

    notifyListeners();

    /// Setting request paramerters
    setHttpRequestPrams();

    /// Fetch items from server: pass endping and parameters
    List items = await fetch('artists', params);

    /// if no more items stop further request
    if (items.length == 0) {
      _hasMoreItems = false;
      notifyListeners();
      return;
    }

    items.forEach((item) {
      var newItem = new Artist.fromJson(item);
      _artists.add(newItem);
    });

    isLoadingMoreInProgress = false;
    isLoaded = true;

    notifyListeners();
  }

  clearList() {
    artists.clear();
    notifyListeners();
  }
}
