class MajorData {
  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'major0000': {'name': '', 'icon': '\u{1F601}'},
    'major0001': {'name': '경영학과', 'icon': '\u{1F601}'},
    'major0002': {'name': '소프트웨어과', 'icon': '\u{1F1F7}'},
    'major0003': {'name': '산업디자인과', 'icon': '\u{1F4B5}'},
    'major0004': {'name': '컴퓨터공학과', 'icon': '\u{2708}'},
    'major0005': {'name': '화학공학과', 'icon': '\u{2600}'},
    'major0006': {'name': '전자전기과', 'icon': '\u{1F308}'},
    'major0007': {'name': '기계공학과', 'icon': '\u{1F308}'},
  };
}
