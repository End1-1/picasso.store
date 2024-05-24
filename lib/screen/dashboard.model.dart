part of 'dashboard.dart';

class DashboardModel {
  final checkin = [];
  final inhouse = [];
  final checkout = [];
}

class AppStateDashboard extends AppStateFinished {
  AppStateDashboard({required super.data});
}

extension WMEDashboard on WMDashboard {

  void getDashboard() {
    switch (Prefs.config['dashboard'] ?? '') {
      case 'shop':
        return;
      case 'store':
        return;
      case 'hotel':
        return getDashboardHotel();
      default:
        return;
    }
  }

  void getDashboardHotel() {
    BlocProvider.of<AppBloc>(prefs.context())
        .add(AppEventLoading(model.tr('Wait, please'), 'engine/dashboard.php', {
      'mode': 1,
      'date': prefs.string('workingday').isEmpty
          ? DateFormat('yyyy-MM-dd').format(DateTime.now())
          : prefs.string('workingday')
    }, (e, d) {
      if (e) {
        return;
      }
      _model.checkin.clear();
      _model.checkin.addAll(d['checkin']);
      _model.inhouse.clear();
      _model.inhouse.addAll(d['inhouse']);
      _model.checkout.clear();
      _model.checkout.addAll(d['checkout']);
      prefs.setString(
          'workingday',
          DateFormat('yyyy-MM-dd')
              .format(DateFormat('dd/MM/yyyy').parse(d['workingday'])));
    }, AppStateDashboard(data: _model)));
  }
}
