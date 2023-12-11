
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:jobsque/core/models/job_model.dart';
import 'package:jobsque/features/auth/data/models/failure_message.dart';
import 'package:jobsque/features/home/data/repo/home_repo.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  JobFilterRepo jobFilterRepo;

  HomeBloc({required this.jobFilterRepo}) : super(JobsInitial()) {
    on<HomeEvent>(
      (event, emit) async {
        if (event is GetJobsEvent) {
          //get all jobs
          emit(GetJobsLoading());
          Either<FailureMessage, List<Job>> result =
              await jobFilterRepo.filterJobs();
          result.fold(
            (failure) {
              emit(GetJobsFailure(message: failure.message!));
            },
            (jobs) {
              emit(GetJobsLoaded(jobs: jobs));
            },
          );
        }
      },
    );
  }
}
