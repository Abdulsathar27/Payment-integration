import 'package:flutter/material.dart';
import 'package:paymentin/core/constant/app_colors.dart';
import 'package:paymentin/models/transaction_model.dart';
import 'package:paymentin/view/widgets/payment_card.dart';
import 'package:paymentin/view_model/payment_provider.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);

    final transaction = TransactionModel(
      merchantName: "Netflix Permium",
      amount: 799,
      cardNumber: "1234567812345678",
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          "Secure Transaction",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            PaymentCard(transaction:transaction),
            const SizedBox(height: 20),
            // timerwidget(seconds:provider.remainingSeconds),
            const SizedBox(height: 30),
            // statusCards(status: provider.paymentStatus),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed:
                    provider.paymentSrevice == PaymentStatus.loading ||
                        provider.paymentStatus == PaymentStatus.success ||
                        provider.paymentStatus == PaymentStatus.timeout
                    ? null
                    : () {
                        provider.confirmPayment();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: provider.paymentStatus == PaymentStatus.loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Confirm Payment",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
