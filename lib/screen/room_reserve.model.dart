part of 'room_reserve.dart';

class RoomReserveModel {
  final priceTextController = TextEditingController();
  final totalTextController = TextEditingController();
  final guestFirstNameTextController = TextEditingController();
  final guestLastNameTextController = TextEditingController();
  final guests = <dynamic>[];
  dynamic room;
  var createdDate = DateTime.now();
  var entryDate = DateTime.now();
  var departureDate = DateTime.now();
}

class AppStateRoomReserve extends AppStateFinished {}

class AppStateRoomReserveGuest extends AppStateFinished {}

extension WMERoomReserve on WMRoomReserve {
  void openRoom() {
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        model.tr('Open room'),
        '/engine/hotel/open-room.php',
        {'room': _model.room['f_id']}, (e, d) {
      if (e) {
        return;
      }
      if (d['reservation'].isNotEmpty) {
        final r = d['reservation'][0];
        _model.createdDate = prefs.strDate(r['f_created']);
        _model.entryDate = prefs.strDate(r['f_startDate']);
        _model.departureDate = prefs.strDate(r['f_endDate']);
        _model.priceTextController.text = r['f_roomFee'];
        _model.totalTextController.text = r['f_grandTotal'];
        _model.guests.clear();
        for (final e in d['guests']) {
          _model.guests.add(e);
        }
      }
    }, AppStateRoomReserve()));
  }

  void editEntry() {
    showDatePicker(
            context: prefs.context(),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value != null) {
        _model.entryDate = value;
        priceChanged('');
        BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
            '', '', {}, (p0, p1) => null, AppStateRoomReserve()));
      }
    });
  }

  void editDeparture() {
    showDatePicker(
            context: prefs.context(),
            initialEntryMode: DatePickerEntryMode.calendarOnly,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 30)))
        .then((value) {
      if (value != null) {
        _model.departureDate = value;
        priceChanged('');
        BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
            '', '', {}, (p0, p1) => null, AppStateRoomReserve()));
      }
    });
  }

  void addGuest() {
    _model.guestLastNameTextController.clear();
    _model.guestFirstNameTextController.clear();
    showDialog(
        context: prefs.context(),
        builder: (builder) {
          return SimpleDialog(
              shape: Border.all(color: Colors.transparent),
              contentPadding: const EdgeInsets.all(10),
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Styling.textFormField(
                                _model.guestLastNameTextController,
                                model.tr('First name')))
                      ],
                    ),
                    Styling.columnSpacingWidget(),
                    Row(
                      children: [
                        Expanded(
                            child: Styling.textFormField(
                                _model.guestFirstNameTextController,
                                model.tr('Last name')))
                      ],
                    ),
                    Row(
                      children: [
                        Styling.textButton(() {
                          Navigator.pop(prefs.context(), true);
                        }, model.tr('Ok'))
                      ],
                    )
                  ],
                )
              ]);
        }).then((value) {
      if (value ?? false) {
        _model.guests.add({
          'f_id': 0,
          'f_firstname': _model.guestFirstNameTextController.text,
          'f_lastname': _model.guestLastNameTextController.text
        });
        BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
            '', '', {}, (p0, p1) => null, AppStateRoomReserveGuest()));
      }
    });
  }

  void priceChanged(String s) {
    int d = _model.departureDate.difference(_model.entryDate).inDays;
    _model.totalTextController.text = '${d * (double.tryParse(_model.priceTextController.text) ?? 0)}';
  }

  void save() {
    Navigator.pop(prefs.context());
  }
}
