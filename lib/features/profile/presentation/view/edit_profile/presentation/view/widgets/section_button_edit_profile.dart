

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/consts/routesPage.dart';
import 'package:jobsque/core/consts/strings.dart';
import 'package:jobsque/core/consts/style.dart';
import 'package:jobsque/core/helper/custom_snack.dart';
import 'package:jobsque/core/widgets/customButton.dart';
import 'package:jobsque/core/widgets/small_loading_widget.dart';
import 'package:jobsque/features/profile/presentation/view/edit_profile/presentation/view_models/edit_profile_cubit/edit_profile_cubit.dart';

class SectionButtonEditProfile extends StatefulWidget {
  const SectionButtonEditProfile({
    super.key,
  });

  @override
  State<SectionButtonEditProfile> createState() => _SectionButtonEditProfileState();
}

class _SectionButtonEditProfileState extends State<SectionButtonEditProfile> {
  bool isLoad = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: AppConsts.aspectRatioButtonAuth,
        child: BlocConsumer<EditProfileCubit, EditProfileState>(
          builder: (context, state) {
            return Visibility(
              visible: !isLoad,
              replacement: LoadingWidget(),
              child: CustomButton(
                text: StringsEn.save,
                onTap: () async {
                  await BlocProvider.of<EditProfileCubit>(context).save();
                },
              ),
            );
          },
          listener: (context, state) {
            if (state is SavedLoading) {
              isLoad = true;
            } else if (state is SavedSuccess) {
              isLoad = false;
              GoRouter.of(context).pushReplacement(
                homePath,
                extra: 4,
              );
            } else if (state is SavedFailure) {
              isLoad = false;
              showSnack(
                context,
                message: StringsEn.someThingError,
                background: AppConsts.danger500,
              );
            }
          },
        ),
      ),
    );
  }
}
