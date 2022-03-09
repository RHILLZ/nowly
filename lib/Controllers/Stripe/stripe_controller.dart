import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Services/service_exporter.dart';
import 'package:nowly/Utils/app_logger.dart';
import 'package:nowly/Widgets/Dialogs/dialogs.dart';
import 'package:sizer/sizer.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../controller_exporter.dart';

class StripeController extends GetxController {
  //PAYMENT VARIABLES//////////////////////////////////////////////
  final _cardNum = ''.obs;
  final _cardExpMonth = 0.obs;
  final _cardExpYear = 0.obs;
  final _cardCvc = ''.obs;
  final _cardAddressLine1 = ''.obs;
  final _cardAddressLine2 = ''.obs;
  final _cardAddressCity = ''.obs;
  final _cardAddressState = ''.obs;
  final _cardAddressZip = ''.obs;
  final _last4 = ''.obs;
  final _cardBrand = ''.obs;
  final _user = Get.find<UserController>().user;
  final _isProcessing = false.obs;
  final _isGettingAccount = false.obs;
  final _loadMessage = ''.obs;
  final _paymentMethodID = ''.obs;
  final _stripeCustomerID = ''.obs;
  final _paymentIntentID = ''.obs;
  final _expM = 0.obs;
  final _expY = 0.obs;
  final _activePaymentMethod = UserPaymentMethodModel(
    id: '',
    last4: '',
    exp: '',
    brand: '',
  ).obs;
  final _paymentMethods = <UserPaymentMethodModel>[].obs;

//GETTERS AND SETTERS//////////////////////////////////////////////////////////
  set cardNum(value) => _cardNum.value = value;
  set cardExpMonth(value) => _cardExpMonth.value = value;
  set cardExpYear(value) => _cardExpYear.value = value;
  set cardCvc(value) => _cardCvc.value = value;
  set cardAddressLine1(value) => _cardAddressLine1.value = value;
  set cardAddressLine2(value) => _cardAddressLine2.value = value;
  set cardAddressCity(value) => _cardAddressCity.value = value;
  set cardAddressState(value) => _cardAddressState.value = value;
  set cardAddressZip(value) => _cardAddressZip.value = value;
  set activePaymentMethod(value) => _activePaymentMethod.value = value;

  get cardNum => _cardNum.value;
  get cardExpMonth => _cardExpMonth.value;
  get cardExpYear => _cardExpYear.value;
  get cardCvc => _cardCvc.value;
  get cardAddressLine1 => _cardAddressLine1.value;
  get cardAddressLine2 => _cardAddressLine2.value;
  get cardAddressCity => _cardAddressCity.value;
  get cardAddressState => _cardAddressState.value;
  get cardAddressZip => _cardAddressZip.value;
  get isProcessing => _isProcessing.value;
  get last4 => _last4.value;
  get cardBrand => _cardBrand.value;
  get loadMessage => _loadMessage.value;
  get paymentMethodID => _paymentMethodID.value;
  get isGettingAccount => _isGettingAccount.value;
  get userName => '${_user.firstName} ${_user.lastName}';
  get exp => '$_expM/$_expY';
  get activePaymentMethod => _activePaymentMethod.value;
  get paymentMethods => _paymentMethods;

//INIT STRIPE CUSTOMER FLOW////////////////////////////////////////////////////
  initStripeCustomerFlow() async {
    _isProcessing.toggle();
    _loadMessage.value = 'Connecting with stripe...';
    final customerId = await StripeServices().createStripeCustomer(_user);
    _stripeCustomerID.value = customerId;
    _loadMessage.value = 'Creating customer account...';
    final result =
        await FirebaseFutures().setUserStripeCustomerId(_user.id, customerId);
    if (result) {
      _loadMessage.value = 'Creating payment method...';
      final paymentMethodCreated = await createPaymentMethod();
      if (paymentMethodCreated) {
        _loadMessage.value = 'Linking payment method to account...';
        final linkedAccount = await _linkStripePaymentMethod();
        if (linkedAccount) {
          _loadMessage.value = 'Getting account details...';
          await getAccountDetails();
          _isProcessing.toggle();
        } else {
          _isProcessing.toggle();
          Get.snackbar('Something went wrong linking pay method.',
              'Please try again later.',
              snackPosition: SnackPosition.BOTTOM);
          return;
        }
      } else {
        _isProcessing.toggle();
        Get.snackbar('Something went wrong creating pay method.',
            'Please try again later.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
    } else {
      _isProcessing.toggle();
      Get.snackbar('Something went wrong', 'Please try again later.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
  }

////////////////////////////////////////////////////////////////////////////
  ///
  loadScreen() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            _loadMessage.value,
            style: k16BoldTS,
            textAlign: TextAlign.center,
          )
        ],
      );

//CREATE A PAYMENT METHOD ON STRIPE/////////////////////////////////////////////
  createPaymentMethod() async {
    CreditCard card = CreditCard();
    card.number = _cardNum.value;
    card.expMonth = _cardExpMonth.value;
    card.expYear = _cardExpYear.value;
    card.cvc = _cardCvc.value;
    card.addressLine1 = _cardAddressLine1.value;
    card.addressLine2 = _cardAddressLine2.value;
    card.addressCity = _cardAddressCity.value;
    card.addressState = _cardAddressState.value;
    card.addressZip = _cardAddressZip.value;
    final payMethod = await StripeServices().createStripePaymentMethod(card);
    _paymentMethodID.value = payMethod;
    final result = await FirebaseFutures()
        .setUserActiveStripePaymentMethodId(_user.id, payMethod);

    return result;
  }

////////////////////////////////////////////////////////////////////////////////
  ///LINK PAYMENT METHOD TO STRIPE ACCOUNT////////////////////////////////////////
  _linkStripePaymentMethod() async {
    bool _linkedAccount = false;
    final customerID = _user.stripeCustomerId ?? _stripeCustomerID.value;
    final paymentMethodID = _paymentMethodID.value;

    final result = await StripeServices()
        .linkStripePaymentMethodToUser(customerID, paymentMethodID);
    if (result != null) {
      _linkedAccount = true;
      return _linkedAccount;
    }
  }

///////////////////////////////////////////////////////////////////////////////
  addNewPaymentMethod() async {
    _isProcessing.toggle();
    _loadMessage.value = 'Creating payment method with stripe...';
    final result = await createPaymentMethod();
    if (result) {
      _loadMessage.value = 'Linking new payment method to account...';
      final linkedAcc = await _linkStripePaymentMethod();
      if (linkedAcc) {
        await setActivePaymentId(_paymentMethodID.value);
        _isProcessing.toggle();
        _loadMessage.value = '';
        getPaymentMethods();
        Get.back();
        Get.snackbar('Pay method added successfully', 'Thank you.');
        return;
      } else {
        _isProcessing.toggle();
        _loadMessage.value = '';
        return;
      }
    }
  }

//GET STRIPE ACCOUNT DETAILS////////////////////////////////////////////////////
  getAccountDetails() async {
    _isGettingAccount.toggle();
    _loadMessage.value = 'Getting account details...';
    final paymentMethodID =
        _user.activePaymentMethodId ?? _paymentMethodID.value;
    AppLogger.info('PMID: $paymentMethodID');
    final paymentMethod =
        await StripeServices().getStripeCustomerPaymentMethod(paymentMethodID);

    if (paymentMethod != null) {
      _last4.value = paymentMethod['card']['last4'];
      _cardBrand.value = paymentMethod['card']['brand'];
      _expY.value = paymentMethod['card']['exp_year'];
      _expM.value = paymentMethod['card']['exp_month'];
      var _exp = '${_expM.value}/${_expY.value}';
      activePaymentMethod = UserPaymentMethodModel(
          id: paymentMethodID,
          last4: _last4.value,
          exp: _exp,
          brand: _cardBrand.value);
      _isGettingAccount.toggle();
      _loadMessage.value = '';
      return;
    } else {
      _isGettingAccount.toggle();
      Get.snackbar('Could not get account deatails!', 'Please Try Again.');
      return;
    }
  }

///////////////////////////////////////////////////////////////////////////////
//SET THE ACTIVE PAYMENT METHOD///////////////////////////////////////////////
  setActivePaymentId(activePaymentId) async {
    await FirebaseFutures()
        .setUserActiveStripePaymentMethodId(_user.id, activePaymentId);
  }

/////////////////////////////////////////////////////////////////////////////
  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    shouldGetStripeAccount();
    _isProcessing.value = false;
  }

//CHECK IF THE USER SHOULD FETCH THE STRIPE ACCOUNT//////////////////////////////
  shouldGetStripeAccount() {
    if (_user.stripeCustomerId != null &&
        _user.stripeCustomerId.isNotEmpty &&
        _activePaymentMethod.value.last4 != '') {
      getAccountDetails();
      getPaymentMethods();
    }
  }

//CREATE A PAYMENT INTENT /////////////////////////////////////////////////////
  createPaymentIntent(int amount, String desc, String connectId) async {
    _isProcessing.toggle();
    _loadMessage.value = 'Initiating payment intent...';
    final paymentMethodID = activePaymentMethod.id;
    final customerID = _user.stripeCustomerId;
    final description = desc;
    final paymentIntent = await StripeServices().createPaymentIntent(
        customerID, amount, paymentMethodID, description, connectId);
    if (paymentIntent != null) {
      _isProcessing.toggle();
      _loadMessage.value = '';
      _paymentIntentID.value = paymentIntent['id'];
      Get.snackbar('Successfully proccessed payment.', 'Thank you.');
    } else {
      _isProcessing.toggle();
      Get.snackbar('Something went wrong', 'Please try again soon.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // capturePaymentIntent(String connectID, int amount) async {
  //   _isProcessing.toggle();
  //   _loadMessage.value = 'capturing payment...';
  //   final paymentIntentID = _paymentIntentID.value;
  //   final reciept = await StripeServices()
  //       .capturePaymentIntent(paymentIntentID, connectID, amount);

  //   if (reciept != null) {
  //     _isProcessing.toggle();
  //     Get.snackbar('Successfully proccessed payment.', 'Thank you.');
  //   } else {
  //     _isProcessing.toggle();
  //   }
  // }
  deletePaymentMethodDialog(context, pmID) =>
      Dialogs().deletePayMethod(context, pmID);
  removePaymentMethod(pmID) async {
    final result =
        await StripeServices().unlinkStripePaymentMethodFromUser(pmID);
    if (result != null) {
      Get.back();
      getPaymentMethods();
    }
  }

  getPaymentMethods() async {
    List pMethods =
        await StripeServices().getPaymentMethods(_user.stripeCustomerId);
    // pMethods.forEach((pm) => print(pm));
    List<UserPaymentMethodModel> payMethods = pMethods.map((pm) {
      final last4 = pm['card']['last4'];
      final exp = '${pm["card"]["exp_month"]}/${pm["card"]["exp_year"]}';
      final brand = pm['card']['brand'];
      final id = pm['id'];
      return UserPaymentMethodModel(
          id: id, last4: last4, exp: exp, brand: brand);
    }).toList();
    _paymentMethods.value = payMethods;
  }

  addNewPaymentWarning() => Get.snackbar('Please add new card.',
      'Card cant be removed until new card is added. Thank you.',
      snackPosition: SnackPosition.BOTTOM);
  selectOtherCardWarning() => Get.snackbar('Please choose another pay method.',
      'Must choose a different card before deleting this. Thank you.');
}
