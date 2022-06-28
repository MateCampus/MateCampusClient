class CollegeData {
  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  // icon를 학교 이미지로 변경 필요, 0000은 빈 값
  static final Map<String, Map<String, String>> data = {
    'college0000': {'name': '', 'image': '\u{1F601}'},
    'college0001': {'name': '단국대학교', 'image': '\u{1F601}'},
    'college0002': {'name': '건국대학교', 'image': '\u{1F1F7}'},
    'college0003': {'name': '동국대학교', 'image': '\u{1F4B5}'},
    'college0004': {'name': '홍익대학교', 'image': '\u{2708}'},
    'college0005': {'name': '중앙대학교', 'image': '\u{2600}'},
    'college0006': {'name': '경희대학교', 'image': '\u{1F308}'},
    'college0007': {'name': '한국외국어대학교', 'image': '\u{1F3AE}'},
  };
}
