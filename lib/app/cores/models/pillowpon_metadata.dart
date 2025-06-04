class PillowponMetadata{
  double pressure;
  double accelerator;
  double humidity;
  double temperature;
  double body_detection;
  double photoresistor;
  double sound;
  double time;

  PillowponMetadata({
    required this.pressure,
    required this.accelerator,
    required this.humidity,
    required this.temperature,
    required this.body_detection,
    required this.photoresistor,
    required this.sound,
    required this.time,
  });

  factory PillowponMetadata.fromJson(Map<String, dynamic> json) {
    return PillowponMetadata(
      pressure: json['pressure']?.toDouble() ?? 0.0,
      accelerator: json['accelerator']?.toDouble() ?? 0.0,
      humidity: json['humidity']?.toDouble() ?? 0.0,
      temperature: json['temperature']?.toDouble() ?? 0.0,
      body_detection: json['body_detection']?.toDouble() ?? 0.0,
      photoresistor: json['photoresistor']?.toDouble() ?? 0.0,
      sound: json['sound']?.toDouble() ?? 0.0,
      time: json['time']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pressure': pressure.toString(),
      'accelerator': accelerator.toString(),
      'humidity': humidity.toString(),
      'temperature': temperature.toString(),
      'body_detection': body_detection.toString(),
      'photoresistor': photoresistor.toString(),
      'sound': sound.toString(),
      'time': time.toString(),
    };
  }
}