import 'package:logger/logger.dart';
import 'package:onlinebozor/data/error/app_exception.dart';
import 'package:onlinebozor/presentation/support/extensions/extension_message_exts.dart';

class FutureHandler<T> {
  final Future<T> future;
  Function? _onStart;
  Function(T data)? _onSuccess;
  Function(AppException error)? _onError;
  Function? _onFinished;

  FutureHandler(this.future);

  FutureHandler<T> onStart(Function callback) {
    _onStart = callback;
    return this;
  }

  FutureHandler<T> onSuccess(Function(T data) callback) {
    _onSuccess = callback;
    return this;
  }

  FutureHandler<T> onError(Function(AppException error) callback) {
    _onError = callback;
    return this;
  }

  FutureHandler<T> onFinished(Function callback) {
    _onFinished = callback;
    return this;
  }

  Future<void> executeFuture() async {
    try {
      _onStart?.call();
      final result = await future;
      _onSuccess?.call(result);
    } catch (e, stackTrace) {
      Logger().w("executeFuture e = $e, stackTrace = $stackTrace");
      _onError?.call(e.toAppException(stackTrace));
    } finally {
      _onFinished?.call();
    }
  }
}