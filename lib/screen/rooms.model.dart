part of 'rooms.dart';

class RoomsModel {
  String categoryFilter = '';
  final entryDateTextController = TextEditingController();
  final departureDateTextController = TextEditingController();

  var entryDate = DateTime.now();
  var departureDate = DateTime.now();

  final categories = <dynamic>[];
  final menuWidgets = <Widget>[];

  RoomsModel() {
    entryDateTextController.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    departureDateTextController.text =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  String entry() {
    return DateFormat('yyyy-MM-dd').format(entryDate);
  }

  String departure() {
    return DateFormat('yyyy-MM-dd').format(departureDate);
  }


}

class AppStateRooms extends AppStateFinished {}
class AppStateRoomsFilter extends AppStateFinished {}

extension WMERoomsScreen on WMRoomsScreen {
  void getRooms() {
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        model.tr('Querying'),
        '/engine/hotel/rooms-of-category.php',
        {
          'entry': _model.entry(),
          'departure': _model.departure(),
          'category': _model.categoryFilter == '[-]' ? '' : _model.categoryFilter
        },
        (e, d) {
          if (e) {
            return;
          }
          _model.categories.clear();
          _model.categories.add(['0', '[-]', model.tr('All')]);
          _model.categories.addAll(d['categories']);
        },
        AppStateRooms()));
  }

  void filterCategories() {
    _model.menuWidgets.clear();
    for (final e in _model.categories) {
      _model.menuWidgets.add(
        Container(
          margin: const EdgeInsets.fromLTRB(3, 3, 3, 3),
            child: InkWell(onTap:(){
              BlocProvider.of<AppAnimateBloc>(prefs.context()).add(AppAnimateEvent());
              _model.categoryFilter = e[1];
              getRooms();
            }, child: Row(children: [
          Text(e[2], style: const TextStyle(color: Colors.white))
        ])))
      );
    }
    BlocProvider.of<AppAnimateBloc>(prefs.context()).add(AppAnimateEventRaise());
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
        _model.entryDateTextController.text =
            DateFormat('dd/MM/yyyy').format(value);
        BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading('', '', {}, (p0, p1) => null, AppStateRoomsFilter()));
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
        _model.departureDateTextController.text =
            DateFormat('dd/MM/yyyy').format(value);
        BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading('', '', {}, (p0, p1) => null, AppStateRoomsFilter()));
      }
    });
  }

  void openRoom(dynamic e) {
    model.navigation.openRoom(e).then((value) {
      if (value ?? false){
        getRooms(); }
    });
  }

}
