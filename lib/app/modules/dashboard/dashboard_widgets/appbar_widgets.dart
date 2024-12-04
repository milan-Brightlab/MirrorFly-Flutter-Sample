import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../../widgets/custom_action_bar_icons.dart';
import '../../../common/constants.dart';
import '../../../common/app_localizations.dart';
import '../../../extensions/extensions.dart';
import '../../../data/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../../widgets/custom_action_bar_icons.dart';
import '../../../common/constants.dart';
import '../../../common/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DashboardController controller;
  final PopupMenuThemeData popupMenuThemeData;
  final double availableWidth;
  final String title;

  const CustomAppBar({
    Key? key,
    required this.controller,
    required this.popupMenuThemeData,
    required this.title,
    this.availableWidth = 0.8,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Obx(() => AppBar(
      title: controller.title.value
          ? Text(
        title,
        style: popupMenuThemeData.textStyle,
      )
          : null,
      centerTitle: true,
      leading: GetBuilder<DashboardController>(
        builder: (_) {
          return Visibility(
            child: GestureDetector(
              onTap: () {
                controller.clearAllChatSelection();
              },
              child: Center(
                child: Text(
                  controller.edit.value ? '' : 'Done',
                  style: popupMenuThemeData.textStyle,
                ),
              ),
            ),
          );
        },
      ),
      actions: [_buildActionBar(context)],
    ));
  }

  Widget _buildActionBar(BuildContext context) {
    return CustomActionBarIcons(
      key: ValueKey('action_bar_${controller.selectedIndex.value}'),
      popupMenuThemeData: popupMenuThemeData,
      availableWidth: MediaQuery.of(context).size.width * availableWidth,
      actionWidth: 50,
      actions: _buildActions(context),
    );
  }
  List<CustomAction> _buildActions(BuildContext context) {
    return [
      _buildInfoAction(context),
      _buildDeleteAction(context),
      _buildPinAction(context),
      _buildUnpinAction(context),
      _buildMuteAction(context),
      _buildUnmuteAction(context),
      _buildArchiveAction(context),
      _buildMarkAsReadAction(),
      _buildMarkAsUnreadAction(),
      _buildNewMessageAction(context),
      _buildNewGroupAction(context),
      _buildClearAction(),
      _buildClearCallLogAction(),
    ];
  }

  CustomAction _buildInfoAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.chatInfo(),
        icon: AppUtils.svgIcon(
          icon: infoIcon,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'Info',
      ),
      overflowWidget: Text(
        getTranslated("info"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.info.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'Info',
      onItemClick: () => controller.chatInfo(),
    );
  }

  CustomAction _buildDeleteAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () {
          controller.currentTab.value == 0
              ? controller.deleteChats()
              : controller.deleteCallLog();
        },
        icon: AppUtils.svgIcon(
          icon: delete,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'Delete',
      ),
      overflowWidget: Text(
        getTranslated("delete"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.availableFeatures.value.isDeleteChatAvailable.checkNull()
          ? controller.delete.value
          ? ShowAsAction.always
          : ShowAsAction.gone
          : ShowAsAction.gone,
      keyValue: 'Delete',
      onItemClick: () => controller.deleteChats(),
    );
  }

  CustomAction _buildPinAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.pinChats(),
        icon: AppUtils.svgIcon(
          icon: pin,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'Pin',
      ),
      overflowWidget: Text(
        getTranslated("pin"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.pin.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'Pin',
      onItemClick: () => controller.pinChats(),
    );
  }

  CustomAction _buildUnpinAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.unPinChats(),
        icon: AppUtils.svgIcon(
          icon: unpin,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'UnPin',
      ),
      overflowWidget: Text(
        getTranslated("unPin"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.unpin.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'UnPin',
      onItemClick: () => controller.unPinChats(),
    );
  }

  CustomAction _buildMuteAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.muteChats(),
        icon: AppUtils.svgIcon(
          icon: mute,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'Mute',
      ),
      overflowWidget: Text(
        getTranslated("mute"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.mute.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'Mute',
      onItemClick: () => controller.muteChats(),
    );
  }

  CustomAction _buildUnmuteAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.unMuteChats(),
        icon: AppUtils.svgIcon(
          icon: unMute,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'UnMute',
      ),
      overflowWidget: Text(
        getTranslated("unMute"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.unmute.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'UnMute',
      onItemClick: () => controller.unMuteChats(),
    );
  }

  CustomAction _buildArchiveAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.archiveChats(),
        icon: AppUtils.svgIcon(
          icon: archive,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'Archive',
      ),
      overflowWidget: Text(
        getTranslated("archived"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.archive.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'Archived',
      onItemClick: () => controller.archiveChats(),
    );
  }

  CustomAction _buildMarkAsReadAction() {
    return CustomAction(
      visibleWidget: const Icon(Icons.mark_chat_read),
      overflowWidget: Text(
        getTranslated("markAsRead"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.read.value ? ShowAsAction.never : ShowAsAction.gone,
      keyValue: 'Mark as Read',
      onItemClick: () => controller.itemsRead(),
    );
  }

  CustomAction _buildMarkAsUnreadAction() {
    return CustomAction(
      visibleWidget: const Icon(Icons.mark_chat_unread),
      overflowWidget: Text(
        getTranslated("markAsUnread"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.unread.value ? ShowAsAction.never : ShowAsAction.gone,
      keyValue: 'Mark as unread',
      onItemClick: () => controller.itemsUnRead(),
    );
  }

  CustomAction _buildNewMessageAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.gotoContacts(),
        icon: AppUtils.svgIcon(
          icon: newChat,
          width: 20,
          height: 20,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'New Message',
      ),
      overflowWidget: Text(
        getTranslated("search"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.availableFeatures.value.isRecentChatSearchAvailable.checkNull()
          ? controller.selected.value || controller.isSearching.value
          ? ShowAsAction.gone
          : ShowAsAction.always
          : ShowAsAction.gone,
      keyValue: 'New Message',
      onItemClick: () => controller.gotoContacts(),
    );
  }

  CustomAction _buildNewGroupAction(BuildContext context) {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.gotoCreateGroup(),
        icon: AppUtils.svgIcon(
          icon: groupIcon,
          width: 22,
          height: 22,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            Theme.of(context).appBarTheme.actionsIconTheme?.color ?? Colors.black,
            BlendMode.srcIn,
          ),
        ),
        tooltip: 'New Group',
      ),
      overflowWidget: Text(
        getTranslated("search"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.availableFeatures.value.isRecentChatSearchAvailable.checkNull()
          ? controller.selected.value || controller.isSearching.value
          ? ShowAsAction.gone
          : ShowAsAction.always
          : ShowAsAction.gone,
      keyValue: 'New Group',
      onItemClick: () => controller.gotoContacts(),
    );
  }

  CustomAction _buildClearAction() {
    return CustomAction(
      visibleWidget: IconButton(
        onPressed: () => controller.onClearPressed(),
        icon: const Icon(Icons.close),
      ),
      overflowWidget: Text(
        getTranslated("clear"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.clearVisible.value ? ShowAsAction.always : ShowAsAction.gone,
      keyValue: 'Clear',
      onItemClick: () => controller.onClearPressed(),
    );
  }

  CustomAction _buildClearCallLogAction() {
    return CustomAction(
      visibleWidget: const Icon(Icons.web),
      overflowWidget: Text(
        getTranslated("clearCallLog"),
        style: popupMenuThemeData.textStyle,
      ),
      showAsAction: controller.selected.value ||
          controller.isSearching.value ||
          controller.currentTab.value == 0 ||
          controller.callLogList.isEmpty
          ? ShowAsAction.gone
          : ShowAsAction.never,
      keyValue: 'Clear call log',
      onItemClick: () => controller.callLogList.isNotEmpty
          ? controller.clearCallLog()
          : toToast(getTranslated("noCallLog")),
    );
  }
}