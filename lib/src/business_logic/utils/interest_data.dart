enum InterestCode {
  interest0001,
  interest0002,
  interest0003,
  interest0004,
  interest0005,
  interest0006,
  interest0007,
  interest0008,
  interest0009,
  interest0010,
  interest0011,
  interest0012,
  interest0013,
  interest0014,
  interest0015,
  interest0016,
}

class InterestData {
  static iconOf(String code) {
    return data[code]?['icon'] ?? '?';
  }

  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'interest0001': {'name': '친목/일상', 'icon': '\u{1F601}'},
    'interest0002': {'name': '문화', 'icon': '\u{1F1F7}'},
    'interest0003': {'name': '암호화폐', 'icon': '\u{1F4B5}'},
    'interest0004': {'name': '워홀', 'icon': '\u{2708}'},
    'interest0005': {'name': '진로상담', 'icon': '\u{2600}'},
    'interest0006': {'name': '한달살기', 'icon': '\u{1F308}'},
    'interest0007': {'name': '게임', 'icon': '\u{1F3AE}'},
    'interest0008': {'name': '오버워치', 'icon': '\u{1F525}'},
    'interest0009': {'name': '배그', 'icon': '\u{1F52B}'},
    'interest0010': {'name': '연애', 'icon': '\u{1F372}'},
    'interest0011': {'name': '맛집투어', 'icon': '\u{1F493}'},
    'interest0012': {'name': '카페투어', 'icon': '\u{1F481}'},
    'interest0013': {'name': '치느님', 'icon': '\u{1F357}'},
    'interest0014': {'name': '다이어트', 'icon': '\u{1F957}'},
    'interest0015': {'name': '공부', 'icon': '\u{1F4D6}'},
    'interest0016': {'name': '미술/예술', 'icon': '\u{1F3A8}'},
  };
}
