// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ExerciseModel {
  String get id;
  String get name;
  String? get force;
  String? get level;
  String? get mechanic;
  String? get equipment;
  List<String>? get primaryMuscles;
  List<String>? get secondaryMuscles;
  List<String>? get instructions;
  String? get category;
  List<String>? get images;

  /// Create a copy of ExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ExerciseModelCopyWith<ExerciseModel> get copyWith =>
      _$ExerciseModelCopyWithImpl<ExerciseModel>(
          this as ExerciseModel, _$identity);

  /// Serializes this ExerciseModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as ExerciseModel;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExerciseModel &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.name, _this.name) || other.name == _this.name) &&
            (identical(other.force, _this.force) ||
                other.force == _this.force) &&
            (identical(other.level, _this.level) ||
                other.level == _this.level) &&
            (identical(other.mechanic, _this.mechanic) ||
                other.mechanic == _this.mechanic) &&
            (identical(other.equipment, _this.equipment) ||
                other.equipment == _this.equipment) &&
            const DeepCollectionEquality()
                .equals(other.primaryMuscles, _this.primaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other.secondaryMuscles, _this.secondaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other.instructions, _this.instructions) &&
            (identical(other.category, _this.category) ||
                other.category == _this.category) &&
            const DeepCollectionEquality().equals(other.images, _this.images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as ExerciseModel;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.name,
        _this.force,
        _this.level,
        _this.mechanic,
        _this.equipment,
        const DeepCollectionEquality().hash(_this.primaryMuscles),
        const DeepCollectionEquality().hash(_this.secondaryMuscles),
        const DeepCollectionEquality().hash(_this.instructions),
        _this.category,
        const DeepCollectionEquality().hash(_this.images));
  }

  @override
  String toString() {
    final _this = this as ExerciseModel;
    return 'ExerciseModel(id: ${_this.id}, name: ${_this.name}, force: ${_this.force}, level: ${_this.level}, mechanic: ${_this.mechanic}, equipment: ${_this.equipment}, primaryMuscles: ${_this.primaryMuscles}, secondaryMuscles: ${_this.secondaryMuscles}, instructions: ${_this.instructions}, category: ${_this.category}, images: ${_this.images})';
  }
}

/// @nodoc
abstract mixin class $ExerciseModelCopyWith<$Res> {
  factory $ExerciseModelCopyWith(
          ExerciseModel value, $Res Function(ExerciseModel) _then) =
      _$ExerciseModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String? force,
      String? level,
      String? mechanic,
      String? equipment,
      List<String>? primaryMuscles,
      List<String>? secondaryMuscles,
      List<String>? instructions,
      String? category,
      List<String>? images});
}

/// @nodoc
class _$ExerciseModelCopyWithImpl<$Res>
    implements $ExerciseModelCopyWith<$Res> {
  _$ExerciseModelCopyWithImpl(this._self, this._then);

  final ExerciseModel _self;
  final $Res Function(ExerciseModel) _then;

  /// Create a copy of ExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? force = freezed,
    Object? level = freezed,
    Object? mechanic = freezed,
    Object? equipment = freezed,
    Object? primaryMuscles = freezed,
    Object? secondaryMuscles = freezed,
    Object? instructions = freezed,
    Object? category = freezed,
    Object? images = freezed,
  }) {
    return _then(ExerciseModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      force: freezed == force
          ? _self.force
          : force // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      mechanic: freezed == mechanic
          ? _self.mechanic
          : mechanic // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: freezed == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryMuscles: freezed == primaryMuscles
          ? _self.primaryMuscles
          : primaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      secondaryMuscles: freezed == secondaryMuscles
          ? _self.secondaryMuscles
          : secondaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      instructions: freezed == instructions
          ? _self.instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ExerciseModel].
extension ExerciseModelPatterns on ExerciseModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_ExerciseModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_ExerciseModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_ExerciseModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String? force,
            String? level,
            String? mechanic,
            String? equipment,
            List<String>? primaryMuscles,
            List<String>? secondaryMuscles,
            List<String>? instructions,
            String? category,
            List<String>? images)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ExerciseModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.force,
            _that.level,
            _that.mechanic,
            _that.equipment,
            _that.primaryMuscles,
            _that.secondaryMuscles,
            _that.instructions,
            _that.category,
            _that.images);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String name,
            String? force,
            String? level,
            String? mechanic,
            String? equipment,
            List<String>? primaryMuscles,
            List<String>? secondaryMuscles,
            List<String>? instructions,
            String? category,
            List<String>? images)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseModel():
        return $default(
            _that.id,
            _that.name,
            _that.force,
            _that.level,
            _that.mechanic,
            _that.equipment,
            _that.primaryMuscles,
            _that.secondaryMuscles,
            _that.instructions,
            _that.category,
            _that.images);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String name,
            String? force,
            String? level,
            String? mechanic,
            String? equipment,
            List<String>? primaryMuscles,
            List<String>? secondaryMuscles,
            List<String>? instructions,
            String? category,
            List<String>? images)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ExerciseModel() when $default != null:
        return $default(
            _that.id,
            _that.name,
            _that.force,
            _that.level,
            _that.mechanic,
            _that.equipment,
            _that.primaryMuscles,
            _that.secondaryMuscles,
            _that.instructions,
            _that.category,
            _that.images);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ExerciseModel extends ExerciseModel {
  const _ExerciseModel(
      {required this.id,
      required this.name,
      this.force,
      this.level,
      this.mechanic,
      this.equipment,
      List<String>? primaryMuscles,
      List<String>? secondaryMuscles,
      List<String>? instructions,
      this.category,
      List<String>? images})
      : _primaryMuscles = primaryMuscles,
        _secondaryMuscles = secondaryMuscles,
        _instructions = instructions,
        _images = images,
        super._();
  factory _ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? force;
  @override
  final String? level;
  @override
  final String? mechanic;
  @override
  final String? equipment;
  final List<String>? _primaryMuscles;
  @override
  List<String>? get primaryMuscles {
    final value = _primaryMuscles;
    if (value == null) return null;
    if (_primaryMuscles is EqualUnmodifiableListView) return _primaryMuscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _secondaryMuscles;
  @override
  List<String>? get secondaryMuscles {
    final value = _secondaryMuscles;
    if (value == null) return null;
    if (_secondaryMuscles is EqualUnmodifiableListView)
      return _secondaryMuscles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _instructions;
  @override
  List<String>? get instructions {
    final value = _instructions;
    if (value == null) return null;
    if (_instructions is EqualUnmodifiableListView) return _instructions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? category;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of ExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExerciseModelCopyWith<_ExerciseModel> get copyWith =>
      __$ExerciseModelCopyWithImpl<_ExerciseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ExerciseModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExerciseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.force, force) || other.force == force) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.mechanic, mechanic) ||
                other.mechanic == mechanic) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            const DeepCollectionEquality()
                .equals(other.primaryMuscles, _primaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other.secondaryMuscles, _secondaryMuscles) &&
            const DeepCollectionEquality()
                .equals(other.instructions, _instructions) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other.images, _images));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        id,
        name,
        force,
        level,
        mechanic,
        equipment,
        const DeepCollectionEquality().hash(_primaryMuscles),
        const DeepCollectionEquality().hash(_secondaryMuscles),
        const DeepCollectionEquality().hash(_instructions),
        category,
        const DeepCollectionEquality().hash(_images));
  }

  @override
  String toString() {
    return 'ExerciseModel(id: $id, name: $name, force: $force, level: $level, mechanic: $mechanic, equipment: $equipment, primaryMuscles: $primaryMuscles, secondaryMuscles: $secondaryMuscles, instructions: $instructions, category: $category, images: $images)';
  }
}

/// @nodoc
abstract mixin class _$ExerciseModelCopyWith<$Res>
    implements $ExerciseModelCopyWith<$Res> {
  factory _$ExerciseModelCopyWith(
          _ExerciseModel value, $Res Function(_ExerciseModel) _then) =
      __$ExerciseModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String? force,
      String? level,
      String? mechanic,
      String? equipment,
      List<String>? primaryMuscles,
      List<String>? secondaryMuscles,
      List<String>? instructions,
      String? category,
      List<String>? images});
}

/// @nodoc
class __$ExerciseModelCopyWithImpl<$Res>
    implements _$ExerciseModelCopyWith<$Res> {
  __$ExerciseModelCopyWithImpl(this._self, this._then);

  final _ExerciseModel _self;
  final $Res Function(_ExerciseModel) _then;

  /// Create a copy of ExerciseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? force = freezed,
    Object? level = freezed,
    Object? mechanic = freezed,
    Object? equipment = freezed,
    Object? primaryMuscles = freezed,
    Object? secondaryMuscles = freezed,
    Object? instructions = freezed,
    Object? category = freezed,
    Object? images = freezed,
  }) {
    return _then(_ExerciseModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      force: freezed == force
          ? _self.force
          : force // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _self.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      mechanic: freezed == mechanic
          ? _self.mechanic
          : mechanic // ignore: cast_nullable_to_non_nullable
              as String?,
      equipment: freezed == equipment
          ? _self.equipment
          : equipment // ignore: cast_nullable_to_non_nullable
              as String?,
      primaryMuscles: freezed == primaryMuscles
          ? _self._primaryMuscles
          : primaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      secondaryMuscles: freezed == secondaryMuscles
          ? _self._secondaryMuscles
          : secondaryMuscles // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      instructions: freezed == instructions
          ? _self._instructions
          : instructions // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      category: freezed == category
          ? _self.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

// dart format on
