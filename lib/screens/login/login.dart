import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/config/colors.dart';
import 'package:restaurant/screens/homepage/homepage.dart';
import 'package:restaurant/utils/navigation.dart';
import 'package:restaurant/utils/sharedpref.dart';
import 'package:restaurant/utils/willpop.dart';
import 'package:restaurant/widgets/custom_textfield.dart';
import 'package:restaurant/widgets/loading_button.dart';
import 'package:restaurant/widgets/snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isLoading = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _getSavedEmail();
  }

  _getSavedEmail() async {
    email.text = await Service().getEmail();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopService().exitApp(context),
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 48.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/login_logo.png',
                  width: MediaQuery.of(context).size.width / 1.5,
                ),
              ),
              SizedBox(height: 12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Log in\nyour account',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              CustomTextField(
                controller: email,
                hintText: "User Name",
                isPassword: false,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 18.h),
              CustomTextField(
                controller: password,
                hintText: "Password",
                isPassword: true,
              ),
              SizedBox(height: 18.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        visualDensity: VisualDensity.comfortable,
                        onChanged: (bool? value) {
                          if (mounted) {
                            setState(() {
                              rememberMe = value!;
                            });
                          }
                        },
                      ),
                      const Text(
                        "Remember Me",
                        style: TextStyle(color: AppColors.kLightText),
                      ),
                    ],
                  ),
                  const Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: AppColors.kBlueText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 64.h),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: LoadingButton(
                  status: isLoading,
                  buttonText: 'LOGIN',
                  onTap: () {
                    if (email.text.isEmpty) {
                      getSnackbar(context, 'Email is required!');
                    } else if (password.text.isEmpty) {
                      getSnackbar(context, 'Password is required!');
                    } else {
                      if (!EmailValidator.validate(email.text)) {
                        getSnackbar(context, 'Invalid Email!');
                      } else {
                        if (rememberMe) {
                          Service().saveEmail(email.text);
                        } else {
                          Service().removeEmail();
                        }
                        if (mounted) {
                          setState(() {
                            isLoading = true;
                          });
                        }
                        Future.delayed(const Duration(seconds: 2))
                            .then((value) {
                          if (mounted) {
                            setState(() {
                              isLoading = false;
                            });
                          }
                          Service().saveLogin();
                          navigationReplacement(context, const Homepage());
                        });
                      }
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
