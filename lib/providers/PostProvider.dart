import 'package:flutter_rekord_app/models/Post.dart';
import 'package:flutter_rekord_app/providers/BaseProvider.dart';

class PostProvider extends BaseProvider {
  PostProvider() {
    fetchposts();
  }

  Map<String, String> params = {};

  List<Post> _posts = <Post>[];
  List<Post> get posts => _posts;

  Post _postItem;
  Post get postItem => _postItem;

  int _page = 0;
  bool _hasMoreItems = true;

  void setHttpRequestPrams() {
    params.update(
      'page',
      (existingValue) => _page.toString(),
      ifAbsent: () => '1',
    );
  }

  void fetchposts() async {
    print('in fetch post.....');
    _page++;
    if (_page == 1) isLoaded = false;
    if (!_hasMoreItems) return;
    isLoadingMoreInProgress = true;

    notifyListeners();

    /// Setting request paramerters
    setHttpRequestPrams();

    /// Fetch items from server: pass endping and parameters
    List items = await fetch('posts', params);

    /// if no more items stop further request
    if (items.length == 0) {
      _hasMoreItems = false;
      notifyListeners();
      return;
    }

    items.forEach((item) {
      var newItem = new Post.fromJson(item);
      _posts.add(newItem);
    });

    isLoadingMoreInProgress = false;
    isLoaded = true;

    notifyListeners();
  }
}
