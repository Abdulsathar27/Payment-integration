import 'package:flutter/material.dart';
import 'package:paymentin/core/constant/app_colors.dart';
import 'package:paymentin/models/transaction_model.dart';
import 'package:provider/provider.dart';
import '../../view_model/payment_provider.dart';
import '../widgets/payment_card.dart';
import '../widgets/status_card.dart';
import '../widgets/timer_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PaymentProvider>(context);

    final transaction = TransactionModel(
      merchantName: "Netflix Premium",
      amount: 799,
      cardNumber: "1234567812345678",
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Secure Transaction",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Secure Payment Gateway",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Your transaction is encrypted and secure",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 30),

            PaymentCard(
              transaction: transaction,
            ),

            const SizedBox(height: 25),

            TimerWidget(
              seconds: provider.remainingSeconds,
            ),

            const SizedBox(height: 30),

            StatusCard(
              status: provider.paymentStatus,
            ),

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
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    child: const Text(
                      "Retry Transaction",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
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
                            provider.paymentStatus ==
                                PaymentStatus.success ||
                            provider.paymentStatus ==
                                PaymentStatus.timeout
                        ? null
                        : () {
                            provider.confirmPayment();
                          },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child:
                    provider.paymentStatus == PaymentStatus.loading
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                        : const Text(
                          "Confirm Payment",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}