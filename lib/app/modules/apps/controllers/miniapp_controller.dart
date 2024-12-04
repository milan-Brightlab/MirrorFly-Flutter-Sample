


import 'package:flutter/material.dart';

class App {
  final String name;
  final String title;
  final IconData iconPath;
  final String url;
  final Color color;
  final bool native;

  App({
    required this.name,
    required this.title,
    required this.iconPath,
    required this.url,
    required this.color,
    required this.native,
  });
  bool matches(String searchTitle) {
    return title.toLowerCase() == searchTitle.toLowerCase();
  }

}

getInstalledMiniApps(){
  final List<App> installedApps =[
    App(
      name: 'MelonMoblieData',
      title: 'Buy Data',
      iconPath: Icons.data_saver_on_rounded,
      url: 'https://www.melonmobile.co.za/build-your-own-plan',
      color: Colors.orange,
      native: false
    ),
    App(
        name: 'E-Panic',
        title: 'E-Panic',
        iconPath: Icons.app_blocking_outlined,
        url: 'https://playtictactoe.org',
        color: Colors.blue,
        native: true
    ),
    // InstalledApps(
    //   name: 'MelonMoblie',
    //   title: 'Buy Airtime',
    //   iconPath: 'assets/icons/calculator.png',
    //   url: 'https://www.melonmobile.co.za/build-your-own-plan',
    // ),
    App(
      name: 'Vouchers',
      title: 'Vouchers',
      iconPath: Icons.file_copy,
      url: 'https://shop.1voucher.co.za/',
      color: Colors.orange,
        native: false
    ),
    App(
      name: 'Electricity & Water',
      title: 'Electricity & Water',
      iconPath: Icons.electric_bolt,
      url: 'https://www.e-tshwane.co.za/eTshwane/login',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'OasisWater',
      title: 'Buy Bulk Water',
      iconPath: Icons.water,
      url: 'https://oasiswater.co.za',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Shop2Shop',
      title: 'Shop2Shop',
      iconPath: Icons.shop,
      url: 'https://www.washingtonpost.com',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Radio',
      title: 'Radio',
      iconPath: Icons.radio,
      url: 'https://www.radio-south-africa.co.za',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Music',
      title: 'Music',
      iconPath: Icons.music_note,
      url: 'https://www.flutter.dev',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Entertainment',
      title: 'Entertainment',
      iconPath: Icons.ondemand_video_outlined,
      url: 'https://youtube.com',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Gaming',
      title: 'Gaming',
      iconPath: Icons.games_outlined,
      url: 'https://playtictactoe.org',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Travel',
      title: 'Travel',
      iconPath: Icons.airplane_ticket,
      url: 'https://www.travelstart.co.za',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Learn',
      title: 'Learn',
      iconPath: Icons.book,
      url: 'https://lms.topic.co.za',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Lawyer on Call',
      title: 'Lawyer on Call',
      iconPath: Icons.book_outlined,
      url: 'https://www.holidayheroes.de/',
        color: Colors.orange,
        native: false
    ),
    App(
      name: 'Ambulance on Call',
      title: 'Ambulance on Call',
      iconPath: Icons.car_crash_outlined,
      url: 'https://www.holidayheroes.de/',
        color: Colors.orange,
        native: false
    ),
    // InstalledApps(
    //   name: 'holidayheroes',
    //   title: 'Holiday Heroes',
    //   iconPath: '',
    //   url: 'https://www.holidayheroes.de/',
    // ),
  ];
return installedApps;

}

getInstalledWalletServices(index){
  List<App> installedApps = [
    App(
        name: 'Default App',
        title: 'Default',
        iconPath: Icons.app_shortcut,
        url: 'https://example.com',
        color: Colors.orange,
        native: false
    ),
  ];

  if (index == 0) {
    installedApps = [
      App(
          name: 'Crypto Exchange',
          title: 'Crypto Exchange',
          iconPath: Icons.currency_exchange,
          url: 'https://exchange.blockkoin.io/exchange',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Invest',
          title: 'Invest',
          iconPath: Icons.token,
          url: 'https://investor-brightlab-dev.digishares.tech',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Send Money',
          title: 'Send Money',
          iconPath: Icons.send,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),

      App(
          name: 'Recieve Money',
          title: 'Recieve Money',
          iconPath: Icons.receipt_long_outlined,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Payments',
          title: 'Payments',
          iconPath: Icons.payment_outlined,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Remit',
          title: 'Remit',
          iconPath: Icons.money,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      )
    ];
  }
  else if (index == 1){
    installedApps = [
      App(
          name: 'Blokkoin Exchange',
          title: 'Crypto Exchange',
          iconPath: Icons.currency_exchange,
          url: 'https://exchange.blockkoin.io/exchange',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'ETH Markets',
          title: 'ETH Markets',
          iconPath: Icons.add_business,
          url: 'https://exchange.blockkoin.io/markets',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Send ETH',
          title: 'Send ETH',
          iconPath: Icons.send,
          url: 'https://exchange.blockkoin.io/quick-buy-sell',
          color: Colors.orange,
          native: false
      ),

      App(
          name: 'Recieve ETH',
          title: 'Recieve ETH',
          iconPath: Icons.receipt_long_outlined,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Transcations',
          title: 'Transcations',
          iconPath: Icons.payment_outlined,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Ledger',
          title: 'Ledger',
          iconPath: Icons.money,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      )
    ];
  }
  else if (index == 2){
    installedApps = [
      App(
          name: 'Gold Exchange',
          title: 'Gold Exchange',
          iconPath: Icons.currency_exchange,
          url: 'https://exchange.blockkoin.io/exchange',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Buy Gold',
          title: 'Buy Gold',
          iconPath: Icons.token,
          url: 'https://web.troygold.app/buy-digital',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Send Gold',
          title: 'Send Gold',
          iconPath: Icons.send,
          url: 'https://web.troygold.app/peer-transfer',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Sell Gold',
          title: 'Sell Gold',
          iconPath: Icons.sell,
          url: 'https://web.troygold.app/sell-digital',
          color: Colors.orange,
          native: false
      ),

      App(
          name: 'Redeem Gold',
          title: 'Redeem Gold',
          iconPath: Icons.redeem,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),
      App(
          name: 'Earn Gold',
          title: 'Earn Gold',
          iconPath: Icons.payment_outlined,
          url: 'https://example.com',
          color: Colors.orange,
          native: false
      ),

    ];
  }

  return installedApps;
}

getAccountsServices(){
  final List<App> installedApps =[
    App(
        name: 'Blokkoin Exchange',
        title: 'Crypto Exchange',
        iconPath: Icons.currency_exchange,
        url: 'https://exchange.blockkoin.io/exchange',
        color: Colors.orange,
        native: false
    ),
    App(
        name: 'Digishares',
        title: 'Invest',
        iconPath: Icons.token,
        url: 'https://investor-brightlab-dev.digishares.tech',
        color: Colors.orange,
        native: false
    ),
    App(
        name: 'Mokoro',
        title: 'Send Money',
        iconPath: Icons.send,
        url: 'https://example.com',
        color: Colors.orange,
        native: false
    ),

    App(
        name: 'Mokoro',
        title: 'Recieve Money',
        iconPath: Icons.receipt_long_outlined,
        url: 'https://example.com',
        color: Colors.orange,
        native: false
    ),
    App(
        name: 'Mokoro',
        title: 'Payments',
        iconPath: Icons.payment_outlined,
        url: 'https://example.com',
        color: Colors.orange,
        native: false
    ),
    App(
        name: 'Mokoro',
        title: 'Remit',
        iconPath: Icons.money,
        url: 'https://example.com',
        color: Colors.orange,
        native: false
    )
  ];
  return installedApps;
}


getApp(){}

getAppStatus(){}

// isAppInstalled(item){
//   final installedapps = getInstalledMiniApps();
//   if (item in installedapps){
//
//   }
// }

