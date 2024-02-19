import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jobsque/core/consts/style.dart';
import 'package:jobsque/core/helper/custom_snack.dart';
import 'package:jobsque/core/models/user_profile_model/portfolio.dart';
import 'package:jobsque/core/widgets/small_loading_widget.dart';
import 'package:jobsque/features/job_detail/presentation/view/widgets/cv_widget.dart';
import 'package:jobsque/features/job_detail/presentation/view/widgets/initial_cv_widget.dart';
import 'package:jobsque/features/profile/presentation/view/portfolio/presentation/view_models/portfolio_cubit/portfolio_cubit.dart';

class Portfolios extends StatelessWidget {
  const Portfolios({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit, PortfolioState>(
      builder: (context, state) {
        if (state is GetFilesLoading) {
          return const LoadingWidget();
        } else if (state is GetFilesSuccess) {
          List<PortfolioModel>? cvs = state.cvs;
          return Center(
            child: cvs!.isEmpty
                ? InitialCvWidget()
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => CvWidget(
                      name: cvs[index].cvFile!,
                    ),
                    itemCount: cvs.length,
                  ),
          );
        }
        return Center(child: InitialCvWidget());
      },
      listener: (context, state) {
        if (state is GetFilesFailure) {
          showSnack(
            context,
            message: state.message,
            background: AppConsts.danger500,
          );
        }
      },
    );
  }
}
