class CategoryData {
  static iconOf(String code) {
    return data[code]?['icon'] ?? '?';
  }

  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'c0001': {'name': '친목/일상', 'icon': '\u{1F601}'},
    'c0002': {'name': '문화', 'icon': '\u{1F1F7}'},
    'c0003': {'name': '암호화폐', 'icon': '\u{1F4B5}'},
    'c0004': {'name': '워홀', 'icon': '\u{2708}'},
    'c0005': {'name': '진로상담', 'icon': '\u{2600}'},
    'c0006': {'name': '한달살기', 'icon': '\u{1F308}'},
    'c0007': {'name': '게임', 'icon': '\u{1F3AE}'},
    'c0008': {'name': '오버워치', 'icon': '\u{1F525}'},
    'c0009': {'name': '배그', 'icon': '\u{1F52B}'},
    'c0010': {'name': '맛집투어', 'icon': '\u{1F372}'},
    'c0011': {'name': '연애', 'icon': '\u{1F493}'},
    'c0012': {'name': '친구찾기', 'icon': '\u{1F481}'},
  };
}
