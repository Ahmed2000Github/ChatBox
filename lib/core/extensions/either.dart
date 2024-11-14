import 'package:dartz/dartz.dart';

extension EitherExtension on Either {
  T toStateWithDefault<T>(T state, T Function(dynamic) onFailure) {
    return this.fold(onFailure, (_) => state);
  }

  T toStateWithHandlers<T>(
      T Function(dynamic) onSuccess, T Function(dynamic) onFailure) {
    return this.fold(onFailure, onSuccess);
  }
}
