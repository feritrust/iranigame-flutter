import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class Data{
  final String token;


  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Data(this.token);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}