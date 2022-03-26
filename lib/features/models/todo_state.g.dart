// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TodoState _$$_TodoStateFromJson(Map<String, dynamic> json) => _$_TodoState(
      todos: (json['todos'] as List<dynamic>)
          .map((e) => Todo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TodoStateToJson(_$_TodoState instance) =>
    <String, dynamic>{
      'todos': instance.todos,
    };
