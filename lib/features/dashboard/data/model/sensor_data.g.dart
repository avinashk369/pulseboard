// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SensorData _$SensorDataFromJson(Map<String, dynamic> json) => _SensorData(
      id: json['id'] as String?,
      name: json['name'] as String?,
      location: json['location'] as String?,
      temperature: (json['temperature'] as num?)?.toDouble(),
      humidity: (json['humidity'] as num?)?.toDouble(),
      pressure: (json['pressure'] as num?)?.toDouble(),
      anomalyLevel: (json['anomalyLevel'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      isOnline: json['isOnline'] as bool? ?? false,
    );

Map<String, dynamic> _$SensorDataToJson(_SensorData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'pressure': instance.pressure,
      'anomalyLevel': instance.anomalyLevel,
      'timestamp': instance.timestamp?.toIso8601String(),
      'isOnline': instance.isOnline,
    };
