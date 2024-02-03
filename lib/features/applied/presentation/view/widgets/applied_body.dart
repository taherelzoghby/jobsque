import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jobsque/core/consts/routesPage.dart';
import 'package:jobsque/core/consts/strings.dart';
import 'package:jobsque/core/widgets/custom_app_bar.dart';
import 'jobs.dart';

class AppliedBody extends StatelessWidget {
  const AppliedBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          SizedBox(height: size.height * .02.h),
          CustomAppBar(
            leadingOnTap: () => GoRouter.of(context).pushReplacement(homePath),
            title: StringsEn.appliedJob,
            trailingWidget: Container(),
          ),
          SizedBox(height: size.height * .02.h),
          //jobs
          SizedBox(
            height: size.height * .8.h,
            child: Jobs(),
          ),
        ],
      ),
    );
  }
}
