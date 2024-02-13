import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/consts/strings.dart';
import 'package:jobsque/core/widgets/custom_loading_suggested_job.dart';
import 'package:jobsque/core/widgets/empty_widget.dart';
import 'package:jobsque/core/widgets/error_widget.dart';
import 'package:jobsque/core/widgets/fading_list_view.dart';
import 'package:jobsque/features/home/presentation/view/widgets/loading_listview_fading.dart';
import 'package:jobsque/features/home/presentation/view_models/home_bloc/home_bloc.dart';

import '../../../../../core/consts/assets.dart';
import '../../../../../core/models/job_model/job_model.dart';
import 'suggested_or_recent_jobs_listview.dart';

class SectionSuggestedOrRecentJopsListViewBlocBuilder extends StatelessWidget {
  const SectionSuggestedOrRecentJopsListViewBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is GetJobsLoaded) {
          List<Job> jobs = state.jobs;
          return jobs.isEmpty
              ? EmptyWidget(
                  icon: AppAssets.savedIlus,
                  title: StringsEn.noThingHasBeenSaved,
                  subTitle: StringsEn.pressTheStarIcon,
                )
              : Expanded(
                  child: SuggestedOrRecentJobsListView(jobs: jobs),
                );
        } else if (state is GetJobsFailure) {
          return ErrorWidg(message: state.message);
        } else {
          return CustomFadingLoadingAnimation(
            widget: FadingListView(
              scrollDirc: Axis.vertical,
              widget: CustomLoadingSuggestedJob(),
            ),
          );
        }
      },
    );
  }
}
