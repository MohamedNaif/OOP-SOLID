import 'package:solid_and_oop/core/results/result.dart';
import 'package:solid_and_oop/core/usecases/usecase.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/entities/report.dart';
import 'package:solid_and_oop/features/ahwa_management/domain/repositories/order_repository.dart';

class GenerateReports extends UseCase<DailyReport, GenerateReportsParams> {
  final OrderRepository repository;

  GenerateReports(this.repository);

  @override
  Future<Result<DailyReport>> call(GenerateReportsParams params) async {
    return await repository.generateDailyReport(params.date);
  }
}

class GenerateReportsParams {
  final DateTime date;
  GenerateReportsParams({required this.date});
}
