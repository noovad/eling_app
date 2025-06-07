import 'package:logger/logger.dart';
import 'package:eling/core/utils/result.dart';

abstract class BaseUsecase<Request, Response> {
  final Logger logger;

  const BaseUsecase({required this.logger});

  final usecaseName = 'BaseUsecase';

  Future<Result> execute(Request request);

  Future<Result<Response>> safeExecute(
    Request request,
    Future<Response> Function() onExecute,
  ) async {
    try {
      // logger.i('$usecaseName.execute request: $request');

      final result = await onExecute();

      // logger.i('$usecaseName.execute result: $result');

      return Result.success(result);
    } on Exception catch (e) {
      // logger.e('$usecaseName.execute error: $e');

      return Result.failure(e.toString());
    }
  }
}

class NoRequest {
  @override
  String toString() {
    return 'NoRequest';
  }
}
