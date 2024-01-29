import 'package:auction_fire/widgets/bidbutton.dart';
import 'package:flutter/material.dart';
import 'package:paymob_pakistan/paymob_payment.dart';

class PaymentView extends StatefulWidget {
  final String price;
  const PaymentView({super.key, required this.price});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymobResponse? response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFD45A2D),
        title: const Text(
          'Pay for Product',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xFFD45A2D),
            Color(0xFFBD861C),
            Color.fromARGB(67, 0, 130, 181)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Image.network('https://paymob.com/images/logoC.png'),
                // const SizedBox(height: 24),
                if (response != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Success ==> ${response?.success}"),
                      const SizedBox(height: 8),
                      Text("Transaction ID ==> ${response?.transactionID}"),
                      const SizedBox(height: 8),
                      Text("Message ==> ${response?.message}"),
                      const SizedBox(height: 8),
                      Text("Response Code ==> ${response?.responseCode}"),
                      const SizedBox(height: 16),
                    ],
                  ),
                Column(
                  children: [
                    // ElevatedButton(
                    //   child: const Text('Pay with Jazzcash'),
                    //   onPressed: () => PaymobPakistan.instance.pay(
                    //     context: context,
                    //     currency: "PKR",
                    //     amountInCents: "100",
                    //     paymentType: PaymentType.jazzcash,
                    //     onPayment: (response) =>
                    //         setState(() => this.response = response),
                    //   ),
                    // ),
                    // ElevatedButton(
                    //   child: const Text('Pay with Easypaisa'),
                    //   onPressed: () => PaymobPakistan.instance.pay(
                    //     context: context,
                    //     currency: "PKR",
                    //     amountInCents: "100",
                    //     billingData: PaymobBillingData(
                    //         email: "test@test.com",
                    //         firstName: "Mariam",
                    //         lastName: "Yusra",
                    //         phoneNumber: "+923342856286",
                    //         apartment: "NA",
                    //         building: "NA",
                    //         city: "NA",
                    //         country: "Pakistan",
                    //         floor: "NA",
                    //         postalCode: "NA",
                    //         shippingMethod: "Online",
                    //         state: "NA",
                    //         street: "NA"),
                    //     paymentType: PaymentType.easypaisa,
                    //     onPayment: (response) =>
                    //         setState(() => this.response = response),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 2),
                            borderRadius: BorderRadius.circular(50),
                            gradient: const LinearGradient(colors: [
                              Color(0xFFD45A2D),
                              Color(0xFFBD861C),
                              Color.fromARGB(67, 0, 130, 181)
                            ])),
                        child: BidButton(
                          buttonTitle: 'Pay with Card',
                          isLoginButton: false,
                          onPress: () => PaymobPakistan.instance.pay(
                            context: context,
                            currency: "PKR",
                            amountInCents: "${widget.price}",
                            paymentType: PaymentType.card,
                            onPayment: (response) =>
                                setState(() => this.response = response),
                          ),
                          // child: const Text('Pay with Card'),
                          // onPressed: () => PaymobPakistan.instance.pay(
                          //   context: context,
                          //   currency: "PKR",
                          //   amountInCents: "100",
                          //   paymentType: PaymentType.card,
                          //   onPayment: (response) =>
                          //       setState(() => this.response = response),
                          // ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
