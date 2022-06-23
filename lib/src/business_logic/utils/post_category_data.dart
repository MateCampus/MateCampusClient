class PostCategoryData {
  static iconOf(String code) {
    return data[code]?['icon'] ?? '?';
  }

  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'PostCategoryCode.postcategory0001': {'name': '일상', 'icon': '\u{1F601}'},
    'PostCategoryCode.postcategory0002': {'name': '연애', 'icon': '\u{1F496}'},
    'PostCategoryCode.postcategory0003': {'name': '고민상담', 'icon': '\u{1F64F}'},
    'PostCategoryCode.postcategory0004': {'name': '꿀팁', 'icon': '\u{1F50E}'},
    'PostCategoryCode.postcategory0005': {'name': '토론', 'icon': '\u{1F64B}'},
    'PostCategoryCode.postcategory0006': {'name': '정보', 'icon': '\u{1F4DA}'},
    'PostCategoryCode.postcategory0007': {'name': '학교생활', 'icon': '\u{26EA}'},
    'PostCategoryCode.postcategory0008': {'name': '맛집', 'icon': '\u{1F370}'},
    'PostCategoryCode.postcategory0009': {'name': '게임', 'icon': '\u{1F3AE}'},
    'PostCategoryCode.postcategory0010': {'name': '취업', 'icon': '\u{1F340}'},
    'PostCategoryCode.postcategory0011': {'name': '진로', 'icon': '\u{1F680}'},
    'postcategory0001': {'name': '일상', 'icon': '\u{1F601}'},
    'postcategory0002': {'name': '연애', 'icon': '\u{1F496}'},
    'postcategory0003': {'name': '고민상담', 'icon': '\u{1F64F}'},
    'postcategory0004': {'name': '꿀팁', 'icon': '\u{1F50E}'},
    'postcategory0005': {'name': '토론', 'icon': '\u{1F64B}'},
    'postcategory0006': {'name': '정보', 'icon': '\u{1F4DA}'},
    'postcategory0007': {'name': '학교생활', 'icon': '\u{26EA}'},
    'postcategory0008': {'name': '맛집', 'icon': '\u{1F370}'},
    'postcategory0009': {'name': '게임', 'icon': '\u{1F3AE}'},
    'postcategory0010': {'name': '취업', 'icon': '\u{1F340}'},
    'postcategory0011': {'name': '진로', 'icon': '\u{1F680}'},
  };
}
