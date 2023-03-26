class College {
  final String collegeName;
  final String campusName;
  final double collegeSeq;

  College({required this.collegeName, required this.campusName, required this.collegeSeq});

  factory College.fromJson(Map<String, dynamic> json) {
    return College(
      collegeName: json['schoolName'],
      campusName: json['campusName'],
      collegeSeq: double.parse(json['seq'])
      );
  }
}