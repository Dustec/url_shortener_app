// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'url_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UrlListState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<UrlAlias> get recentUrlsList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UrlListStateCopyWith<UrlListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlListStateCopyWith<$Res> {
  factory $UrlListStateCopyWith(
          UrlListState value, $Res Function(UrlListState) then) =
      _$UrlListStateCopyWithImpl<$Res, UrlListState>;
  @useResult
  $Res call({bool isLoading, List<UrlAlias> recentUrlsList});
}

/// @nodoc
class _$UrlListStateCopyWithImpl<$Res, $Val extends UrlListState>
    implements $UrlListStateCopyWith<$Res> {
  _$UrlListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recentUrlsList = null,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recentUrlsList: null == recentUrlsList
          ? _value.recentUrlsList
          : recentUrlsList // ignore: cast_nullable_to_non_nullable
              as List<UrlAlias>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UrlListStateCopyWith<$Res>
    implements $UrlListStateCopyWith<$Res> {
  factory _$$_UrlListStateCopyWith(
          _$_UrlListState value, $Res Function(_$_UrlListState) then) =
      __$$_UrlListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, List<UrlAlias> recentUrlsList});
}

/// @nodoc
class __$$_UrlListStateCopyWithImpl<$Res>
    extends _$UrlListStateCopyWithImpl<$Res, _$_UrlListState>
    implements _$$_UrlListStateCopyWith<$Res> {
  __$$_UrlListStateCopyWithImpl(
      _$_UrlListState _value, $Res Function(_$_UrlListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? recentUrlsList = null,
  }) {
    return _then(_$_UrlListState(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      recentUrlsList: null == recentUrlsList
          ? _value._recentUrlsList
          : recentUrlsList // ignore: cast_nullable_to_non_nullable
              as List<UrlAlias>,
    ));
  }
}

/// @nodoc

class _$_UrlListState implements _UrlListState {
  _$_UrlListState(
      {this.isLoading = false,
      final List<UrlAlias> recentUrlsList = const <UrlAlias>[]})
      : _recentUrlsList = recentUrlsList;

  @override
  @JsonKey()
  final bool isLoading;
  final List<UrlAlias> _recentUrlsList;
  @override
  @JsonKey()
  List<UrlAlias> get recentUrlsList {
    if (_recentUrlsList is EqualUnmodifiableListView) return _recentUrlsList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentUrlsList);
  }

  @override
  String toString() {
    return 'UrlListState(isLoading: $isLoading, recentUrlsList: $recentUrlsList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UrlListState &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._recentUrlsList, _recentUrlsList));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading,
      const DeepCollectionEquality().hash(_recentUrlsList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UrlListStateCopyWith<_$_UrlListState> get copyWith =>
      __$$_UrlListStateCopyWithImpl<_$_UrlListState>(this, _$identity);
}

abstract class _UrlListState implements UrlListState {
  factory _UrlListState(
      {final bool isLoading,
      final List<UrlAlias> recentUrlsList}) = _$_UrlListState;

  @override
  bool get isLoading;
  @override
  List<UrlAlias> get recentUrlsList;
  @override
  @JsonKey(ignore: true)
  _$$_UrlListStateCopyWith<_$_UrlListState> get copyWith =>
      throw _privateConstructorUsedError;
}
