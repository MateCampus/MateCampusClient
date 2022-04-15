class InterestData {
  static iconOf(String code) {
    return data[code]?['icon'] ?? '?';
  }

  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'i0001': {'name': '친목/일상', 'icon': '\u{1F601}'},
    'i0002': {'name': '문화', 'icon': '\u{1F1F7}'},
    'i0003': {'name': '암호화폐', 'icon': '\u{1F4B5}'},
    'i0004': {'name': '워홀', 'icon': '\u{2708}'},
    'i0005': {'name': '진로상담', 'icon': '\u{2600}'},
    'i0006': {'name': '한달살기', 'icon': '\u{1F308}'},
    'i0007': {'name': '게임', 'icon': '\u{1F3AE}'},
    'i0008': {'name': '오버워치', 'icon': '\u{1F525}'},
    'i0009': {'name': '배그', 'icon': '\u{1F52B}'},
    'i0010': {'name': '연애', 'icon': '\u{1F372}'},
    'i0011': {'name': '맛집투어', 'icon': '\u{1F493}'},
    'i0012': {'name': '카페투어', 'icon': '\u{1F481}'},
    'i0013': {'name': '치느님', 'icon': '\u{1F357}'},
    'i0014': {'name': '다이어트', 'icon': '\u{1F957}'},
    'i0015': {'name': '공부', 'icon': '\u{1F4D6}'},
    'i0016': {'name': '미술/예술', 'icon': '\u{1F3A8}'},
  };
}
