part of 'model.dart';

extension CheckStoreInputModel on WMModel {
  get a => '';

  void showAllCheckStoreInput() {
    navigation.hideMenu();
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        'Querying',
        'engine/worker/store-input-check-barcode.php',
        {'store': Prefs.config['store'] ?? 0, 'mode': 2},
        (e, d) => null));
  }

  void checkedStoreInput(String s, dynamic d) {
    final a = <String, dynamic>{};
    a.addAll(d);
    BlocProvider.of<AppBloc>(prefs.context()).add(AppEventLoading(
        'Querying',
        'engine/worker/store-input-check-barcode.php',
        {'store': Prefs.config['store'] ?? 0, 'id': s, 'mode': 3},
        (e, d) {
          if (!e) {
            for (int i = 0;i < a['result'].length; i++) {
              final e = a['result'][i];
              if (e['f_id'] == s){
                e['f_acc'] = d['acc'];
                a['result'][i] = e;
                BlocProvider.of<AppBloc>(prefs.context()).emit(AppStateFinished(a));
                return;
              }
            }
          }
        }));
  }
}
