import 'package:json_annotation/json_annotation.dart';

part 'ErrorResponse.g.dart';

@JsonSerializable()
class ErrorResponse {
  @JsonKey(name:'code')
  int errorCode;

  @JsonKey(name:'message')
  String errorMessage;

  ErrorResponse({this.errorCode, this.errorMessage});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}