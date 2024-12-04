import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../extensions/extensions.dart';
import '../controllers/dashboard_controller.dart';
import '../../wallet/widgets/walletcards.dart';
import '../../apps/views/apps_installed_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:mirrorfly_plugin/mirrorflychat.dart';
import 'package:mirrorfly_plugin/model/call_log_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../apps/controllers/miniapp_controller.dart';

import '../../../call_modules/call_highlighted_text.dart';
import '../../../call_modules/call_utils.dart';
import '../../../common/app_localizations.dart';
import '../../../common/constants.dart';
import '../../../common/widgets.dart';
import '../../../data/helper.dart';
import '../../../data/utils.dart';
import '../../../stylesheet/stylesheet.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// ... (keep other imports)

class WalletPageView extends StatefulWidget {
  final DashboardController controller;
  final TextStyle noDataTextStyle;

  const WalletPageView({
    Key? key,
    required this.controller,
    required this.noDataTextStyle,
  }) : super(key: key);

  @override
  State<WalletPageView> createState() => _WalletPageViewState();
}

class _WalletPageViewState extends State<WalletPageView> {
  final PageController _controller = PageController();
  int currentPage = 0;

  // Define wallet card colors
  final List<Color?> cardColors = [
    Color(0xFFEF8733),
    Color(0xFF627EEB),
    Color(0xFF17171A),
  ];

  final List<Color?> textColors = [
    Color(0xFFffffff),
    Color(0xFFffffff),
    Color(0xFFFBEE50),
  ];

  final List<String?> names = [
    "Zambizi",
    "Ethereum",
    "Gold",
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPageChange);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPageChange);
    _controller.dispose();
    super.dispose();
  }

  void _onPageChange() {
    final page = (_controller.page ?? 0).round();
    if (page != currentPage) {
      setState(() {
        currentPage = page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "My ",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(names[currentPage]!+ " Card", style: TextStyle(fontSize: 28)),
                ],
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.add),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 200,
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            children: [
              WalletCards(
                balance: 130152.20,
                cardNumber: 4587,
                expiryMonth: 11,
                expiryYear: 29,
                color: cardColors[0],
                textColor: textColors[0],
                image: zambiziSideLogo,
              ),
              WalletCards(
                balance: 5682.20,
                cardNumber: 3628,
                expiryMonth: 11,
                expiryYear: 29,
                color: cardColors[1],
                textColor: textColors[1],
                image: etheruim,
              ),
              WalletCards(
                balance: 26020.20,
                cardNumber: 9621,
                expiryMonth: 11,
                expiryYear: 29,
                color: cardColors[2],
                textColor: textColors[2],
                image: goldLogo,
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        SmoothPageIndicator(
          controller: _controller,
          count: 3,
          effect: ExpandingDotsEffect(
            dotColor: Colors.grey[300]!,
            activeDotColor: cardColors[currentPage] ?? Colors.blue[400]!,
          ),
        ),
        SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text(
                      "Wallet",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(" Services", style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: 1.5,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: InstalledAppsView(
            noDataTextStyle: widget.noDataTextStyle,
            installedapps: getInstalledWalletServices(currentPage),
            coloumns: 3,
            color: cardColors[currentPage],
            iconColor: textColors[currentPage],// Pass the current card color
          ),
        ),
      ]),
    );
  }
}