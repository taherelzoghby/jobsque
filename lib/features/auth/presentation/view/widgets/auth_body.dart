import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/consts/assets.dart';
import 'package:jobsque/core/consts/strings.dart';
import 'package:jobsque/core/helper/custom_snack.dart';
import 'package:jobsque/core/helper/handle_image.dart';
import 'package:jobsque/core/widgets/auth_top_section.dart';
import 'package:jobsque/core/widgets/fade_animation_widget.dart';
import 'package:jobsque/core/widgets/or_sign_up_with_account_widget.dart';
import 'package:jobsque/core/widgets/small_loading_widget.dart';
import 'package:jobsque/core/widgets/text_form_field.dart';
import 'package:jobsque/features/auth/presentation/view/widgets/remeber_me_widget.dart';
import 'package:jobsque/features/auth/presentation/view/widgets/sign_with_google_and_facebook.dart';
import 'package:jobsque/features/auth/presentation/view_model/auth_bloc/auth_bloc.dart';

import '../../../../../core/consts/routesPage.dart';
import '../../../../../core/consts/style.dart';
import '../../../../../core/widgets/customButton.dart';

enum AuthMode { SignUp, Login, ResetPassword }

class AuthBody extends StatefulWidget {
  const AuthBody({super.key});

  @override
  State<AuthBody> createState() => _AuthBodyState();
}

class _AuthBodyState extends State<AuthBody> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late AnimationController controller;
  late Animation<Offset> offsetAnimation;

  @override
  void initState() {
    //init controller
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    //offset animation
    offsetAnimation = TweenSequence(
      <TweenSequenceItem<Offset>>[
        TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 0), end: const Offset(-.04, 0)),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween(begin: const Offset(-.04, 0), end: const Offset(0, 0)),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween(begin: const Offset(0, 0), end: const Offset(.04, 0)),
          weight: 25,
        ),
        TweenSequenceItem(
          tween: Tween(begin: const Offset(.04, 0), end: const Offset(0, 0)),
          weight: 25,
        ),
      ],
    ).animate(controller);
    super.initState();
  }

  AuthMode _authMode = AuthMode.SignUp;
  String? name;
  String? email;
  String? password;

  bool visible = true;
  bool isLoading = false;

  ///switch auth mode
  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() => _authMode = AuthMode.SignUp);
    } else {
      setState(() => _authMode = AuthMode.Login);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthBloc, AuthState>(
      builder: (context, state) {
        return Padding(
          padding: AppConsts.mainPadding,
          child: Form(
            key: _formKey,
            child: FadeAnimation(
              millSeconds: 1000,
              child: ListView(
                children: [
                  ///top section
                  AuthTopSection(
                    title: _authMode == AuthMode.ResetPassword
                        ? StringsEn.resetPass
                        : _authMode == AuthMode.Login
                            ? StringsEn.login
                            : StringsEn.createAccount,
                    subTitle: _authMode == AuthMode.ResetPassword
                        ? StringsEn.enterEmailAddressYouUsed
                        : _authMode == AuthMode.Login
                            ? StringsEn.pleaseLoginToFindJop
                            : StringsEn.pleaseCreateAccount,
                    widget: Container(),
                  ),

                  ///fields
                  AnimatedBuilder(
                    animation: controller,
                    builder: (context, child) {
                      return AnimatedSlide(
                        offset: offsetAnimation.value,
                        duration: const Duration(milliseconds: 200),
                        child: AspectRatio(
                          aspectRatio: AppConsts.aspect16on13,
                          child: Column(
                            children: [
                              ///username
                              _authMode == AuthMode.ResetPassword
                                  ? Container()
                                  : _authMode == AuthMode.Login
                                      ? Container()
                                      : CustomTextFormField(
                                          perfixIcon: HandleImageWidget(
                                              image: AppAssets.profile),
                                          hint: StringsEn.userName,
                                          onChanged: (String? value) =>
                                              name = value,
                                        ),
                              const AspectRatio(
                                  aspectRatio: AppConsts.aspect40on1),

                              ///Email

                              CustomTextFormField(
                                perfixIcon:
                                    HandleImageWidget(image: AppAssets.sms),
                                hint: StringsEn.email,
                                onChanged: (String? value) => email = value,
                              ),
                              const AspectRatio(
                                aspectRatio: AppConsts.aspect40on1,
                              ),

                              ///Password
                              _authMode == AuthMode.ResetPassword
                                  ? Container()
                                  : CustomTextFormField(
                                      perfixIcon: HandleImageWidget(
                                          image: AppAssets.lock),
                                      hint: StringsEn.password,
                                      obscureText: visible,
                                      onChanged: (String? value) =>
                                          password = value,
                                    ),
                              _authMode == AuthMode.Login
                                  ?

                                  ///remeber me
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const RemeberMeWidget(),
                                        SizedBox(width: size.width * .2.w),
                                        TextButton(
                                          onPressed: () => setState(
                                            () => _authMode =
                                                AuthMode.ResetPassword,
                                          ),
                                          child: Text(
                                            StringsEn.forgotPass,
                                            style: AppConsts.style14.copyWith(
                                              color: AppConsts.primary500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const AspectRatio(aspectRatio: AppConsts.aspect16on4),

                  ///already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _authMode == AuthMode.ResetPassword
                            ? StringsEn.youRemeberYourPassword
                            : _authMode == AuthMode.Login
                                ? StringsEn.dontHaveAccount
                                : StringsEn.alreadyHaveAccount,
                        style: AppConsts.style14,
                      ),
                      TextButton(
                        onPressed: () => _switchAuthMode(),
                        child: Text(
                          _authMode == AuthMode.Login &&
                                  _authMode != AuthMode.ResetPassword
                              ? StringsEn.register
                              : StringsEn.login,
                          style: AppConsts.style14.copyWith(
                            color: AppConsts.primary500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  ///Create account or login or reset pass
                  AspectRatio(
                    aspectRatio: AppConsts.aspectRatioButtonAuth.sp,
                    child: Visibility(
                      visible: !isLoading,
                      replacement: const LoadingWidget(),
                      child: CustomButton(
                        text: _authMode == AuthMode.ResetPassword
                            ? StringsEn.requestPass
                            : _authMode == AuthMode.Login
                                ? StringsEn.login
                                : StringsEn.createAccount,
                        onTap: () {
                          ///create account
                          if (_formKey.currentState!.validate()) {
                            _authMode == AuthMode.ResetPassword
                                ? requestPass()
                                : _authMode == AuthMode.SignUp
                                    ? register()
                                    : login();
                            if (controller.isAnimating) {
                              controller.stop();
                              controller.reset();
                            }
                          } else {
                            if (!controller.isAnimating) {
                              controller
                                ..forward()
                                ..repeat();
                            }
                          }
                          Future.delayed(
                            const Duration(milliseconds: 500),
                            () {
                              controller.stop();
                              controller.reset();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  const AspectRatio(aspectRatio: AppConsts.aspect40on1),
                  _authMode == AuthMode.ResetPassword
                      ? Container()
                      : Column(
                          children: [
                            ///or sign up with account
                            OrSignUpOrSignInWithAccountWidget(
                              label: _authMode == AuthMode.Login
                                  ? StringsEn.orLoginWithAccount
                                  : StringsEn.orSignUp,
                            ),
                            const AspectRatio(
                                aspectRatio: AppConsts.aspect40on1),
                            const SignWithGoogleAndFaceBookWidget(),
                          ],
                        ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is RegisterLoading || state is LoginLoading) {
          isLoading = true;
        } else if (state is RegisterLoaded || state is LoginLoaded) {
          isLoading = false;
          navigateToAnotherPage();
        } else if (state is RegisterFailure) {
          isLoading = false;
          showSnack(
            context,
            message: state.message,
            background: AppConsts.danger500,
          );
        } else if (state is LoginFailure) {
          isLoading = false;
          showSnack(
            context,
            message: state.message,
            background: AppConsts.danger500,
          );
        }
      },
    );
  }

//login
  login() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(email: email!, password: password!),
    );
  }

  //register
  register() {
    BlocProvider.of<AuthBloc>(context).add(
      RegisterEvent(
        name: name!,
        email: email!,
        password: password!,
      ),
    );
  }

  requestPass() {
    navigateToAnotherPage();
  }

  //navigate to another page
  navigateToAnotherPage() async {
    await Future.delayed(Duration(seconds: 1));
    GoRouter.of(context).pushReplacement(
      _authMode == AuthMode.ResetPassword
          ? createPassPath
          : _authMode == AuthMode.Login
              ? homePath
              : interestedInWorkPath,
      extra: {
        StringsEn.icon: AppAssets.resetPassIcon,
        StringsEn.title: StringsEn.checkYourEmail,
        StringsEn.subTitle: StringsEn.weHaveSentAresetPassword,
        StringsEn.labelButton: StringsEn.openEmailApp,
        StringsEn.path: createPassPath,
      },
    );
  }
}
