import 'dart:convert';

import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:nowly/Utils/env.dart';
import 'package:nowly/Utils/app_logger.dart';

class StripeServices extends GetConnect {
  final String baseURL = Env.apiBaseUrl;
  Future createStripeCustomer(UserModel user) async {
    String url = "$baseURL/createStripeCustomerAccount";
    final fullName = '${user.firstName} ${user.lastName}';
    AppLogger.info("URL: $baseURL");
    final req = await httpClient.post(url,
        body: jsonEncode({'name': fullName, 'email': user.email}));
    AppLogger.info(req.body);
    final account = req.body as Map<String, dynamic>;
    return account['accountId'];
  }

  // Future createStripePaymentMethod(CreditCard card) async {
  //   String url = "$baseURL/createStripePaymentMethod";

  //   final req = await httpClient.post(url,
  //       body: jsonEncode({
  //         'number': card.number,
  //         'exp_month': card.expMonth,
  //         'exp_year': card.expYear,
  //         'cvc': card.cvc,
  //         'line1': card.addressLine1,
  //         'line2': card.addressLine2,
  //         'city': card.addressCity,
  //         'postal_code': card.addressZip,
  //         'state': card.addressState
  //       }));

  //   final paymentMethod = req.body as Map<String, dynamic>;

  //   return paymentMethod['paymentId'];
  // }

  Future linkStripePaymentMethodToUser(
      String customerID, String paymentMethodID) async {
    String url = "$baseURL/linkStripePaymentMethodToCustomer";
    final req = await httpClient.post(url,
        body: jsonEncode(
            {'customer': customerID, 'paymentMethod': paymentMethodID}));

    final data = req.body as Map<String, dynamic>;

    return data;
  }

  Future unlinkStripePaymentMethodFromUser(String pmID) async {
    String url = "$baseURL/unlinkPaymentMethod/$pmID";
    final response = await httpClient.get(url);
    final result = response.body as Map<String, dynamic>;
    return result;
  }

  Future getStripeCustomerPaymentMethod(String paymentID) async {
    String url = "$baseURL/getStripeCustomerPaymentMethod/$paymentID";

    final response = await httpClient.get(url);
    final account = response.body as Map<String, dynamic>;
    AppLogger.info('FROM SEVICE: ${account['paymentMethod']}');
    return account['paymentMethod'];
  }

  Future createPaymentIntent(String customerID, int amount,
      String paymentMethodID, String description, String connectID) async {
    String url = "$baseURL/createPaymentIntent";

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
    String url = "$baseURL/getPaymentMethods/$customerID";

    final response = await httpClient.get(url);
    final paymentMethods = response.body as Map<String, dynamic>;

    return paymentMethods['list']['data'];
  }
}
