import 'package:json_annotation/json_annotation.dart';

part 'username.g.dart';

@JsonSerializable()
class Username{
  final bool isDone;
  final List<String> data;

  Username(this.isDone, this.data);

  factory Username.fromJson(Map<String, dynamic> json) => _$UsernameFromJson(json);

  Map<String, dynamic> toJson() => _$UsernameToJson(this);
}