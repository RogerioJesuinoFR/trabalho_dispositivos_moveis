class IMCRecord {
  final double weight;
  final double height;
  final double imc;
  final DateTime date;

  IMCRecord({
    required this.weight,
    required this.height,
    required this.imc,
    required this.date,
  });

  Map<String, dynamic> toJson() => {
    'weight': weight,
    'height': height,
    'imc': imc,
    'date': date.toIso8601String(),
  };

  factory IMCRecord.fromJson(Map<String, dynamic> json) => IMCRecord(
    weight: json['weight'],
    height: json['height'],
    imc: json['imc'],
    date: DateTime.parse(json['date']),
  );
}
