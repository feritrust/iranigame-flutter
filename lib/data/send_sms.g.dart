// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendSms _$SendSmsFromJson(Map<String, dynamic> json) => SendSms(
      json['isDone'] as bool,
      json['data'] as String,
    );

Map<String, dynamic> _$SendSmsToJson(SendSms instance) => <String, dynamic>{
      'isDone': instance.isDone,
      'data': instance.data,
    };
