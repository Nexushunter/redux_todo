// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      name: json['name'] as String,
      visible: json['visible'] as bool,
      selected: json['selected'] as bool,
      body: json['body'] as String,
      timeOfDay: json['timeOfDay'] as int,
      uuid: json['uuid'] as String,
      favourite: json['favourite'] as bool,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'name': instance.name,
      'visible': instance.visible,
      'selected': instance.selected,
      'body': instance.body,
      'timeOfDay': instance.timeOfDay,
      'uuid': instance.uuid,
      'favourite': instance.favourite,
    };
