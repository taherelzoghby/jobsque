import 'package:flutter/material.dart';
import 'package:jobsque/features/job_detail/presentation/view/widgets/apply_jop_body.dart';

class ApplyJopView extends StatelessWidget {
  const ApplyJopView({super.key, required this.status});

  final String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ApplyJopBody(status: status),
      ),
    );
  }
}
