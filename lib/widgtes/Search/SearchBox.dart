import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class SearchBox extends StatefulWidget {
  final Function onSearch;
  final String placeholder;
  SearchBox({this.onSearch, this.placeholder});
  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  final _searchQuery = new TextEditingController();
  Timer _debounce;
  @override
  void initState() {
    super.initState();
    _searchQuery.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchQuery.removeListener(_onSearchChanged);
    _searchQuery.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onSearch(_searchQuery.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(3)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchQuery,
                  decoration: InputDecoration(
                    icon: Icon(EvilIcons.search),
                    hintText: widget.placeholder == null
                        ? 'Search...'
                        : widget.placeholder,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
