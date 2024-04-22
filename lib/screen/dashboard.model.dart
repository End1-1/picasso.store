part of 'dashboard.dart';

class AppStateDashboard extends AppStateFinished{}

extension WMEDashboard on WMDashboard {
  void getDashboard() {
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        model.tr('Wait, please'), 'engine/dashboard.php', {}, (e, d) {}, AppStateDashboard()));
  }
}