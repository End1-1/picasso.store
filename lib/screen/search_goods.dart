import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/model/new_order_model.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/screen/goods_card.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/qty_dialog.dart';
import 'package:picassostore/utils/styles.dart';

class SearchGoods extends WMApp {
  final GlobalKey<_SearchGoodsState> _searchStateKey = GlobalKey();
  final NewOrderModel orderModel;

  SearchGoods({super.key, required super.model, required this.orderModel});

  @override
  String titleText() {
    return locale().goods;
  }

  @override
  Widget body() {
    return _SearchGoodsScreen(model: model, key: _searchStateKey, orderModel: orderModel);
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: model.menuRaise, icon: const Icon(Icons.menu))
    ];
  }

  @override
  List<Widget> menuWidgets() {
    return [
      for (final gg in model.goodsGroups) ...[
        Styling.menuButton2(() {
          model.navigation.hideMenu();
          _searchStateKey.currentState?._getGroup(gg.id, gg.name);
        }, 'search', '${gg.name} (${gg.count})'),
      ]
    ];
  }
}

class _SearchGoodsScreen extends StatefulWidget {
  final WMModel model;
  final NewOrderModel orderModel;

  const _SearchGoodsScreen(
      {super.key, required this.model, required this.orderModel});

  @override
  State<StatefulWidget> createState() => _SearchGoodsState();
}

class _SearchGoodsState extends State<_SearchGoodsScreen> {
  static const cardWidth = 160.0;
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  var _groupid = 0;
  var _groupName = '';
  var _page = 0;
  var _limit = 100;
  var _isLoading = false;
  var _previouse = '';
  final focus = FocusNode();
  Timer? _debounce;
  final List<Goods> _goods = [];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_groupName.isNotEmpty) Text(_groupName),
        Row(children: [
          Expanded(
              child: TextFormField(
            focusNode: focus,
            controller: _textController,
            onChanged: _onSearchChanged,
          )),
          SizedBox(
              height: 30,
              child: Styling.menuButton3(() {
                _page = -1;
                _onSearchChanged('');
              }, 'clear', Colors.black, ''))
        ]),
        Expanded(
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        (MediaQuery.sizeOf(context).width / cardWidth).floor(),
                    crossAxisSpacing: 10,
                    childAspectRatio: cardWidth / 180,
                    mainAxisSpacing: 10),
                controller: _scrollController,
                itemCount: _goods.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _goods.length) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return _goodsItem(_goods[index]);
                })),
      ],
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _page++;
      _previouse = _textController.text;
      _onSearchChanged(_textController.text);
    }
  }

  void _getGroup(int groupid, String groupname) {
    _groupid = groupid;
    _groupName = groupname;
    _page = 0;
    _goods.clear();
    _onSearchChanged(_textController.text);
  }

  void _onSearchChanged(String query) {
    if (_page == -1) {
      setState(() {
        _page = 0;
        _groupid = 0;
        _groupName = '';
        _goods.clear();
        _textController.clear();
      });
      return;
    }
    if (_previouse != query) {
      setState(() {
        _page = 0;
        _goods.clear();
      });
    }
    _previouse = query;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      Map<String, dynamic> json = {
        'command': 'search_goods',
        'database': prefs.string('database'),
        'template': query,
        'page': _page,
        'limit': _limit,
        'groupid': _groupid
      };
      setState(() => _isLoading = true);
      final r = await widget.model.appWebsocket.sendMessage(jsonEncode(json));
      if (r['errorCode'] == 0) {
        if (r['noresult'] ?? true) {
          print('noresult true') ;
          _goods.clear();
          _page = 0;
        }
        for (final e in r['result']) {
          _goods.add(Goods.fromJson(e));
        }
        _page++;
        setState(() => _isLoading = false);
      }
    });
  }

  Widget _goodsItem(Goods g) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(onTap:(){
              GoodsCard.show(g, widget.orderModel);
            }, child: Image.network(
              'https://${prefs.string("serveraddress")}/engine/media/goods/s${g.id}.jpg',
              width: double.infinity,
              height: 100,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              (loadingProgress.expectedTotalBytes ?? 1)
                          : null,
                    ),
                  );
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/noimage.png', height: 100);
              },
            )),
            Styling.columnSpacingWidget(),
            Text(g.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            Row(children: [
              Text(prefs.mdFormatDouble(g.p1d > 0 ? g.p1d : g.p1),
                  style: const TextStyle(
                      color: Colors.indigo,
                      fontSize: 12,
                      fontWeight: FontWeight.bold)),
              Expanded(child: Container()),
              IconButton(
                  onPressed: () {
                    focus.unfocus();
                    QtyDialog().getQty().then((qty) {
                      if ((qty ?? 0) == 0) {
                        return;
                      }
                      Goods newGoods = g.copyWith(qty: qty!);
                      widget.orderModel.goods.add(newGoods);
                    });
                  },
                  icon: Icon(Icons.add_shopping_cart))
            ]),
          ],
        ),
      ),
    );
  }
}
