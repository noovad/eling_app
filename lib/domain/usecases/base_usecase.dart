import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:my_app/core/utils/result.dart';

abstract class BaseUsecase<Request, Response> {
  final Logger logger;

  const BaseUsecase({
    required this.logger,
  });

  final usecaseName = 'BaseUsecase';

  Future<Result> execute(Request request);

  Future<Result<Response>> safeExecute(
    Request request,
    Future<Response> Function() onExecute,
  ) async {
    try {
      logger.i('$usecaseName.execute request: $request');

      final result = await onExecute();

      logger.i('$usecaseName.execute result: $result');

      return Result.success(result);
    } on Exception catch (e) {
      logger.e('$usecaseName.execute error: $e');

      return Result.failure(e.toString());
    }
  }
}

void validateStatusCode(Response response) {
  final statusCode = response.statusCode ?? 0;

  if (statusCode >= 400 && statusCode < 500) {
    throw ClientException(response.data['message']);
  } else if (statusCode >= 500) {
    throw ServerException(response.data['message']);
  }
}

class NoRequest {
  @override
  String toString() {
    return 'NoRequest';
  }
}

class ClientException implements Exception {
  final String? message;

  ClientException(this.message);

  @override
  String toString() {
    return message ?? 'Terjadi kesalahan';
  }
}

class ServerException implements Exception {
  final String? message;

  ServerException(this.message);

  @override
  String toString() {
    return message ?? 'Terjadi kesalahan';
  }
}
