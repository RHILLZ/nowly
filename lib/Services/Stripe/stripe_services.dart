import 'dart:convert';

import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Utils/logger.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeServices extends GetConnect {
  Future createStripeCustomer(UserModel user) async {
    String url = "http://18.118.101.152/createStripeCustomerAccount";
    final fullName = '${user.firstName} ${user.lastName}';

    final req = await httpClient.post(url,
        body: jsonEncode({'name': fullName, 'email': user.email}));
    AppLogger.i(req.body);
    final account = req.body as Map<String, dynamic>;
    return account['accountId'];
  }

  Future createStripePaymentMethod(CreditCard card) async {
    String url = "http://18.118.101.152/createStripePaymentMethod";

    final req = await httpClient.post(url,
        body: jsonEncode({
          'number': card.number,
          'exp_month': card.expMonth,
          'exp_year': card.expYear,
          'cvc': card.cvc,
          'line1': card.addressLine1,
          'line2': card.addressLine2,
          'city': card.addressCity,
          'postal_code': card.addressZip,
          'state': card.addressState
        }));

    final paymentMethod = req.body as Map<String, dynamic>;

    return paymentMethod['paymentId'];
  }

  Future linkStripePaymentMethodToUser(
      String customerID, String paymentMethodID) async {
    String url = "http://18.118.101.152/linkStripePaymentMethodToCustomer";
    final req = await httpClient.post(url,
        body: jsonEncode(
            {'customer': customerID, 'paymentMethod': paymentMethodID}));

    final data = req.body as Map<String, dynamic>;

    return data;
  }

  Future unlinkStripePaymentMethodFromUser(String pmID) async {
    String url = "http://18.118.101.152/unlinkPaymentMethod/$pmID";
    final response = await httpClient.get(url);
    final result = response.body as Map<String, dynamic>;
    return result;
  }

  Future getStripeCustomerPaymentMethod(String paymentID) async {
    String url =
        "http://18.118.101.152/getStripeCustomerPaymentMethod/$paymentID";

    final response = await httpClient.get(url);
    final account = response.body as Map<String, dynamic>;
    AppLogger.i('FROM SEVICE: ${account['paymentMethod']}');
    return account['paymentMethod'];
  }

  Future createPaymentIntent(String customerID, int amount,
      String paymentMethodID, String description, String connectID) async {
    String url = "http://18.118.101.152/createPaymentIntent";

    final req = await httpClient.post(url,
        body: jsonEncode({
          'customerId': customerID,
          'amount': amount,
          'paymentMethodId': paymentMethodID,
          'description': description,
          'connectId': connectID
        }));

    final paymentIntent = req.body as Map<String, dynamic>;
    return paymentIntent['paymentIntent'];
  }

  // Future capturePaymentIntent(
  //     String paymentIntentID, String connectID, int amount) async {
  //   String url = "http://192.168.1.29:5888/capturePaymentIntent";

  //   await httpClient.post(url,
  //       body: jsonEncode({
  //         'paymentIntentID': paymentIntentID,
  //         'connectID': connectID,
  //         'amount': amount
  //       }));

  //   final response = await httpClient.get(url);
  //   final reciept = response.body as Map<String, dynamic>;

  //   return reciept;
  // }

  Future getPaymentMethods(String customerID) async {
    String url = "http://18.118.101.152/getPaymentMethods/$customerID";

    final response = await httpClient.get(url);
    final paymentMethods = response.body as Map<String, dynamic>;

    return paymentMethods['list']['data'];
  }

  Future deleteBankAccountFromConnect(
      String connectID, String bankAccountId) async {
    String url =
        "http://18.118.101.152/deleteBankAccountFromConnectAccount/$connectID/$bankAccountId";

    final response = await httpClient.get(url);
    final result = response.body as Map<String, dynamic>;
    return result;
  }
}
