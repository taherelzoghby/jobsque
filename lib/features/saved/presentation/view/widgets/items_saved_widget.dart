import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/consts/assets.dart';
import 'package:jobsque/core/consts/routesPage.dart';
import 'package:jobsque/core/consts/strings.dart';
import 'package:jobsque/core/consts/style.dart';
import 'package:jobsque/core/helper/share.dart';
import 'package:jobsque/core/models/job_model/job_model.dart';
import 'package:jobsque/core/widgets/tile_widget.dart';
import 'package:jobsque/features/home/presentation/view_models/saved_cubit/saved_cubit.dart';
import 'package:jobsque/features/saved/presentation/view/widgets/item_saved_jop.dart';

import '../../../../../core/widgets/custom_button_three_widget.dart';

class ItemsSavedWidget extends StatelessWidget {
  const ItemsSavedWidget({
    super.key,
    required this.savedList,
  });
  final List<Job> savedList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SavedCubit bloc = BlocProvider.of<SavedCubit>(context);

    ///show setting jop
    _showSettingJopSheet(BuildContext context, {required Job job}) {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            height: size.height * .3.h,
            width: double.infinity,
            decoration: AppConsts.decorationSheet,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
                horizontal: 20.w,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(child: SvgPicture.asset(AppAssets.line)),
                  //apply job
                  CustomButtonThreeWidget(
                    leading: Icon(FontAwesomeIcons.briefcase),
                    title: StringsEn.applyJob,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () => GoRouter.of(context).push(
                      applyJopPath,
                      extra: {
                        StringsEn.status: StringsEn.notOpen,
                        StringsEn.jobId: job.id.toString(),
                      },
                    ),
                  ),
                  //share
                  CustomButtonThreeWidget(
                    leading: Icon(FontAwesomeIcons.share),
                    title: StringsEn.shareVia,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () => share(text: 'welcome', subject: 'taher'),
                  ),
                  //unsave
                  CustomButtonThreeWidget(
                    leading: Icon(FontAwesomeIcons.bookmark),
                    title: StringsEn.cancelSave,
                    trailing: Icons.arrow_forward_ios,
                    onTap: () {
                      bloc.deleteJobFromSavedBoxHive(job: job);
                      GoRouter.of(context).pop();
                    },
                  ),
                  SizedBox(height: size.height * .03.h),
                ],
              ),
            ),
          );
        },
      );
    }

    return Column(
      children: [
        //(number) Job Saved
        SizedBox(
          height: size.height * .04.h,
          child: TileWidget(
            label: "${savedList.length}${StringsEn.jobSaved}",
            textAlign: TextAlign.center,
          ),
        ),

        ///jop saved
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ItemSavedJop(
                  job: savedList[index],
                  onTapTrailing: () => _showSettingJopSheet(
                    context,
                    job: savedList[index],
                  ),
                );
              },
              itemCount: savedList.length,
              separatorBuilder: (BuildContext context, int index) =>
                  Divider(color: AppConsts.neutral200),
            ),
          ),
        ),
      ],
    );
  }
}
