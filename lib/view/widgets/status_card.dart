import 'package:flutter/material.dart';
import 'package:paymentin/core/constant/app_colors.dart';
import 'package:paymentin/view_model/payment_provider.dart';

class StatusCard extends StatelessWidget {
  final PaymentStatus status;
  const StatusCard({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String message = "Waiting for confirmation";
    Color color = Colors.orange;
    IconData icon = Icons.pending;
    if (status == PaymentStatus.success) {
      message = "Payment Successful";
      color = AppColors.success;
      icon = Icons.check_circle;
    }
    if (status == PaymentStatus.failed) {
      message = "Payment failed ";
      color = AppColors.failure;
      icon = Icons.cancel;
    }
    if (status == PaymentStatus.timeout) {
      message = "Transaction Timed Out";
      color = Colors.orange;
      icon = Icons.timer_off;
    }

    if (status == PaymentStatus.loading) {
      message = "Processing Payment...";
      color = AppColors.primary;
      icon = Icons.sync;
    }
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 50),
          const SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(
              color: color,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
