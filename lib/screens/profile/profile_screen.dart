import 'package:ferma/utils/shared_preferences.dart';
import 'package:ferma/widgets/app_title_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ferma/controllers/home_controller.dart';
import 'package:ferma/controllers/profile_controller.dart';
import 'package:ferma/screens/auth_screen.dart';
import 'package:ferma/screens/profile/edit_profile_screen.dart';
import 'package:ferma/utils/my_colors.dart';
import 'package:ferma/widgets/load_image.dart';
import 'package:ferma/widgets/loading_indicator.dart';
import 'package:ferma/widgets/my_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GetX<ProfileController>(
        init: ProfileController(),
        builder: (s) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: MyAppBar(
                centerTitle: false,
                actions: [
                  if (!s.isLoading.value)
                    GestureDetector(
                      onTap: () async {
                        await SharedPrefs.logOut().then((res) {
                          if (res) Get.offAll(AuthScreen());
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 25, 0),
                        child: Icon(Icons.exit_to_app_rounded),
                      ),
                    )
                ],
              ),
            ),
            body: SafeArea(
              child: s.isLoading.value
                  ? loadingIndicator()
                  : ListView(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 55),
                      children: [
                        AppTitleBar(title: 'Profile'),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withAlpha((8 / 100 * 255).toInt()),
                                  blurRadius: 25,
                                  offset: Offset(0, 3),
                                )
                              ]),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    (s.user.value.profilePicture?.isNotEmpty ??
                                                false) &&
                                            s.user.value.profilePicture != null
                                        ? loadImage(
                                            s.user.value.profilePicture,
                                          )
                                        : Image.asset(
                                            'assets/images/default_profile_picture.png',
                                          ),
                              ),
                            ),
                            SizedBox(height: 13),
                          ],
                        ),
                        SizedBox(height: 30),
                        buildSectionTitle('Personal Info'),
                        buildListTile(
                            'Email Adress', s.user.value.email ?? '-'),
                        buildListTile('Full Name', s.user.value.name ?? ''),
                        buildListTile(
                            'User Name', s.user.value.username ?? '-'),
                        buildListTile(
                            'Edit Profile', 'Edit your personal information',
                            onTap: () => Get.to(() => EditProfileScreen())),
                        SizedBox(height: 35),
                        buildSectionTitle('Settings'),
                        buildListTile(
                          'Detect Location',
                          homeController.address.value.isEmpty
                              ? 'not set'
                              : homeController.address.value,
                          onTap: homeController.updateLocation,
                        ),
                        buildListTile(
                          'Test Notification',
                          'Make sure your notification works properly',
                          onTap: () {
                            // showNotification(
                            //   'Test Notification',
                            //   'Yayy! The notification works fine!',
                            //   channelId: 'Test Notification',
                            //   channelDesc: 'Test Notification',
                            //   channelName: 'Test Notification',
                            // );
                          },
                        ),
                        buildListTile(
                          'About App',
                          'Learn more about this App',
                          onTap: () {
                            showLicensePage(
                              context: context,
                              applicationIcon: Image.asset(
                                'assets/icons/launcher_icon.png',
                                width: MediaQuery.of(context).size.width * 0.5,
                              ),
                              applicationName: 'Ufarming',
                              applicationVersion:
                                  'v1.0.0', //TODO: get version number  using package
                            );
                          },
                        ),
                        SizedBox(height: 55),
                        Text(
                          'Ferma v1.0.0', //TODO: get version number  using package
                          style: TextStyle(
                            fontSize: 12,
                            color: MyColors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
            ),
          );
        });
  }

  Column buildSectionTitle(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget buildListTile(String title, String subtitle, {Function? onTap}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.5),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: MyColors.darkGrey,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 13,
                          color: MyColors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: MyColors.darkGrey,
                  ),
              ],
            ),
            SizedBox(height: 12.5),
            Divider(color: MyColors.lightGrey),
          ],
        ),
      ),
    );
  }
}
