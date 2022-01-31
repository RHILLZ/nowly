import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:nowly/Configs/configs.dart';
import 'package:nowly/Controllers/controller_exporter.dart';
import 'package:nowly/Widgets/widget_exporter.dart';

class UserAddCardScreen extends StatelessWidget {
  UserAddCardScreen({Key? key}) : super(key: key);

  static const routeName = '/userAddCardScreen';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _expireTEC = MaskedTextController(mask: '00/0000');
  final _ccvTEC = MaskedTextController(mask: '000');
  final _cardNumTEC = MaskedTextController(mask: '0000 0000 0000 0000');
  final TextEditingController _country = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _city = TextEditingController();

  final StripeController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('ADD credit/debit CARD'.toUpperCase()),
            centerTitle: true,
          ),
          bottomNavigationBar: BottomAppBar(
            child: Padding(
              padding: EdgeInsets.only(
                  top: kScreenPadding2,
                  bottom: MediaQuery.of(context).viewInsets.bottom +
                      kScreenPadding2,
                  left: kScreenPadding,
                  right: kScreenPadding),
              child: MainButton(
                onTap: () async {
                  _controller.cardAddressCity = _city.text;
                  _controller.cardAddressState = _state.text;

                  if (_formKey.currentState!.validate()) {
                    if (Get.put(UserController()).user.stripeCustomerId ==
                        null) {
                      await _controller.initStripeCustomerFlow();

                      Get.back();
                    } else {
                      await _controller.addNewPaymentMethod();

                      Get.back();
                    }
                  }

                  // _controller.getAccountDetails();
                },
                title: _controller.last4.isEmpty
                    ? 'CONFIRM'
                    : 'create Payment Method'.toUpperCase(),
              ),
            ),
          ),
          body: _controller.isProcessing
              ? _controller.loadScreen()
              : SafeArea(
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: UIParameters.screenPadding,
                      child: SeperatedColumn(
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: kContentGap,
                          );
                        },
                        children: <Widget>[
                          TextFormField(
                            controller: _cardNumTEC,
                            keyboardType: TextInputType.number,
                            onChanged: (v) => _controller.cardNum = v,
                            validator: (value) {
                              if (value == null ||
                                  value.replaceAll(' ', '').length != 16) {
                                return 'Please enter card number';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Card number',
                                hintText: 'XXXX XXXX XXXX XXXX'),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: TextFormField(
                                  controller: _expireTEC,
                                  onChanged: (v) {
                                    var month = int.parse(
                                        _expireTEC.text.split('/')[0]);
                                    var year = int.parse(
                                        _expireTEC.text.split('/')[1]);
                                    _controller.cardExpMonth = month;
                                    _controller.cardExpYear = year;
                                  },
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.length != 7) {
                                      return 'Expiration date is not valid';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'Expiration',
                                      hintText: 'MM/YYYY'),
                                ),
                              ),
                              const SizedBox(
                                width: kContentGap,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextFormField(
                                  controller: _ccvTEC,
                                  onChanged: (v) => _controller.cardCvc = v,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.length != 3) {
                                      return 'CVC not valid';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      labelText: 'CVC', hintText: 'XXX'),
                                ),
                              )
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 5),
                            child: Text('BILLING ADDRESS'),
                          ),
                          TextFormField(
                            onChanged: (v) => _controller.cardAddressLine1 = v,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter street name';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                labelText: 'Address Line 1'),
                          ),
                          TextFormField(
                            onChanged: (v) => _controller.cardAddressLine2 = v,
                            decoration: const InputDecoration(
                                labelText:
                                    'Address Line 2 (APT, Suite, Floor)'),
                          ),
                          CountryStateCityPicker(
                              country: _country, state: _state, city: _city),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onChanged: (v) => _controller.cardAddressZip = v,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'enter zip code';
                              }
                              return null;
                            },
                            decoration:
                                const InputDecoration(labelText: 'Zip code'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ));
  }
}
