import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paymentin/services/payment_srevice.dart';

enum PaymentStatus { idle, loading, success, failed, timeout }

class PaymentProvider extends ChangeNotifier {
  final PaymentSrevice paymentSrevice = PaymentSrevice();

  PaymentStatus paymentStatus = PaymentStatus.idle;

  int remainingSeconds = 120;

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        paymentStatus = PaymentStatus.timeout;
        timer.cancel();
        notifyListeners();
      }
    });
  }

  Future<void> confirmPayment() async {
    if (paymentStatus == PaymentStatus.timeout ||
        paymentStatus == PaymentStatus.success ||
        paymentSrevice == PaymentStatus.loading){
      return;

        }

    paymentStatus = PaymentStatus.loading;
    notifyListeners();

    bool result = await paymentSrevice.processpayment();
    timer?.cancel();

    if (result) {
      paymentStatus = PaymentStatus.success;
    } else {
      paymentStatus = PaymentStatus.failed;
    }
    notifyListeners();
  }

  void retryTransaction() {
    paymentStatus = PaymentStatus.idle;
    remainingSeconds = 120;
    startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
