import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:nowly/Utils/env.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AndroidStripeController extends GetxController {
  final base_url = 'http://10.0.2.2:4242';

  Future<Map<String, dynamic>> createPaymentIntent() async {
    final url = Uri.parse('$base_url/payment-sheet');
    final response = await http.post(url);
    final body = json.decode(response.body);
    if (body['error'] != null) {
      throw Exception(body['error']);
    }
    return body;
  }

  Future<void> initPaymentSheet() async {
    try {
      // 1. create payment intent on the server
      final data = await createPaymentIntent();

      // 2. initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          // Enable custom flow
          customFlow: true,
          // Main params
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          // Customer keys
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          // Extra options
          testEnv: true,
          applePay: true,
          googlePay: true,
        ),
      );
    } catch (e) {
      Get.snackbar('Ooops!', 'Error: $e');
        // SnackBar(content: Text('Error: $e')),
      rethrow;
    }
  }
}
