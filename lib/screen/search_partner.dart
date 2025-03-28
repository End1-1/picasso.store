import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/model/partner.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';

class SearchPartnerScreen extends WMApp {
  final GlobalKey<_SearchState> _searchStateKey = GlobalKey();
  SearchPartnerScreen({super.key, required super.model});

  @override
  String titleText() {
    return locale().partners;
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: ()=>_searchStateKey.currentState?._newPartner(), icon: const Icon(Icons.add))
    ];
  }

  @override
  Widget body() {
    return _SearchScreen(model, key: _searchStateKey);
  }
}

class _SearchScreen extends StatefulWidget {
  final WMModel model;

  _SearchScreen(this.model, {required super.key});

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<_SearchScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();
  final List<Partner> _partners = [];
  var _page = 0;
  var _limit = 50;
  var _previouseSearch = '';
  var _isLoading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(children: [
        Expanded(
            child: TextFormField(
              autofocus: true,
          controller: _controller,
          onChanged: _onSearchChanged,
        )),
        SizedBox(
            height: 30,
            child: Styling.menuButton3(() {
              _onSearchChanged(_controller.text);
            }, 'search', Colors.black, ''))
      ]),
      Expanded(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
                      itemCount: _partners.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (_isLoading && index == _partners.length) {
                          return Center(
                              child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator()));
                        }
                        return InkWell(
                            onTap: () {
                              Navigator.pop(prefs.context(), _partners[index]);
                            },
                            child: SizedBox(
                                height: 40,
                                child: Row(children: [
                                  SizedBox(
                                      width: 100,
                                      child: Text(_partners[index].tin)),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                      width: 200,
                                      child: Text(_partners[index].taxname)),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                      width: 150,
                                      child: Text(_partners[index].contact)),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                      width: 150,
                                      child: Text(_partners[index].phone)),
                                ])));
                      }))))
    ]);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      _page++;
      _previouseSearch = _controller.text;
      _onSearchChanged(_controller.text);
    }
  }

  void _onSearchChanged(String query) {
    if (_previouseSearch != query) {
      setState(() {
        _page = 0;
        _partners.clear();
      });
    }
    _previouseSearch = query;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      Map<String, dynamic> json = {
        'command': 'search_partner',
        'database': prefs.string('database'),
        'template': query,
        'page': _page,
        'limit': _limit,
      };
      setState(() => _isLoading = true);
      final r = await widget.model.appWebsocket.sendMessage(jsonEncode(json));
      if (r['errorCode'] == 0) {
        if (r['noresult'] ?? true) {
          _partners.clear();
          _page = 0;
        }
        for (final e in r['result']) {
          Partner p = Partner.fromJson(e);
          _partners.add(p);
        }
        _page++;
        setState(() => _isLoading = false);
      }
    });
  }

  void _newPartner() {

  }
}
