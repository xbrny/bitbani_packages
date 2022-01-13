class Result<T> {
  final ResultStatus status;
  final String? message;
  final T? data;

  const Result({
    required this.status,
    this.message,
    this.data,
  });

  factory Result.idle() => const Result(status: ResultStatus.idle);
  factory Result.loading() => const Result(status: ResultStatus.loading);
  factory Result.success(T data) =>
      Result(status: ResultStatus.success, data: data);
  factory Result.error(String message) =>
      Result(status: ResultStatus.error, message: message.toString());

  bool get isIdle => status == ResultStatus.idle;
  bool get isLoading => status == ResultStatus.loading;
  bool get isSuccess => status == ResultStatus.success;
  bool get isError => status == ResultStatus.error;

  @override
  String toString() {
    return 'Result{status: $status, message: $message, data: $data}';
  }
}

enum ResultStatus {
  idle,
  loading,
  success,
  error,
}
