import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zambizi/app/common/constants.dart';


class WalletCards extends StatelessWidget{
  final double balance;
  final int cardNumber;
  final int expiryMonth;
  final int expiryYear;
  final color;
  final textColor;
  final image;

  const WalletCards({
    Key? key,
  required this.balance,
  required this.cardNumber,
  required this.expiryMonth,
  required this.expiryYear,
  required this.color,
  required this.textColor,
  required this.image}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        width: 300,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            // Main content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Text(
                  '\R ' + NumberFormat.currency(
                    symbol: '',
                    decimalDigits: 2,
                  ).format(balance),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 28,
                      fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '**** ' + cardNumber.toString(),
                      style: TextStyle(
                        color: textColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      expiryMonth.toString() + '/' + expiryYear.toString(),
                      style: TextStyle(
                        color: textColor,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Image.asset(
                //       visaLogo,
                //       width: 50,
                //       height: 50,
                //     ),
                //   ],
                // ),
              ],
            ),

            // Large Ethereum image overlay
            Positioned(
              right: 0,
              top: 0,
              child: ClipRect(
                child: SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );}}