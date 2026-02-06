part of 'deliver_note.dart';

class GoodsCubit extends Cubit<List<Goods>> {
  GoodsCubit() : super([]);

  void data(List<Goods> goods) => emit(goods);
}

extension _DeliveryNoteExt on _DeliveryNoteState {
  void _openDoc() async {
    if (kDebugMode) {
      final barcode = 'doc;2e1ee920-e5d3-45e5-9a54-ed9fc18cbabf;N222;2025-06-24 14:24:30';
      _processDoc(barcode);
      return;
    }
    widget.model.navigation.readBarcode().then((barcode) {
      if (barcode != null) {
        _processDoc(barcode);
      }
    });
  }

  void _confirm() {
    for (final e in widget.docModel.goods) {
      if (e.f_qty != widget.docModel.goodsCheck[e.f_barcode]) {
        widget.model.error(locale().checkAllQty);
        return;
      }
    }
    HttpQuery('engine/picasso.store/').request({
      'class': 'checksaleoutput',
      'method': 'confirm',
      'doc': widget.docModel.id
    }).then((reply) {
      if (reply['status'] == 1) {
        Navigator.pop(prefs.context());
      } else {
        widget.model.error(reply['data']);
      }
    });
  }

  void _processDoc(String docnum) async {
    _isLoading = true;
    refresh();
    HttpQuery('engine/picasso.store/').request({
      'class': 'checksaleoutput',
      'method': 'open',
      'docparams': docnum
    }).then((reply) {
      _isLoading = false;
      if (reply['status'] == 1) {
        widget.docModel.goods.clear();
        widget.docModel.codes.clear();
        widget.docModel.qrCode.clear();
        widget.docModel.id = reply['id'];
        for (final e in reply['goods']) {
          final Goods g = Goods.fromJson(e);
          widget.docModel.goods.add(g);
          widget.docModel.goodsCheck[g.f_barcode] = 0;
        }
        for (final e in reply['qrlist']) {
          final qr = String.fromCharCodes(base64Decode(e['f_qr']));
          widget.docModel.qrCode.add(qr);
          widget.docModel.codes.add(widget.docModel.barcodeFromQr(qr));
        }
        widget.docModel.count();
      } else {
        widget.model.error(reply['data']);
      }
      refresh();
    });
  }

  void _addQr() async {
    if (widget.docModel.goods.isEmpty) {
      widget.model.error(locale().emptyOrder);
      return;
    }
    final barcode = await widget.model.navigation.readBarcode();
    if (barcode != null) {
      _processBarcode(barcode);
    }
  }

  void _processBarcode(String code) async {
    _isLoading = true;
    refresh();

    if (code.length == 13 || code.length == 8) {
      if (!widget.docModel.goodsCheck.containsKey(code)) {
        widget.model.error(locale().barcodeNotExistsInOrder);
        _isLoading = false;
        refresh();
        return;
      }
      widget.docModel.codes.add(code);
    } else {
      final barcode = widget.docModel.barcodeFromQr(code);
      if (barcode.isNotEmpty) {
        if (!widget.docModel.goodsCheck.containsKey(barcode)) {
          widget.model.error(locale().barcodeNotExistsInOrder);
          _isLoading = false;
          refresh();
          return;
        }
        final reply = await HttpQuery('/engine/picasso.store/').request({
          'class': 'checksaleoutput',
          'method': 'checkQr',
          'f_header': widget.docModel.id,
          'f_qr': base64.encode(code.codeUnits)
        });

        if (reply['status'] == 1) {
          widget.docModel.codes.add(barcode);
          widget.docModel.qrCode.add(code);
        } else {
          widget.model.error(reply['data']);
        }
      }
    }
    widget.docModel.count();
    _isLoading = false;
    refresh();
  }

  void _onInputChanged() {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }

    var code = _controller.text;
    _debounceTimer = Timer(Duration(milliseconds: 500), () {
      if (code.isNotEmpty) {
        debugInfo('Now where process the "$code"');
        if (code.toLowerCase().startsWith('doc;')) {
          _processDoc(code);
        } else {
          _processBarcode(code);
        }
        code = '';
        _controller.clear();
      }
    });
  }

  void _setQtyOf(String qr) {
    Navigator.push(
        prefs.context(),
        MaterialPageRoute(
            builder: (_) =>
                DeliveryNoteDetails(widget.docModel, qr, model: widget.model)));
  }
}
