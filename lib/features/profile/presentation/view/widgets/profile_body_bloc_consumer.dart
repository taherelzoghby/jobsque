import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/consts/strings.dart';
import 'package:jobsque/core/consts/style.dart';
import 'package:jobsque/core/helper/custom_snack.dart';
import 'package:jobsque/core/widgets/error_widget.dart';
import 'package:jobsque/features/auth/data/models/user_login/user.dart';
import 'package:jobsque/features/profile/presentation/view/widgets/custom_fading_profile.dart';
import 'package:jobsque/features/profile/presentation/view_model/profile_cubit/profile_cubit.dart';

import '../../../../home/presentation/view/widgets/loading_listview_fading.dart';
import 'profile_body.dart';

class ProfileBodyBlocConsumer extends StatelessWidget {
  const ProfileBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext contextParent) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is GetProfileFailure) {
          return ErrorWidg(message: state.message);
        } else if (state is GetProfileSuccess) {
          User user = state.userProfileModel;
          return ProfileBody(
            user: user,
            ctx: contextParent,
            isSignOutStateLoading: state is SignOutLoading,
          );
        } else {
          return const CustomFadingLoadingAnimation(
            widget: CustomFadingProfile(),
          );
        }
      },
      listener: (context, state) {
        if (state is GetProfileFailure) {
          showSnack(
            context,
            message: state.message,
            background: AppConsts.danger500,
          );
        } else if (state is SignOutFailure) {
          showSnack(
            context,
            message: StringsEn.someThingError,
            background: AppConsts.danger500,
          );
        } else if (state is SignOutSucess) {
          showSnack(context, message: StringsEn.signOutSuccess);
        }
      },
    );
  }
}
