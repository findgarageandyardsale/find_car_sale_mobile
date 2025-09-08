import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../shared/exceptions/http_exception.dart';
part 'formz_state.freezed.dart';

@freezed
abstract class FormzState<T> with _$FormzState<T> {
  const factory FormzState.initial() = Initial;
  const factory FormzState.loading() = Loading;
  const factory FormzState.failure(AppException exception) = Failure;
  const factory FormzState.success({T? data}) = Success;
}
