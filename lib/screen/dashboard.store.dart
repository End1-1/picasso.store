part of 'dashboard.dart';

extension DashboardStore on WMDashboard {
  List<Widget> menuWidgetsStore() {
    return [
      Styling.menuButton(model.navigation.checkQuantity, 'available',
          model.tr('Check availability')),
      Styling.menuButton(model.navigation.checkStoreInput, 'checkstoreinput',
          model.tr('Check store input')),
      Styling.menuButton(
          model.navigation.settings, 'config', model.tr('Configuration')),
      Styling.menuButton(model.navigation.logout, 'logout', model.tr('Logout')),
    ];
  }
}