import 'package:flutter/material.dart';
import 'package:paymentin/core/constant/app_colors.dart';
import 'package:paymentin/models/transaction_model.dart';
import 'package:paymentin/view/widgets/payment_card.dart';
import 'package:paymentin/view/widgets/status_card.dart';
import 'package:paymentin/view/widgets/timer_widget.dart';
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
            PaymentCard(transaction: transaction),
            const SizedBox(height: 20),
            TimerWidget(seconds: provider.remainingSeconds),
            const SizedBox(height: 30),
            StatusCard(status: provider.paymentStatus),
            const Spacer(),
            if (provider.paymentStatus == PaymentStatus.failed ||
                provider.paymentStatus == PaymentStatus.timeout)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: OutlinedButton(
                    onPressed: () {
                      provider.retryTransaction();
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text(
                      "Retry Transactions",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed:
                    provider.paymentStatus == PaymentStatus.loading ||
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
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(width: 15),

                          Text(
                            "Processing...",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      )
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
