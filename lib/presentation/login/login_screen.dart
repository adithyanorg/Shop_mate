import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_mate/application/login/login_bloc.dart';
import 'package:shop_mate/presentation/constants/colors.dart';
import 'package:shop_mate/presentation/constants/route_animation.dart';
import 'package:shop_mate/presentation/signup/signup_screen.dart';
import 'package:shop_mate/presentation/util/snackbar.dart';
import 'package:shop_mate/presentation/widgets/asset_card.dart';
import 'package:shop_mate/presentation/widgets/loader_widgets.dart';
import 'package:shop_mate/presentation/widgets/text_form_field_widgets.dart';
import 'package:shop_mate/presentation/widgets/text_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: const Icon(
          Icons.close,
          color: AppColor.colorGrey3,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Column(
                    children: [
                      BuildHeadingText2(text: "Welcome!"),
                      BuildSmallText(
                        text: 'Please enter your  data to continue',
                        color: AppColor.colorGrey2,
                        fontSize: 15,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                BuildTextFormField(
                  label: 'Email',
                  hintText: "Enter your email",
                  icon: Icons.mail,
                  keyboardType: TextInputType.emailAddress,
                  func: (value) {
                    log(value);

                    email = value;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextFormField(
                  label: 'Password',
                  hintText: "Enter your password",
                  icon: Icons.lock,
                  obscureText: true,
                  func: (value) {
                    log(value);

                    password = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Divider(
                        color: AppColor.colorGrey2,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BuildSmallText(
                        text: "Or",
                        fontSize: 14,
                        color: AppColor.colorGrey2,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: AppColor.colorGrey2,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildAssetCard(
                      asset: Image.asset(
                        'assets/images/google.com.png',
                        width: 50,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    BuildAssetCard(
                      asset: SvgPicture.asset('assets/images/fb.svg'),
                    ),
                  ],
                ),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        formValidationAndSubmission(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        height: 60,
                        width: 0.9.sw,
                        decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Center(
                          child: state.isLoading == true
                              ? const BuildMiniLoader()
                              : const BuildSmallText(
                                  text: "Login",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.whiteColor,
                                ),
                        ),
                      ),
                    );
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(buildNavigation(route: SignupScreen()));
                  },
                  child: const BuildTextWithSignupLink(
                    text1: "Don't have an account?",
                    text2: "Signup",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void formValidationAndSubmission(BuildContext context) {
    log(email.toString());
    log(password.toString());
    if (email == '' || email == null) {
      snackBar(
        context: context,
        msg: 'Please enter your email address.',
      );
    } else if (password == '' || password == null) {
      snackBar(
        context: context,
        msg: 'Please enter your password.',
      );
    } else {
      BlocProvider.of<LoginBloc>(context).add(
        LoginEvent.login(
          email: email!,
          password: password!,
          buildContext: context,
        ),
      );
    }
  }
}
