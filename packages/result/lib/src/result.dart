class Result<T> {
  final _ResultStatus status;
  final String? message;
  final T? data;

  const Result({
    required this.status,
    this.message,
    this.data,
  });

  factory Result.idle() => const Result(status: _ResultStatus.idle);
  factory Result.loading() => const Result(status: _ResultStatus.loading);
  factory Result.success(T data) =>
      Result(status: _ResultStatus.success, data: data);
  factory Result.error(String message) =>
      Result(status: _ResultStatus.error, message: message.toString());

  bool get isIdle => status == _ResultStatus.idle;
  bool get isLoading => status == _ResultStatus.loading;
  bool get isSuccess => status == _ResultStatus.success;
  bool get isError => status == _ResultStatus.error;

  @override
  String toString() {
    return 'Result{status: $status, message: $message, data: $data}';
  }
}

enum _ResultStatus {
  idle,
  loading,
  success,
  error,
}
