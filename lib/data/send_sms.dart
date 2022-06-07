import 'package:json_annotation/json_annotation.dart';

part 'send_sms.g.dart';

@JsonSerializable()
class SendSms {
  final bool isDone;
  final String data;

  SendSms(this.isDone, this.data);

  factory SendSms.fromJson(Map<String, dynamic> json) => _$SendSmsFromJson(json);

  Map<String, dynamic> toJson() => _$SendSmsToJson(this);
}