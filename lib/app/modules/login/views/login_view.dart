import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app_style_config.dart';
import '../../../common/app_localizations.dart';
import '../../../common/widgets.dart';
import '../../../data/utils.dart';
import '../../../extensions/extensions.dart';

import '../../../common/constants.dart';
import '../../../routes/route_settings.dart';
import '../controllers/login_controller.dart';

class LoginView extends NavViewStateful<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
LoginController createController({String? tag}) => Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    // Add an observable boolean to controller to track whether to show welcome or login
    controller.showWelcome = true.obs;

    return Obx(() => controller.showWelcome.value ? _buildWelcomeView() : _buildLoginView(context));
  }

  Widget _buildWelcomeView() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // White section with logo and title
          Expanded(

            flex: 5, // Adjust this value to control the white section's height
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                   Text(
                    'Your all in one\nNetwork',
                    textAlign: TextAlign.center,
                    style: AppStyleConfig.loginPageStyle.appTitle,
                  ),
                  // const SizedBox(height: 10),
                  // Logo
                  const SizedBox(height: 35),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(
                      zambiziSideLogo,
                      height: 150,
                      width: 400,
                      // fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Orange section with bullet points
          Expanded(
            flex: 6, // Adjust this value to control the orange section's height
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFEF8733), // Orange color
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildBulletPoint('Enable small traders with buying power'),
                      const SizedBox(height: 20),
                      _buildBulletPoint('Free Connectivity'),
                      const SizedBox(height: 20),
                      _buildBulletPoint('Free Business services'),
                      const SizedBox(height: 20),
                      _buildBulletPoint('Access to a large product offering'),
                    ],
                  ),
                  // Continue Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        controller.showWelcome.value = false;
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFFEF8733),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: AppStyleConfig.loginPageStyle.bulletPointText ,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginView(BuildContext context) {
    return GestureDetector(
      onTap: (){
        controller.focusNode.unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Image.asset(
                      zambiziSideLogo,
                      height: 180,
                      width: 550,
                      // fit: BoxFit.contain,
                    ),

                  ),
                  Text(
                    getTranslated("registerYourNumber"),
                    textAlign: TextAlign.center,
                    style: AppStyleConfig.loginPageStyle.bodyTitleStyle,
                    // style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 8, left: 8),
                    child: Text(
                      getTranslated("registerMessage"),
                      textAlign: TextAlign.center,
                      style: AppStyleConfig.loginPageStyle.bodyDescriptionStyle,
                      /*style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: textColor),*/
                    ),
                  ),
                  Obx(() => Padding(
                    padding: const EdgeInsets.only(left : 10.0 , right: 10.0,top: 10.0),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(controller.selectedCountry.value.name ?? "",style: AppStyleConfig.loginPageStyle.selectedCountryTextStyle,),
                          // style: const TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.keyboard_arrow_down_outlined),
                      onTap: (){
                        NavUtils.toNamed(Routes.countries)?.then((value) => value!=null ? controller.selectedCountry.value = value : controller.india);
                      },
                    ),
                  )),
                  const AppDivider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Obx(
                                ()=> Text(
                              controller.selectedCountry.value.dialCode ?? "",
                              style: AppStyleConfig.loginPageStyle.selectedCountryCodeTextStyle,
                              // style: const TextStyle(fontSize: 15),
                            ),
                          ),
                          const VerticalDivider(
                            color: Colors.grey,
                            thickness: 0.3,
                          ),
                          Flexible(
                            child: TextField(
                              focusNode: controller.focusNode,
                              cursorColor: buttonBgColor,
                              controller: controller.mobileNumber,
                              keyboardType: TextInputType.phone,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(13)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: getTranslated("enterMobileNumber"),
                                hintStyle: AppStyleConfig.loginPageStyle.editTextFieldStyle.editTextHintStyle
                                //hintStyle: TextStyle(color: Colors.black26)
                              ),
                              style: AppStyleConfig.loginPageStyle.editTextFieldStyle.editTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF8C00),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      controller.registerUser();
                    },
                    child: Text(
                      getTranslated("continue"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(getTranslated("agree"),
                    style: AppStyleConfig.loginPageStyle.footerHeadlineStyle,
                    // style: const TextStyle(color: textColor,fontSize: 13,fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Text(
                          '${getTranslated("termsAndCondition")},',
                          style: AppStyleConfig.loginPageStyle.termsTextStyle,
                          /*style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: buttonBgColor),*/
                        ),
                        onTap:()=>AppUtils.launchWeb(Uri.parse(getTranslated("termsConditionsLink"))),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        child: Text(
                          '${getTranslated("privacyPolicy")}.',
                          style: AppStyleConfig.loginPageStyle.termsTextStyle,
                          /*style: const TextStyle(
                              decoration: TextDecoration.underline,
                              color: buttonBgColor),*/
                        ),
                        onTap: ()=>AppUtils.launchWeb(Uri.parse(getTranslated("privacyPolicyLink"))),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
