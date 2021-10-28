


import 'dart:convert';

import 'package:get/get.dart';
import 'package:nowly/Models/models_exporter.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripeServices extends GetConnect {
  // Future getStripeConnectLink() async {
  //   String url = "http://192.168.1.29:5888/stripeConnectLink";

  //   var response = await httpClient.get(url);
  //   final data = response.body as Map<String, dynamic>;

  //   print('FROM PYTHON $data');

  //   return data;
  // }

  // Future getStripeUpdateConnectLink(String connectId) async {
  //   String url = "http://192.168.1.29:5888/stripeUpdateConnectLink/$connectId";

  //   var response = await httpClient.get(url);
  //   final data = response.body as Map<String, dynamic>;

  //   return data['link'];
  // }

  // Future getStripeAccountInfo(String accountId) async {
  //   String url = "http://192.168.1.29:5888/stripeAccountInfo/$accountId";

  //   final response = await httpClient.get(url);
  //   final accountInfo = response.body as Map<String, dynamic>;

  //   return accountInfo;
  // }

  // Future getStripeBalance(String accountId) async {
  //   String url =
  //       "http://192.168.1.29:5888/getConnectedAccountBalance/$accountId";

  //   final response = await httpClient.get(url);
  //   final balance = response.body as Map<String, dynamic>;

  //   return balance['Balance'];
  // }

  // Future getStripeBankToken(BankAccount account) async {
  //   String url = "http://192.168.1.29:5888/stripeBankToken/";

  //   await httpClient.post(url,
  //       body: jsonEncode({
  //         'accNum': account.accountNumber,
  //         'routeNum': account.routingNumber,
  //         'bankName': account.bankName
  //       }));

  //   final response = await httpClient.get(url);
  //   final token = response.body as Map<String, dynamic>;

  //   print(token['token']);
  //   return token['token'];
  // }

  // Future createExternalStripeAccount(String accountId, String token) async {
  //   String url = "http://192.168.1.29:5888/stripeCreateExternalAccount/";

  //   await httpClient.post(url,
  //       body: jsonEncode({
  //         'accountId': accountId,
  //         'token': token,
  //       }));

  //   final response = await httpClient.get(url);
  //   final data = response.body as Map<String, dynamic>;

  //   print(data);
  // }

  Future createStripeCustomer(UserModel user) async {
    String url = "http://192.168.1.29:5888/createStripeCustomerAccount/";
    final fullName = '${user.firstName} ${user.lastName}';

    await httpClient.post(url,
        body: jsonEncode({'name': fullName, 'email': user.email}));

    final response = await httpClient.get(url);
    final account = response.body as Map<String, dynamic>;

    return account['accountID'];
  }

  Future createStripePaymentMethod(CreditCard card) async {
    String url = "http://192.168.1.29:5888/createStripePaymentMethod/";

    await httpClient.post(url,
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
    final response = await httpClient.get(url);
    final paymentMethod = response.body as Map<String, dynamic>;

    return paymentMethod['pmID'];
  }

  Future linkStripePaymentMethodToUser(
      String customerID, String paymentMethodID) async {
    String url = "http://192.168.1.29:5888/linkStripePaymentMethodToCustomer/";
    await httpClient.post(url,
        body: jsonEncode(
            {'customer': customerID, 'paymentMethod': paymentMethodID}));

    final response = await httpClient.get(url);
    final data = response.body as Map<String, dynamic>;

    return data;
  }

  Future unlinkStripePaymentMethodFromUser(String pmID) async {
    String url = "http://192.168.1.29:5888/unlinkPaymentMethod/$pmID";
    final response = await httpClient.get(url);
    final result = response.body as Map<String, dynamic>;
    return result;
  }

  Future getStripeCustomerPaymentMethod(String customerID) async {
    String url =
        "http://192.168.1.29:5888/getStripeCustomerPaymentMethod/$customerID";

    final response = await httpClient.get(url);
    final account = response.body as Map<String, dynamic>;

    return account;
  }

  Future createPaymentIntent(String customerID, int amount,
      String paymentMethodID, String description, String connectID) async {
    String url = "http://192.168.1.29:5888/createPaymentIntent";

    await httpClient.post(url,
        body: jsonEncode({
          'customerId': customerID,
          'amount': amount,
          'paymentMethodId': paymentMethodID,
          'description': description,
          'connectId': connectID
        }));

    final response = await httpClient.get(url);
    final paymentIntent = response.body as Map<String, dynamic>;

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
    String url = "http://192.168.1.29:5888/getPaymentMethods/$customerID";

    final response = await httpClient.get(url);
    final paymentMethods = response.body as Map<String, dynamic>;

    return paymentMethods['list']['data'];
  }

  Future deleteBankAccountFromConnect(
      String connectID, String bankAccountId) async {
    String url =
        "http://192.168.1.29:5888/deleteBankAccountFromConnectAccount/$connectID/$bankAccountId";

    final response = await httpClient.get(url);
    final result = response.body as Map<String, dynamic>;
    return result;
  }
}
