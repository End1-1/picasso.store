part of 'dashboard.dart';

class DashboardModel {
  final checkin = [];
  final inhouse = [];
  final checkout = [];
}

class AppStateDashboard extends AppStateFinished{}

extension WMEDashboard on WMDashboard {
  void getDashboard() {
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        model.tr('Wait, please'), 'engine/dashboard.php', {'mode':1}, (e, d) {
          if (e) {
            return;
          }
          _model.checkin.clear();
          _model.checkin.addAll(d['checkin']);
          _model.inhouse.clear();
          _model.inhouse.addAll(d['inhouse']);
          _model.checkout.clear();
          _model.checkout.addAll(d['checkout']);
          prefs.setString('workingday', DateFormat('yyyy-MM-dd').format(DateFormat('dd/MM/yyyy').parse(d['workingday'])));
    }, AppStateDashboard()));
  }
}