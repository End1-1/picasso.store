import 'dart:convert';

import 'package:flutter/material.dart';
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
  final String orderId;
  final GlobalKey<_NewOrderState> _orderStateKey = GlobalKey();

  NewOrder({super.key, required super.model, required this.orderId});

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
    ];
  }

  @override
  Widget body() {
    return _NewOrderScreen(model: model, key: _orderStateKey, orderId: orderId);
  }

  @override
  void goBack(BuildContext context) {
    model.question(locale().confirmCloseWindow, () {
      super.goBack(context);
    }, () {});
  }
}

class _NewOrderScreen extends StatefulWidget {
  final WMModel model;
  final _orderModel = NewOrderModel();

  _NewOrderScreen({super.key, required this.model, required String orderId}) {
    _orderModel.id = orderId;
  }

  @override
  State<StatefulWidget> createState() => _NewOrderState();
}

class _NewOrderState extends State<_NewOrderScreen> {
  var _isEditable = true;

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
    if (widget._orderModel.partner.id == 0) {
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
                            child: Text(widget._orderModel.partner.taxname,
                                style: const TextStyle(color: Colors.white))),
                        Text(widget._orderModel.partner.tin,
                            style: const TextStyle(color: Colors.white)),
                      ]),
                      Row(children: [
                        Expanded(
                            child: Text(widget._orderModel.partner.phone,
                                style: const TextStyle(color: Colors.white))),
                        Text(widget._orderModel.partner.contact,
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
            Expanded(child: Text(locale().deliveryDate,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
            Text(DateFormat('dd/MM/yyyy').format(widget._orderModel.dateFor),
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))
          ],
        ));
  }

  Widget _comment() {
    if (widget._orderModel.comment.isEmpty) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(left: 3, right: 3, top: 5, bottom: 5),
      decoration: const BoxDecoration(color: Colors.indigoAccent),
      child: Row(
        children: [
          Expanded(child: Text(widget._orderModel.comment,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold))),
          IconButton(
              onPressed: () {
                widget.model.question(locale().confirmRemoveComment, () {
                  setState(() => widget._orderModel.comment = '');
                }, () {});
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }

  Widget _listOfGoods() {
    if (widget._orderModel.goods.isEmpty) {
      return InkWell(
          onTap: _selectGoods,
          child: Center(
              child: Text(locale().emptyOrder,
                  style:
                      const TextStyle(fontSize: 30, color: Colors.black38))));
    }
    return ListView.builder(
        itemCount: widget._orderModel.goods.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(widget._orderModel.goods[index].toString()),
            direction: DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(locale().removeRow),
                    content: Text(
                        '${locale().confirmRemoveGoods}\r\n${widget._orderModel.goods[index].name}'),
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
                final uuid = widget._orderModel.goods[index].uuid ?? '';
                if (uuid.isEmpty) {
                  widget._orderModel.goods.removeAt(index);
                } else {
                  HttpQuery('engine/picasso.store/')
                      .request(
                      {'class': 'draft', 'method': 'removeOneRow', 'id': uuid})
                      .then((reply) {
                    widget._orderModel.goods.removeAt(index);
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
                                  widget._orderModel.goods[index], null);
                            },
                            child: Text(widget._orderModel.goods[index].name,
                                maxLines: 2, overflow: TextOverflow.ellipsis))),
                    InkWell(
                        onTap: () async {
                          if (!_isEditable) {
                            return;
                          }
                          final qty = await QtyDialog().getQty();
                          if ((qty ?? 0) > 0) {
                            widget._orderModel.goods[index] = widget
                                ._orderModel.goods[index]
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
                                    widget._orderModel.goods[index].qty),
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
            Text('${locale().total} (${Payments[widget._orderModel.paymentType]})',
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white)),
            Expanded(child: Container()),
            Text(prefs.mdFormatDouble(widget._orderModel.total()),
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
      setState(() {
        widget._orderModel.comment = comment; // Сохраняем комментарий
      });
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
        widget._orderModel.dateFor = pickedDate;
      });
    }
  }

  void _setPaymentType() async {
    widget.model.navigation.hideMenu();
    if (!_isEditable) {
      return;
    }
    showPaymentDialog(prefs.context()).then((p) {
      if (p != null) {
        setState(() => widget._orderModel.paymentType = p);
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
    setState(() => widget._orderModel.partner = p);
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
                model: widget.model, orderModel: widget._orderModel)));

    setState(() {});
  }

  void _saveOrder() async {
    if (!_isEditable) {
      return;
    }
    if (widget._orderModel.partner.id == 0) {
      widget.model.error(locale().selectPartner);
      return;
    }
    if (widget._orderModel.goods.isEmpty) {
      widget.model.error(locale().emptyOrder);
      return;
    }
    final g = widget._orderModel.goods
        .map((t) => {
              'f_id': t.uuid ?? '',
              'f_header': widget._orderModel.id,
              'f_state': 1,
              'f_store': widget._orderModel.storeid,
              'f_goods': t.id,
              'f_qty': t.qty,
              'f_back': 0,
              'f_price': widget._orderModel.priceOfGoods(t),
              'f_discount': widget._orderModel.partner.discount,
              'f_special_price': 0
            })
        .toList();
    final d = {
      'f_id': widget._orderModel.id,
      'f_state': 1,
      'f_saletype': 1,
      'f_staff': prefs.getInt('userid'),
      'f_amount': widget._orderModel.total(),
      'f_comment': widget._orderModel.comment,
      'f_payment': widget._orderModel.paymentType,
      'f_partner': widget._orderModel.partner.id,
      'f_debt': 0,
      'f_datefor': DateFormat('yyyy-MM-dd').format(widget._orderModel.dateFor),
      'f_cashier': prefs.getInt('userid'),
      'f_flag': 0,
    };
    HttpQuery('engine/picasso.store/').request({'header': d, 'body': g, 'class': 'draft', 'method':'save'}).then((reply) {
      if (reply['status'] == 1) {
        Navigator.pop(prefs.context());
      } else {
        widget.model.error(reply['data']);
      }
    });

  }

  void _openDraftOrder() {
    HttpQuery('engine/picasso.store/').request({'class':'draft', 'method':'openDraft', 'id':widget._orderModel.id}).then((reply) {
      if (reply['status'] == 1) {
        setState(() {
          widget._orderModel.partner = Partner.fromJson(reply['partner']);
          widget._orderModel.comment = reply['order']['f_comment'];
          widget._orderModel.dateFor = DateFormat('yyyy-MM-dd').parse(reply['order']['f_datefor'] ?? '2025-01-01');
          _isEditable = reply['order']['f_state'] != 2;
          for (final e in reply['goods']) {
            final g = Goods.fromJson(e);
            widget._orderModel.goods.add(g);
          }
        });
      } else {
        widget.model.error(reply['data']);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget._orderModel.id.isNotEmpty) {
      _openDraftOrder();
    }
  }
}
