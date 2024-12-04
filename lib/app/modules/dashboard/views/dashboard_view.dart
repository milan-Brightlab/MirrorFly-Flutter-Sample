import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import '../../../app_style_config.dart';
import '../../../common/constants.dart';
import '../../../extensions/extensions.dart';
import '../../../modules/dashboard/views/callhistory_view.dart';
import '../../../modules/dashboard/views/recentchat_view.dart';
import '../../../modules/dashboard/views/installedapps_view.dart';
import '../../../modules/dashboard/views/walletpage_view.dart';
import '../../settings/views/settings_view.dart';
import '../../../stylesheet/stylesheet.dart';
import '../../../widgets/animated_floating_action.dart';
import 'package:mirrorfly_plugin/mirrorflychat.dart';
import '../../apps/controllers/miniapp_controller.dart';

import '../../../common/app_localizations.dart';
import '../../../common/app_theme.dart';
import '../../../data/utils.dart';
import '../../../widgets/custom_action_bar_icons.dart';
import '../../dashboard/controllers/dashboard_controller.dart';
import '../../dashboard/dashboard_widgets/appbar_widgets.dart';


class DashboardView extends NavViewStateful<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);


  @override
DashboardController createController({String? tag}) => Get.put(DashboardController(),tag: key?.hashCode.toString());

  @override
  Widget build(BuildContext context) {
    // Mirrorfly.setEventListener(this);
    return FocusDetector(
        onFocusGained: () {
          debugPrint('onFocusGained');
          // controller.initListeners();
          controller.checkArchiveSetting();
          // controller.getRecentChatList();
        },
        child: Obx(
          () => PopScope(
            canPop: !(controller.selected.value || controller.isSearching.value),
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) {
                return;
              }
              if (controller.selected.value) {
                controller.clearAllChatSelection();
                return;
              } else if (controller.isSearching.value) {
                controller.getBackFromSearch();
                return;
              }
            },
            child: Theme(
              data: Theme.of(context).copyWith(tabBarTheme: AppStyleConfig.dashBoardPageStyle.tabBarTheme,
              appBarTheme: AppStyleConfig.dashBoardPageStyle.appBarTheme,
                  floatingActionButtonTheme: AppStyleConfig.dashBoardPageStyle.floatingActionButtonThemeData),
              child: CustomSafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Builder(builder: (ctx) {
                    return Scaffold(
                        floatingActionButton: controller.isSearching.value
                            ? null
                            : Obx(() {
                                return createFab(controller.currentTab.value,ctx);
                              }),
                        body: NestedScrollView(
                            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                              return [
                                // CustomSliverAppBar(
                                //   key: const ValueKey('dashboard_sliver_appbar'),
                                //   controller: controller,
                                //   title: 'Chats',
                                //   popupMenuThemeData: AppStyleConfig.dashBoardPageStyle.popupMenuThemeData,
                                // ),
                              ];
                            },
                            body: Obx(() => IndexedStack( index: controller.selectedIndex.value,
                              children: [
                                RecentChatView(
                                  controller: controller,
                                  archivedTileStyle: AppStyleConfig.dashBoardPageStyle.archivedTileStyle,
                                  recentChatItemStyle: AppStyleConfig.dashBoardPageStyle.recentChatItemStyle,
                                  noDataTextStyle: AppStyleConfig.dashBoardPageStyle.noDataTextStyle,
                                  contactItemStyle: AppStyleConfig.dashBoardPageStyle.contactItemStyle,
                                ),
                                CallHistoryView(
                                  controller: controller,
                                  callHistoryItemStyle: AppStyleConfig.dashBoardPageStyle.callHistoryItemStyle,
                                  noDataTextStyle: AppStyleConfig.dashBoardPageStyle.noDataTextStyle,
                                  createMeetLinkStyle: AppStyleConfig.dashBoardPageStyle.createMeetLinkStyle,
                                  recentCallsTitleStyle: AppStyleConfig.dashBoardPageStyle.titlesTextStyle,
                                  meetBottomSheetStyle: AppStyleConfig.dashBoardPageStyle.meetBottomSheetStyle,
                                ),
                                dashboardInstalledView(
                                  controller: controller,
                                  noDataTextStyle: AppStyleConfig.dashBoardPageStyle.noDataTextStyle,
                                  installedapps: getInstalledMiniApps(),

                                    coloumns: 3

                                ),
                                WalletPageView(
                                  controller: controller,
                                  noDataTextStyle: AppStyleConfig.dashBoardPageStyle.noDataTextStyle,

                                ),
                                SettingsView()
                              ],
                            )
                        )),

                            bottomNavigationBar: Obx(() => BottomNavigationBar(
                              backgroundColor: Colors.white, // Background color
                              selectedItemColor: Colors.blue, // Color for selected icon/text
                              unselectedItemColor: Colors.grey, // Color for unselected icon/text
                              iconSize: 30, // Icon size
                              selectedFontSize: 14, // Selected label font size
                              unselectedFontSize: 12,
                              // Unselected label font size
                              items: const [
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.chat),
                                  label: 'Chats',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.call),
                                  label: 'Calls',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.apps),
                                  label: 'Apps',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.wallet),
                                  label: 'Wallet',
                                ),
                                BottomNavigationBarItem(
                                  icon: Icon(Icons.settings),
                                  label: 'Settings',
                                ),
                              ],
                              currentIndex: controller.selectedIndex.value,
                              onTap: (int index) {
                                // if (index == 4) { // Assuming the settings bar item is at index 2
                                //   controller.gotoSettings();
                                // }
                                // First, update the index to switch the view
                                controller.updateIndex(index);


                                // Then, if the tapped item is the settings item, call the gotoSettings function
                              },
                            ),
                            )
                          );
                          }),

                ),
              ),
            ),
          ),
        ));
  }

  Widget? createScaledFab(BuildContext context) {
    // Searching for index of a tab with not 0.0 scale
    final indexOfCurrentFab = controller.tabScales.indexWhere((fabScale) => fabScale != 0);
    // If there are no fabs with non-zero opacity return nothing
    if (indexOfCurrentFab == -1) {
      return null;
    }
    // Creating fab for current index
    final fab = createFab(indexOfCurrentFab,context);
    // If no fab created return nothing
    /*if (fab == null) {
      return null;
    }*/
    final currentFabScale = controller.tabScales[indexOfCurrentFab];
    // Scale created fab with
    // You can use different Widgets to create different effects of switching
    // fabs. E.g. you can use Opacity widget or Transform.translate to create
    // custom animation effects
    return Transform.scale(scale: currentFabScale, child: fab);
  }

  // Create fab for provided index
  Widget createFab(final int index,BuildContext context) {
    if (index == 0) {
      // return FloatingActionButton(
      //   tooltip: "New Chat",
      //   heroTag: "New Chat",
      //   onPressed: () {
      //     controller.gotoContacts();
      //   },
      //   child:
      //   AppUtils.svgIcon(icon:
      //     chatFabIcon,
      //     width: Theme.of(context).floatingActionButtonTheme.iconSize,
      //     colorFilter: ColorFilter.mode(Theme.of(context).floatingActionButtonTheme.foregroundColor ?? Colors.white, BlendMode.srcIn),
      //   ),
      // );
    }
    // Not created fab for 1 index deliberately
    if (index == 1) {
      return AnimatedFloatingAction(
        tooltip: "New Call",
        backgroundColor: Theme.of(context).floatingActionButtonTheme.backgroundColor,
        foregroundColor: Theme.of(context).floatingActionButtonTheme.foregroundColor,
        icon: AppUtils.svgIcon(icon:
          plusIcon,
          width: Theme.of(context).floatingActionButtonTheme.iconSize,
          colorFilter: ColorFilter.mode(Theme.of(context).floatingActionButtonTheme.foregroundColor ?? Colors.white, BlendMode.srcIn),
          fit: BoxFit.contain,
        ),
        audioCallOnPressed: () {
          controller.gotoContacts(forCalls: true, callType: CallType.audio);
        },
        videoCallOnPressed: () {
          controller.gotoContacts(forCalls: true, callType: CallType.video);
        },
      );
    }
    return const Offstage();
  }
}
