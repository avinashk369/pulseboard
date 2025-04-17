// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sensor_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SensorData {
  String? get id;
  String? get name;
  String? get location;
  double? get temperature;
  double? get humidity;
  double? get pressure;
  double? get anomalyLevel;
  DateTime? get timestamp;
  bool? get isOnline;

  /// Create a copy of SensorData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SensorDataCopyWith<SensorData> get copyWith =>
      _$SensorDataCopyWithImpl<SensorData>(this as SensorData, _$identity);

  /// Serializes this SensorData to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SensorData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            (identical(other.anomalyLevel, anomalyLevel) ||
                other.anomalyLevel == anomalyLevel) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, location, temperature,
      humidity, pressure, anomalyLevel, timestamp, isOnline);

  @override
  String toString() {
    return 'SensorData(id: $id, name: $name, location: $location, temperature: $temperature, humidity: $humidity, pressure: $pressure, anomalyLevel: $anomalyLevel, timestamp: $timestamp, isOnline: $isOnline)';
  }
}

/// @nodoc
abstract mixin class $SensorDataCopyWith<$Res> {
  factory $SensorDataCopyWith(
          SensorData value, $Res Function(SensorData) _then) =
      _$SensorDataCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? location,
      double? temperature,
      double? humidity,
      double? pressure,
      double? anomalyLevel,
      DateTime? timestamp,
      bool? isOnline});
}

/// @nodoc
class _$SensorDataCopyWithImpl<$Res> implements $SensorDataCopyWith<$Res> {
  _$SensorDataCopyWithImpl(this._self, this._then);

  final SensorData _self;
  final $Res Function(SensorData) _then;

  /// Create a copy of SensorData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? location = freezed,
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? pressure = freezed,
    Object? anomalyLevel = freezed,
    Object? timestamp = freezed,
    Object? isOnline = freezed,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      temperature: freezed == temperature
          ? _self.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
      humidity: freezed == humidity
          ? _self.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double?,
      pressure: freezed == pressure
          ? _self.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double?,
      anomalyLevel: freezed == anomalyLevel
          ? _self.anomalyLevel
          : anomalyLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOnline: freezed == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _SensorData implements SensorData {
  const _SensorData(
      {this.id,
      this.name,
      this.location,
      this.temperature,
      this.humidity,
      this.pressure,
      this.anomalyLevel,
      this.timestamp,
      this.isOnline = false});
  factory _SensorData.fromJson(Map<String, dynamic> json) =>
      _$SensorDataFromJson(json);

  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? location;
  @override
  final double? temperature;
  @override
  final double? humidity;
  @override
  final double? pressure;
  @override
  final double? anomalyLevel;
  @override
  final DateTime? timestamp;
  @override
  @JsonKey()
  final bool? isOnline;

  /// Create a copy of SensorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SensorDataCopyWith<_SensorData> get copyWith =>
      __$SensorDataCopyWithImpl<_SensorData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SensorDataToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SensorData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.humidity, humidity) ||
                other.humidity == humidity) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            (identical(other.anomalyLevel, anomalyLevel) ||
                other.anomalyLevel == anomalyLevel) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, location, temperature,
      humidity, pressure, anomalyLevel, timestamp, isOnline);

  @override
  String toString() {
    return 'SensorData(id: $id, name: $name, location: $location, temperature: $temperature, humidity: $humidity, pressure: $pressure, anomalyLevel: $anomalyLevel, timestamp: $timestamp, isOnline: $isOnline)';
  }
}

/// @nodoc
abstract mixin class _$SensorDataCopyWith<$Res>
    implements $SensorDataCopyWith<$Res> {
  factory _$SensorDataCopyWith(
          _SensorData value, $Res Function(_SensorData) _then) =
      __$SensorDataCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? name,
      String? location,
      double? temperature,
      double? humidity,
      double? pressure,
      double? anomalyLevel,
      DateTime? timestamp,
      bool? isOnline});
}

/// @nodoc
class __$SensorDataCopyWithImpl<$Res> implements _$SensorDataCopyWith<$Res> {
  __$SensorDataCopyWithImpl(this._self, this._then);

  final _SensorData _self;
  final $Res Function(_SensorData) _then;

  /// Create a copy of SensorData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? location = freezed,
    Object? temperature = freezed,
    Object? humidity = freezed,
    Object? pressure = freezed,
    Object? anomalyLevel = freezed,
    Object? timestamp = freezed,
    Object? isOnline = freezed,
  }) {
    return _then(_SensorData(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _self.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      temperature: freezed == temperature
          ? _self.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as double?,
      humidity: freezed == humidity
          ? _self.humidity
          : humidity // ignore: cast_nullable_to_non_nullable
              as double?,
      pressure: freezed == pressure
          ? _self.pressure
          : pressure // ignore: cast_nullable_to_non_nullable
              as double?,
      anomalyLevel: freezed == anomalyLevel
          ? _self.anomalyLevel
          : anomalyLevel // ignore: cast_nullable_to_non_nullable
              as double?,
      timestamp: freezed == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isOnline: freezed == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

// dart format on
