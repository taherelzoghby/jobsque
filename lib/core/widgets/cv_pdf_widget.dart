import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:jobsque/core/consts/assets.dart';
import 'package:jobsque/core/consts/style.dart';

class CvPdfWidget extends StatelessWidget {
  const CvPdfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.w),
      child: Container(
        height: size.height * .1.h,
        decoration: AppConsts.decorationRadius8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //logo pdf
              SvgPicture.asset(AppAssets.pdfLogo),
              Spacer(flex: 1),
              //pdf info
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Taher.cv',
                    style: AppConsts.style14.copyWith(
                      color: AppConsts.neutral900,
                    ),
                  ),
                  Text(
                    'CV.pdf 300KB',
                    style: AppConsts.style12.copyWith(
                      color: AppConsts.neutral500,
                    ),
                  ),
                ],
              ),
              Spacer(flex: 6),
              //edit
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit_sharp, color: AppConsts.primary500),
              ),
              //delete
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.circleXmark,
                  color: AppConsts.danger500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
