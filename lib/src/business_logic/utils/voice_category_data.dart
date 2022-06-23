class VoiceCategoryData {
  static iconOf(String code) {
    return data[code]?['icon'] ?? '?';
  }

  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'VoiceCategoryCode.voicecategory0001': {
      'name': '친목/수다',
      'icon': '\u{1F46C}'
    },
    'VoiceCategoryCode.voicecategory0002': {
      'name': '고민상담',
      'icon': '\u{1F64F}'
    },
    'VoiceCategoryCode.voicecategory0003': {'name': '토론', 'icon': '\u{1F64B}'},
    'VoiceCategoryCode.voicecategory0004': {'name': '연애', 'icon': '\u{1F496}'},
    'VoiceCategoryCode.voicecategory0005': {'name': '학교생활', 'icon': '\u{26EA}'},
    'VoiceCategoryCode.voicecategory0006': {
      'name': '취업/진로',
      'icon': '\u{1F340}'
    },
    'VoiceCategoryCode.voicecategory0007': {'name': '기타', 'icon': '\u{2B50}'},
    'voicecategory0001': {'name': '친목/수다', 'icon': '\u{1F46C}'},
    'voicecategory0002': {'name': '고민상담', 'icon': '\u{1F64F}'},
    'voicecategory0003': {'name': '토론', 'icon': '\u{1F64B}'},
    'voicecategory0004': {'name': '연애', 'icon': '\u{1F496}'},
    'voicecategory0005': {'name': '학교생활', 'icon': '\u{26EA}'},
    'voicecategory0006': {'name': '취업/진로', 'icon': '\u{1F340}'},
    'voicecategory0007': {'name': '기타', 'icon': '\u{2B50}'},
  };
}
