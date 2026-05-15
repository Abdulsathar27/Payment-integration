import 'dart:math';

class PaymentSrevice {
  Future<bool> processpayment() async {
    await Future.delayed(const Duration(seconds: 3));
    return Random().nextBool();
  }
}
