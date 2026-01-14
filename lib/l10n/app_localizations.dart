import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hy.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hy'),
    Locale('ru')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @checkInternet.
  ///
  /// In en, this message translates to:
  /// **'Check internet connection and try again'**
  String get checkInternet;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized'**
  String get unauthorized;

  /// No description provided for @incorrectPin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect pin'**
  String get incorrectPin;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @showAll.
  ///
  /// In en, this message translates to:
  /// **'Show all'**
  String get showAll;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @goods.
  ///
  /// In en, this message translates to:
  /// **'Goods'**
  String get goods;

  /// No description provided for @amountTotal.
  ///
  /// In en, this message translates to:
  /// **'Total amounts'**
  String get amountTotal;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @card.
  ///
  /// In en, this message translates to:
  /// **'Card'**
  String get card;

  /// No description provided for @idram.
  ///
  /// In en, this message translates to:
  /// **'Idram'**
  String get idram;

  /// No description provided for @telcell.
  ///
  /// In en, this message translates to:
  /// **'Tellcell'**
  String get telcell;

  /// No description provided for @branch.
  ///
  /// In en, this message translates to:
  /// **'Branch'**
  String get branch;

  /// No description provided for @prepaid.
  ///
  /// In en, this message translates to:
  /// **'Prepaid'**
  String get prepaid;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @fiscal.
  ///
  /// In en, this message translates to:
  /// **'Fiscal'**
  String get fiscal;

  /// No description provided for @dayEnd.
  ///
  /// In en, this message translates to:
  /// **'Day end'**
  String get dayEnd;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @working.
  ///
  /// In en, this message translates to:
  /// **'Working'**
  String get working;

  /// No description provided for @coin.
  ///
  /// In en, this message translates to:
  /// **'Coin'**
  String get coin;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @spent.
  ///
  /// In en, this message translates to:
  /// **'Spent'**
  String get spent;

  /// No description provided for @cashbox.
  ///
  /// In en, this message translates to:
  /// **'Cashbox'**
  String get cashbox;

  /// No description provided for @cashRemain.
  ///
  /// In en, this message translates to:
  /// **'Cash remains'**
  String get cashRemain;

  /// No description provided for @coinRemain.
  ///
  /// In en, this message translates to:
  /// **'Coin remains'**
  String get coinRemain;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get bank;

  /// No description provided for @checkQty.
  ///
  /// In en, this message translates to:
  /// **'Check quantity'**
  String get checkQty;

  /// No description provided for @createDraftSale.
  ///
  /// In en, this message translates to:
  /// **'Create draft sale'**
  String get createDraftSale;

  /// No description provided for @checkStoreInput.
  ///
  /// In en, this message translates to:
  /// **'Check store input'**
  String get checkStoreInput;

  /// No description provided for @deliveryNote.
  ///
  /// In en, this message translates to:
  /// **'Delivery note'**
  String get deliveryNote;

  /// No description provided for @saveServerAddress.
  ///
  /// In en, this message translates to:
  /// **'Save server address'**
  String get saveServerAddress;

  /// No description provided for @useDemoServer.
  ///
  /// In en, this message translates to:
  /// **'Use demo server'**
  String get useDemoServer;

  /// No description provided for @newOrder.
  ///
  /// In en, this message translates to:
  /// **'New order'**
  String get newOrder;

  /// No description provided for @completedOrders.
  ///
  /// In en, this message translates to:
  /// **'Completed orders'**
  String get completedOrders;

  /// No description provided for @debts.
  ///
  /// In en, this message translates to:
  /// **'Debts'**
  String get debts;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @selectPartner.
  ///
  /// In en, this message translates to:
  /// **'Select partner'**
  String get selectPartner;

  /// No description provided for @emptyOrder.
  ///
  /// In en, this message translates to:
  /// **'Empty order'**
  String get emptyOrder;

  /// No description provided for @confirmCloseWindow.
  ///
  /// In en, this message translates to:
  /// **'Confirm to close window'**
  String get confirmCloseWindow;

  /// No description provided for @removeRow.
  ///
  /// In en, this message translates to:
  /// **'Remove row'**
  String get removeRow;

  /// No description provided for @confirmRemoveGoods.
  ///
  /// In en, this message translates to:
  /// **'Confirm to remove goods'**
  String get confirmRemoveGoods;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @returnGoods.
  ///
  /// In en, this message translates to:
  /// **'Return of goods'**
  String get returnGoods;

  /// No description provided for @retailPrice.
  ///
  /// In en, this message translates to:
  /// **'Retail price'**
  String get retailPrice;

  /// No description provided for @retailPriceDiscounted.
  ///
  /// In en, this message translates to:
  /// **'Retail price, discounted'**
  String get retailPriceDiscounted;

  /// No description provided for @whosalePrice.
  ///
  /// In en, this message translates to:
  /// **'Whosale price'**
  String get whosalePrice;

  /// No description provided for @whosalePriceDiscounted.
  ///
  /// In en, this message translates to:
  /// **'Whosale price, discounted'**
  String get whosalePriceDiscounted;

  /// No description provided for @loadingError.
  ///
  /// In en, this message translates to:
  /// **'Loading error'**
  String get loadingError;

  /// No description provided for @stockQty.
  ///
  /// In en, this message translates to:
  /// **'Stock qty'**
  String get stockQty;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'Comment'**
  String get comment;

  /// No description provided for @deliveryDate.
  ///
  /// In en, this message translates to:
  /// **'Date of delivery'**
  String get deliveryDate;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @confirmRemoveComment.
  ///
  /// In en, this message translates to:
  /// **'Confirm comment removal'**
  String get confirmRemoveComment;

  /// No description provided for @confirmRemoveOrder.
  ///
  /// In en, this message translates to:
  /// **'Confirm order removal'**
  String get confirmRemoveOrder;

  /// No description provided for @selectRange.
  ///
  /// In en, this message translates to:
  /// **'Select range'**
  String get selectRange;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @dateStart.
  ///
  /// In en, this message translates to:
  /// **'Date start'**
  String get dateStart;

  /// No description provided for @dateEnd.
  ///
  /// In en, this message translates to:
  /// **'Date end'**
  String get dateEnd;

  /// No description provided for @choosePayment.
  ///
  /// In en, this message translates to:
  /// **'Choose payment'**
  String get choosePayment;

  /// No description provided for @paymentType.
  ///
  /// In en, this message translates to:
  /// **'Payment type'**
  String get paymentType;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @partners.
  ///
  /// In en, this message translates to:
  /// **'Partners'**
  String get partners;

  /// No description provided for @tin.
  ///
  /// In en, this message translates to:
  /// **'Taxpayer number'**
  String get tin;

  /// No description provided for @newPartner.
  ///
  /// In en, this message translates to:
  /// **'New partner'**
  String get newPartner;

  /// No description provided for @taxpayerName.
  ///
  /// In en, this message translates to:
  /// **'Taxpayer name'**
  String get taxpayerName;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @wrongTin.
  ///
  /// In en, this message translates to:
  /// **'Wrong taxpayer number'**
  String get wrongTin;

  /// No description provided for @clearOrder.
  ///
  /// In en, this message translates to:
  /// **'Clear order'**
  String get clearOrder;

  /// No description provided for @barcodeNotExistsInOrder.
  ///
  /// In en, this message translates to:
  /// **'Barcode not exists in the order'**
  String get barcodeNotExistsInOrder;

  /// No description provided for @setOk.
  ///
  /// In en, this message translates to:
  /// **'Set ok'**
  String get setOk;

  /// No description provided for @setNotOk.
  ///
  /// In en, this message translates to:
  /// **'Set not ok'**
  String get setNotOk;

  /// No description provided for @debug.
  ///
  /// In en, this message translates to:
  /// **'Debug'**
  String get debug;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @debtAsOf.
  ///
  /// In en, this message translates to:
  /// **'Debt as of'**
  String get debtAsOf;

  /// No description provided for @currentDebt.
  ///
  /// In en, this message translates to:
  /// **'Current debt'**
  String get currentDebt;

  /// No description provided for @doNotUseSSL.
  ///
  /// In en, this message translates to:
  /// **'Do not use SSL'**
  String get doNotUseSSL;

  /// No description provided for @checkAllQty.
  ///
  /// In en, this message translates to:
  /// **'Check all qty'**
  String get checkAllQty;

  /// No description provided for @partnerPaymentModeUndefined.
  ///
  /// In en, this message translates to:
  /// **'The payment mode of partner undefined'**
  String get partnerPaymentModeUndefined;

  /// No description provided for @loadingGoods.
  ///
  /// In en, this message translates to:
  /// **'Loading goods'**
  String get loadingGoods;

  /// No description provided for @goodsName.
  ///
  /// In en, this message translates to:
  /// **'Goods name'**
  String get goodsName;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @loaded.
  ///
  /// In en, this message translates to:
  /// **'Loaded'**
  String get loaded;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @deleting.
  ///
  /// In en, this message translates to:
  /// **'Deleting'**
  String get deleting;

  /// No description provided for @removalConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Confirm to remove record'**
  String get removalConfirmation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hy', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hy':
      return AppLocalizationsHy();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
