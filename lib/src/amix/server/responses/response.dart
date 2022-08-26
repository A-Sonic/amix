import 'dart:io';

///[AmixResponse] will be your Server Response
class AmixResponse {
  /// This function will start on response Time.
  ///
  /// you can send your response inside this function.
  ///
  /// **Warning**:
  ///
  /// *Please don't make your calculations inside this function
  /// otherwise your Server gonna Be Slow*
  final void Function(HttpResponse) response;

  ///[AmixResponse] will be your Server Response
  const AmixResponse({required this.response});
}
