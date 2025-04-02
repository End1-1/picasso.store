import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picassostore/model/partner.dart';
import 'package:picassostore/screen/app.dart';
import 'package:picassostore/utils/http_query.dart';
import 'package:picassostore/utils/prefs.dart';
import 'package:picassostore/utils/styles.dart';

enum Check { idle, checking, ok, fail, saving, exists }

class CheckCubit extends Cubit<Check> {
  CheckCubit() : super(Check.idle);

  setState(Check c) => emit(c);
}

class NewPartner extends WMApp {
  final _tinController = TextEditingController();
  final _taxnameController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _phoneController = TextEditingController();

  NewPartner({super.key, required super.model}) {
    prefs.context().read<CheckCubit>().setState(Check.idle);
  }

  @override
  String titleText() {
    return locale().newPartner;
  }

  @override
  List<Widget> actions() {
    return [
      IconButton(onPressed: _clearFields, icon: const Icon(Icons.clear)),
      IconButton(onPressed: _save, icon: const Icon(Icons.save))];
  }

  @override
  Widget body(BuildContext context) {
    return BlocBuilder<CheckCubit, Check>(builder: (context, state) {
      return Stack(children: [
        Column(children: [
          Styling.columnSpacingWidget(),
          Row(children: [
            Expanded(
                child: Styling.textFormField(
                    _tinController,
                    readOnly: state == Check.checking,
                    locale().tin,
                    maxLength: 8,
                    onChanged: _tinChanged)),
            Styling.rowSpacingWidget(),
            if (state == Check.idle || state == Check.fail)
              Icon(Icons.cancel, color: Colors.red),
            if (state == Check.checking) CircularProgressIndicator(),
            if (state == Check.exists)
              Icon(Icons.accessibility_new_rounded, color: Colors.blueAccent),
            if (state == Check.ok)
              Icon(Icons.done_all, color: Colors.lightGreen)
          ]),
          Styling.columnSpacingWidget(),
          Styling.textFormField(_taxnameController, locale().taxpayerName),
          Styling.columnSpacingWidget(),
          Styling.textFormField(_addressController, locale().address),
          Styling.columnSpacingWidget(),
          Styling.textFormField(_contactController, locale().contact),
          Styling.columnSpacingWidget(),
          Styling.textFormField(_phoneController, locale().phone)
        ]),
        if (state == Check.saving)
          Column(
            children: [
              Expanded(
                  child: Container(
                      decoration: const BoxDecoration(color: Colors.white30),
                      child: Center(
                        child: CircularProgressIndicator(),
                      )))
            ],
          )
      ]);
    });
  }

  void _tinChanged(String tin) {
    if (tin.length == 8) {
      prefs.context().read<CheckCubit>().setState(Check.checking);
      HttpQuery('engine/picasso.store/').request(
          {'class': 'partners', 'method': 'check', 'tin': tin}).then((reply) {
        switch (reply['status']) {
          case 1:
            prefs.context().read<CheckCubit>().setState(Check.ok);
            break;
          case 2:
            final p = reply['partner'];
            _taxnameController.text= p['f_taxname'];
            _addressController.text = p['f_address'];
            _contactController.text = p['f_contact'];
            _phoneController.text = p['f_phone'];
            prefs.context().read<CheckCubit>().setState(Check.exists);
            break;
          default:
            prefs.context().read<CheckCubit>().setState(Check.fail);
            break;
        }
      });
      return;
    }
    prefs.context().read<CheckCubit>().setState(Check.fail);
  }

  void _save() {
    if (_tinController.text.length != 8) {
      model.error(locale().wrongTin);
      return;
    }
    prefs.context().read<CheckCubit>().setState(Check.saving);
    HttpQuery('engine/picasso.store/').request({
      'class': 'partners',
      'method': 'newPartner',
      'tin': _tinController.text,
      'taxpayername': _taxnameController.text,
      'address': _addressController.text,
      'contact': _contactController.text,
      'phone': _phoneController.text
    }).then((reply) {
      if (reply['status'] == 1) {
        Partner p = Partner(
            id: reply['id'],
            taxname: _taxnameController.text,
            tin: _tinController.text,
            phone: _phoneController.text,
            contact: _contactController.text,
            mode: 1,
            discount: 0,
            address: _addressController.text);
        Navigator.pop(prefs.context(), p);
      } else {
        prefs.context().read<CheckCubit>().setState(Check.fail);
        model.error(reply['data']);
      }
    });
  }

  void _clearFields() {
    _tinController.clear();
    _taxnameController.clear();
    _addressController.clear();
    _contactController.clear();
    _phoneController.clear();
  }
}
