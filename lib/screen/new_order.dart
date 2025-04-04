import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/goods_group.dart';
import 'package:picassostore/model/model.dart';
import 'package:picassostore/model/new_order_model.dart';
import 'package:picassostore/model/partner.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/screen/goods_card.dart';
import 'package:picassostore/screen/search_goods.dart';
import 'package:picassostore/screen/search_partner.dart';
import 'package:picassostore/utils/http_query.dart';
import 'package:picassostore/utils/payment_types.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/qty_dialog.dart';
import 'package:picassostore/utils/styles.dart';

class NewOrder extends WMApp {
  final NewOrderModel orderModel;
  final GlobalKey<_NewOrderState> _orderStateKey = GlobalKey();

  NewOrder({super.key, required super.model, required this.orderModel});

  @override
  String titleText() {
    return locale().order;
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: model.menuRaise, icon: const Icon(Icons.menu)),
      IconButton(
          onPressed: () {
            _orderStateKey.currentState?._selectGoods();
          },
          icon: const Icon(Icons.add_shopping_cart)),
      IconButton(
          onPressed: () {
            _orderStateKey.currentState?._saveOrder();
          },
          icon: Icon(Icons.save))
    ];
  }

  @override
  List<Widget> menuWidgets() {
    return [
      Styling.menuButton2(() {
        _orderStateKey.currentState?._setComment();
      }, 'comment', locale().comment),
      Styling.menuButton2(() {
        _orderStateKey.currentState?._setDeliveryDate();
      }, 'delivery', locale().deliveryDate),
      Styling.menuButton2(() {
        _orderStateKey.currentState?._setPaymentType();
      }, 'payment', locale().paymentType),
      Styling.menuButton2(() {
        _orderStateKey.currentState?._clearOrder();
      }, 'clear', locale().clearOrder)
    ];
  }

  @override
  Widget body(BuildContext context) {
    return _NewOrderScreen(
        model: model, key: _orderStateKey, orderModel: orderModel);
  }

  @override
  void goBack(BuildContext context) {
    model.question(locale().confirmCloseWindow, () {
      super.goBack(context);
    }, () {});
  }

  @override
  Future<bool> checkGoBack() async {
    return false;
  }
}

class _NewOrderScreen extends StatefulWidget {
  final WMModel model;
  final NewOrderModel orderModel;

  const _NewOrderScreen(
      {super.key, required this.model, required this.orderModel});

  @override
  State<StatefulWidget> createState() => _NewOrderState();
}

class _NewOrderState extends State<_NewOrderScreen> {
  var _isEditable = true;

  @override
  void initState() {
    super.initState();
    if (widget.orderModel.id.isNotEmpty) {
      _openDraftOrder();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _partner(),
        _deliveryDate(),
        _comment(),
        Expanded(child: _listOfGoods()),
        _totalRow()
      ],
    );
  }

  Widget _partner() {
    if (widget.orderModel.partner.id == 0) {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        OutlinedButton(
            onPressed: _selectPartner,
            style: OutlinedButton.styleFrom(backgroundColor: Colors.indigo),
            child: Text(locale().selectPartner,
                style: const TextStyle(color: Colors.white)))
      ]);
    }
    return Row(children: [
      Expanded(
          child: InkWell(
              onTap: _selectPartner,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(color: Colors.indigo),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(children: [
                        Expanded(
                            child: Text(
                                '${widget.orderModel.partner.name} ${widget.orderModel.partner.discount > 0 ? '[${prefs.mdFormatDouble( widget.orderModel.partner.discount)}%]' : ''}',
                                style: const TextStyle(color: Colors.white))),
                        Text(widget.orderModel.partner.address,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white)),
                      ]),
                      Row(children: [
                        Expanded(
                            child: Text(widget.orderModel.partner.taxname,
                                style: const TextStyle(color: Colors.white))),
                        Text(widget.orderModel.partner.tin,
                            style: const TextStyle(color: Colors.white)),
                      ]),
                      if (widget.orderModel.partner.phone.isNotEmpty ||
                          widget.orderModel.partner.contact.isNotEmpty)
                        Row(children: [
                          Expanded(
                              child: Text(widget.orderModel.partner.phone,
                                  style: const TextStyle(color: Colors.white))),
                          Text(widget.orderModel.partner.contact,
                              style: const TextStyle(color: Colors.white)),
                        ]),
                    ],
                  ))))
    ]);
  }

  Widget _deliveryDate() {
    return Container(
        padding: const EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
        decoration: const BoxDecoration(color: Colors.indigoAccent),
        child: Row(
          children: [
            Expanded(
                child: Text(locale().deliveryDate,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold))),
            Text(DateFormat('dd/MM/yyyy').format(widget.orderModel.dateFor),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))
          ],
        ));
  }

  Widget _comment() {
    if (widget.orderModel.comment.isEmpty) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
      decoration: const BoxDecoration(color: Colors.indigoAccent),
      child: Row(
        children: [
          Expanded(
              child: Text(widget.orderModel.comment,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold))),
          IconButton(
              onPressed: () {
                widget.model.question(locale().confirmRemoveComment, () async {
                  setState(() => widget.orderModel.comment = '');
                  final box = await Hive.openBox<NewOrderModel>('box');
                  box.put('tempmodel', widget.orderModel);
                  box.close();
                }, () {});
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _listOfGoods() {
    if (widget.orderModel.goods.isEmpty) {
      return InkWell(
          onTap: _selectGoods,
          child: Center(
              child: Text(locale().emptyOrder,
                  style:
                      const TextStyle(fontSize: 30, color: Colors.black38))));
    }
    return ListView.builder(
        itemCount: widget.orderModel.goods.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget.orderModel.goods[index].toString()),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(locale().removeRow),
                    content: Text(
                        '${locale().confirmRemoveGoods}\r\n${widget.orderModel.goods[index].name}'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text(locale().cancel),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: Text(locale().remove),
                      ),
                    ],
                  );
                },
              );
            },
            background: Container(
              color: Colors.orange,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                if (!_isEditable) {
                  return;
                }
                final uuid = widget.orderModel.goods[index].uuid ?? '';
                if (uuid.isEmpty) {
                  widget.orderModel.goods.removeAt(index);
                } else {
                  HttpQuery('engine/picasso.store/').request({
                    'class': 'draft',
                    'method': 'removeOneRow',
                    'id': uuid
                  }).then((reply) {
                    widget.orderModel.goods.removeAt(index);
                  });
                }
              });
            },
            child: Container(
                decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.black26 : Colors.black12),
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                            onTap: () {
                              GoodsCard.show(
                                  widget.orderModel.goods[index], null);
                            },
                            child: Text(widget.orderModel.goods[index].name,
                                maxLines: 2, overflow: TextOverflow.ellipsis))),
                    InkWell(
                        onTap: () async {
                          if (!_isEditable) {
                            return;
                          }
                          final qty = await QtyDialog().getQty();
                          if ((qty ?? 0) > 0) {
                            widget.orderModel.goods[index] = widget
                                .orderModel.goods[index]
                                .copyWith(qty: qty ?? 0);
                            setState(() {});
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            decoration:
                                const BoxDecoration(color: Colors.amberAccent),
                            height: 45,
                            width: 45,
                            child: Text(
                                prefs.mdFormatDouble(
                                    widget.orderModel.goods[index].qty),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))))
                  ],
                )),
          );
        });
  }

  Widget _totalRow() {
    return Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 5),
        decoration: const BoxDecoration(color: Colors.indigo),
        child: Row(
          children: [
            Text(
                '${locale().total} (${Payments[widget.orderModel.paymentType]})',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Expanded(child: Container()),
            Text(prefs.mdFormatDouble(widget.orderModel.total()),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))
          ],
        ));
  }

  void _setComment() async {
    widget.model.navigation.hideMenu();
    if (!_isEditable) {
      return;
    }
    TextEditingController controller = TextEditingController();

    String? comment = await showDialog<String>(
      context: prefs.context(),
      builder: (context) {
        return AlertDialog(
          title: Text(locale().comment),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: locale().comment,
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(locale().cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: Text(locale().save),
            ),
          ],
        );
      },
    );

    if (comment != null && comment.isNotEmpty) {
      setState(() => widget.orderModel.comment = comment);
      final box = await Hive.openBox<NewOrderModel>('box');
      box.put('tempmodel', widget.orderModel);
      box.close();
    }
  }

  void _setDeliveryDate() async {
    widget.model.navigation.hideMenu();
    if (!_isEditable) {
      return;
    }
    DateTime? pickedDate = await showDatePicker(
      context: prefs.context(),
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (pickedDate != null) {
      setState(() {
        widget.orderModel.dateFor = pickedDate;
      });
      final box = await Hive.openBox<NewOrderModel>('box');
      box.put('tempmodel', widget.orderModel);
      box.close();
    }
  }

  void _setPaymentType() async {
    widget.model.navigation.hideMenu();
    if (!_isEditable) {
      return;
    }
    showPaymentDialog(prefs.context()).then((p) async {
      if (p != null) {
        setState(() => widget.orderModel.paymentType = p);
        final box = await Hive.openBox<NewOrderModel>('box');
        box.put('tempmodel', widget.orderModel);
        box.close();
      }
    });
  }

  void _selectPartner() async {
    if (!_isEditable) {
      return;
    }
    final p = await Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (_) => SearchPartnerScreen(model: widget.model)));
    if (p == null) {
      return;
    }
    setState(() => widget.orderModel.partner = p);
    final box = await Hive.openBox<NewOrderModel>('box');
    box.put('tempmodel', widget.orderModel);
    box.close();
  }

  void _selectGoods() async {
    if (!_isEditable) {
      return;
    }
    Map<String, dynamic> json = {
      'command': 'search_goods_groups',
      'database': prefs.string('database'),
      'template': '',
      'page': 0,
      'limit': 50,
    };
    widget.model.goodsGroups.clear();
    final r = await widget.model.appWebsocket.sendMessage(jsonEncode(json));
    if (r['errorCode'] == 0) {
      for (final e in r['result']) {
        widget.model.goodsGroups.add(GoodsGroup.fromJson(e));
      }
    }
    final goods = await Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (_) => SearchGoods(
                model: widget.model, orderModel: widget.orderModel)));

    setState(() {});
  }

  void _saveOrder() async {
    if (!_isEditable) {
      return;
    }
    if (widget.orderModel.partner.id == 0) {
      widget.model.error(locale().selectPartner);
      return;
    }
    if (widget.orderModel.goods.isEmpty) {
      widget.model.error(locale().emptyOrder);
      return;
    }
    final g = widget.orderModel.goods
        .map((t) => {
              'f_id': t.uuid ?? '',
              'f_header': widget.orderModel.id,
              'f_state': 1,
              'f_store': widget.orderModel.storeid,
              'f_goods': t.id,
              'f_qty': t.qty,
              'f_back': 0,
              'f_price': widget.orderModel.priceOfGoods(t),
              'f_discount': widget.orderModel.partner.discount,
              'f_special_price': 0
            })
        .toList();
    final d = {
      'f_id': widget.orderModel.id,
      'f_state': 1,
      'f_saletype': 1,
      'f_staff': prefs.getInt('userid'),
      'f_amount': widget.orderModel.total(),
      'f_comment': widget.orderModel.comment,
      'f_payment': widget.orderModel.paymentType,
      'f_partner': widget.orderModel.partner.id,
      'f_debt': 0,
      'f_datefor': DateFormat('yyyy-MM-dd').format(widget.orderModel.dateFor),
      'f_cashier': prefs.getInt('userid'),
      'f_flag': 0,
    };
    HttpQuery('engine/picasso.store/').request({
      'header': d,
      'body': g,
      'class': 'draft',
      'method': 'save'
    }).then((reply) async {
      if (reply['status'] == 1) {
        final box = await Hive.openBox<NewOrderModel>('box');
        await box.delete('tempmodel');
        Navigator.pop(prefs.context());
      } else {
        widget.model.error(reply['data']);
      }
    });
  }

  void _openDraftOrder() {
    HttpQuery('engine/picasso.store/').request({
      'class': 'draft',
      'method': 'openDraft',
      'id': widget.orderModel.id
    }).then((reply) {
      if (reply['status'] == 1) {
        setState(() {
          widget.orderModel.partner = Partner.fromJson(reply['partner']);
          widget.orderModel.comment = reply['order']['f_comment'];
          widget.orderModel.dateFor = DateFormat('yyyy-MM-dd')
              .parse(reply['order']['f_datefor'] ?? '2025-01-01');
          _isEditable = reply['order']['f_state'] != 2;
          for (final e in reply['goods']) {
            final g = Goods.fromJson(e);
            widget.orderModel.goods.add(g);
          }
        });
      } else {
        widget.model.error(reply['data']);
      }
    });
  }

  void _clearOrder() async {
    widget.model.navigation.hideMenu();
    final box = await Hive.openBox<NewOrderModel>('box');
    await box.delete('tempmodel');
    setState(() {
      widget.orderModel.partner = Partner.empty();
      widget.orderModel.goods.clear();
    });
  }
}
