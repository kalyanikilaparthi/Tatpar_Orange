// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'drug_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DrugModel _$DrugModelFromJson(Map<String, dynamic> json) {
  return _DrugModel.fromJson(json);
}

/// @nodoc
mixin _$DrugModel {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DrugModelCopyWith<DrugModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DrugModelCopyWith<$Res> {
  factory $DrugModelCopyWith(DrugModel value, $Res Function(DrugModel) then) =
      _$DrugModelCopyWithImpl<$Res, DrugModel>;
  @useResult
  $Res call({int? id, String? name, String? description});
}

/// @nodoc
class _$DrugModelCopyWithImpl<$Res, $Val extends DrugModel>
    implements $DrugModelCopyWith<$Res> {
  _$DrugModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DrugModelImplCopyWith<$Res>
    implements $DrugModelCopyWith<$Res> {
  factory _$$DrugModelImplCopyWith(
          _$DrugModelImpl value, $Res Function(_$DrugModelImpl) then) =
      __$$DrugModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? name, String? description});
}

/// @nodoc
class __$$DrugModelImplCopyWithImpl<$Res>
    extends _$DrugModelCopyWithImpl<$Res, _$DrugModelImpl>
    implements _$$DrugModelImplCopyWith<$Res> {
  __$$DrugModelImplCopyWithImpl(
      _$DrugModelImpl _value, $Res Function(_$DrugModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? description = freezed,
  }) {
    return _then(_$DrugModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DrugModelImpl implements _DrugModel {
  const _$DrugModelImpl({this.id, this.name, this.description});

  factory _$DrugModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DrugModelImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;

  @override
  String toString() {
    return 'DrugModel(id: $id, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DrugModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DrugModelImplCopyWith<_$DrugModelImpl> get copyWith =>
      __$$DrugModelImplCopyWithImpl<_$DrugModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DrugModelImplToJson(
      this,
    );
  }
}

abstract class _DrugModel implements DrugModel {
  const factory _DrugModel(
      {final int? id,
      final String? name,
      final String? description}) = _$DrugModelImpl;

  factory _DrugModel.fromJson(Map<String, dynamic> json) =
      _$DrugModelImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$DrugModelImplCopyWith<_$DrugModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
