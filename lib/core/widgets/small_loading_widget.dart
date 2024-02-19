import 'package:flutter/material.dart';
import 'package:jobsque/core/consts/style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CircularProgressIndicator(color: AppConsts.primary500),
    );
  }
}
