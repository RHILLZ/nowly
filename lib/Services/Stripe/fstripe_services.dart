import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FStripeService extends GetConnect {
  final base_url = "http://10.0.2.2:4242";

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('$base_url/payment-sheet');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'a': 'a',
      }),);
    final body = json.decode(response.body);
    
    if (body['error'] != null) {
      throw Exception('Error code: ${body['error']}');
    }

    return body;
  }

  Future<void> initPayment() async {
    try{
      final data = await _createTestPaymentSheet();

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
          style: ThemeMode.dark,
          merchantCountryCode: 'DE',
        ),
      );

      await Stripe.instance.presentPaymentSheet();
    } catch (err) {
      rethrow;
    }
  }
}