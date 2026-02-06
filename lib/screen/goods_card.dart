import 'package:flutter/material.dart';
import 'package:picassostore/model/goods.dart';
import 'package:picassostore/model/new_order_model.dart';
import 'package:picassostore/utils/http_query.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/qty_dialog.dart';
import 'package:picassostore/utils/styles.dart';

class GoodsCard extends StatefulWidget {
  static show(Goods g, NewOrderModel? m) {
    showDialog(
        context: prefs.context(),
        builder: (context) {
          return Dialog(
              insetPadding: const EdgeInsets.all(15), child: GoodsCard(g, m));
        });
  }

  final Goods goods;
  final NewOrderModel? orderModel;

  const GoodsCard(this.goods, this.orderModel, {super.key});

  @override
  State<StatefulWidget> createState() => _GoodsCardState();
}

class _GoodsCardState extends State<GoodsCard> {
  Future<double>? _stockQtyFuture;

  @override
  void initState() {
    super.initState();
    _stockQtyFuture = _fetchStockQty();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://${prefs.string("serveraddress")}/engine/media/goods/b${widget.goods.f_id}.jpg',
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).width * .8,
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
                  ),
                  Styling.columnSpacingWidget(),
                  Text(widget.goods.f_name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold)),
                  Row(children: [
                    SizedBox(width: 200, child: Text(locale().retailPrice)),
                    Styling.rowSpacingWidget(),
                    Text(prefs.mdFormatDouble(widget.goods.f_price1),
                        style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Row(children: [
                    SizedBox(
                        width: 200,
                        child: Text(locale().retailPriceDiscounted)),
                    Styling.rowSpacingWidget(),
                    Text(prefs.mdFormatDouble(widget.goods.f_price1disc),
                        style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Row(children: [
                    SizedBox(width: 200, child: Text(locale().whosalePrice)),
                    Styling.rowSpacingWidget(),
                    Text(prefs.mdFormatDouble(widget.goods.f_price2),
                        style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Row(children: [
                    SizedBox(
                        width: 200,
                        child: Text(locale().whosalePriceDiscounted)),
                    Styling.rowSpacingWidget(),
                    Text(prefs.mdFormatDouble(widget.goods.f_price2disc),
                        style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  ]),
                  Row(
                    children: [
                      SizedBox(width: 200, child: Text(locale().stockQty)),
                      Styling.rowSpacingWidget(),
                      FutureBuilder<double>(
                        future: _stockQtyFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text(locale().loadingError,
                                style: TextStyle(color: Colors.red));
                          } else {
                            return Text(
                              prefs.mdFormatDouble(snapshot.data ?? 0),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  if (widget.orderModel != null)
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              QtyDialog().getQty().then((qty) {
                                if ((qty ?? 0) == 0) {
                                  return;
                                }
                                Goods newGoods =
                                    widget.goods.copyWith(f_qty: qty!);
                                widget.orderModel?.goods.add(newGoods);
                                Navigator.pop(prefs.context());
                              });
                            },
                            icon: Icon(Icons.add_shopping_cart))
                      ],
                    )
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(prefs.context());
                  },
                  icon: Icon(Icons.close, color: Colors.red),
                ),
              )
            ])));
  }

  Future<double> _fetchStockQty() async {
    final reply = await HttpQuery('engine/worker/check-qty.php')
        .request({'goodsid': widget.goods.f_id, 'method': 'checkStore'});
    if (reply['status'] == 1) {
      return (reply['remain'] as num).toDouble();
    }
    return 0;
  }
}
