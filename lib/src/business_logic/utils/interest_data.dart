class InterestData {
  static iconOf(String code) {
    return data[code]?['icon'] ?? '?';
  }

  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    ///
    'interest0001': {'name': 'INFP', 'icon': '\u{1F601}'},
    'interest0002': {'name': 'ISTJ', 'icon': '\u{1F4DA}'},
    'interest0003': {'name': 'ENTP', 'icon': '\u{2615}'},
    'interest0004': {'name': 'ENFP', 'icon': '\u{1F37B}'},
    'interest0005': {'name': 'ISFP', 'icon': '\u{1F3A4}'},

    ///
    'interest0006': {'name': 'INTJ', 'icon': '\u{1F3C3}'},
    'interest0007': {'name': 'ESTP', 'icon': '\u{1F3AE}'},
    'interest0008': {'name': 'ENFJ', 'icon': '\u{1F371}'},
    'interest0009': {'name': 'ENTJ', 'icon': '\u{1F52B}'},
    'interest0010': {'name': 'INFJ', 'icon': '\u{1F453}'},

    ///
    'interest0011': {'name': 'ISTP', 'icon': '\u{1F37A}'},
    'interest0012': {'name': 'ESFP', 'icon': '\u{1F481}'},
    'interest0013': {'name': 'ESTJ', 'icon': '\u{2708}'},
    'interest0014': {'name': 'INTP', 'icon': '\u{1F4F7}'},
    'interest0015': {'name': 'ISFJ', 'icon': '\u{1F4D6}'},

    ///
    'interest0016': {'name': 'ESFJ', 'icon': '\u{1F372}'},
    'interest0017': {'name': '운동', 'icon': '\u{1F496}'},
    'interest0018': {'name': '다이어트', 'icon': '\u{1F61C}'},
    'interest0019': {'name': '연애', 'icon': '\u{1F493}'},
    'interest0020': {'name': '여행', 'icon': '\u{1F392}'},

    ///
    'interest0021': {'name': '코딩', 'icon': '\u{1F490}'},
    'interest0022': {'name': '자기계발', 'icon': '\u{1F3AB}'},
    'interest0023': {'name': '아르바이트', 'icon': '\u{1F3AC}'},
    'interest0024': {'name': '휴학생', 'icon': '\u{1F46C}'},
    'interest0025': {'name': '편입', 'icon': '\u{1F450}'},

    ///
    'interest0026': {'name': '복수전공', 'icon': '\u{1F373}'},
    'interest0027': {'name': '새내기', 'icon': '\u{1F4B8}'},
    'interest0028': {'name': '취업', 'icon': '\u{1F4C8}'},
    'interest0029': {'name': '진로', 'icon': '\u{1F456}'},
    'interest0030': {'name': '공모전', 'icon': '\u{1F308}'},

    ///
    'interest0031': {'name': '스터디', 'icon': '\u{1F4BC}'},
    'interest0032': {'name': '주식', 'icon': '\u{1F3A7}'},
    'interest0033': {'name': '코인', 'icon': '\u{1F4BD}'},
    'interest0034': {'name': '자취', 'icon': '\u{1F3A5}'},
    'interest0035': {'name': '반려동물', 'icon': '\u{1F4FA}'},

    ///
    'interest0036': {'name': '독서', 'icon': '\u{1F483}'},
    'interest0037': {'name': '요리', 'icon': '\u{1F3A4}'},
    'interest0038': {'name': '패션', 'icon': '\u{1F4D2}'},
    'interest0039': {'name': '반려식물', 'icon': '\u{1F386}'},
    'interest0040': {'name': '기숙사', 'icon': '\u{2B50}'},

    ///
    'interest0041': {'name': '학생회', 'icon': '\u{26EA}'},
    'interest0042': {'name': '동아리', 'icon': '\u{1F30D}'},
    'interest0043': {'name': '게임', 'icon': '\u{1F4BB}'},
    'interest0044': {'name': '아이돌', 'icon': '\u{1F35C}'},
    'interest0045': {'name': '케이팝', 'icon': '\u{1F431}'},

    ///
    'interest0046': {'name': '힙합', 'icon': '\u{1F4CC}'},
    'interest0047': {'name': '발라드', 'icon': '\u{1F360}'},
    'interest0048': {'name': '영화', 'icon': '\u{1F436}'},
    'interest0049': {'name': '애니메이션', 'icon': '\u{1F380}'},
    'interest0050': {'name': '인터넷방송', 'icon': '\u{1F3AE}'},

    // ///
    // 'interest0051': {'name': '꾸안꾸', 'icon': '\u{1F455}'},
    // 'interest0052': {'name': 'EPL/축구', 'icon': '\u{26BD}'},
    // 'interest0053': {'name': '배그', 'icon': '\u{1F52B}'},
    // 'interest0054': {'name': '반려식물', 'icon': '\u{1F331}'},
    // 'interest0055': {'name': '메이플', 'icon': '\u{1F3AE}'},

    // ///
    // 'interest0056': {'name': '서든어택', 'icon': '\u{1F52B}'},
    // 'interest0057': {'name': '로스트아크', 'icon': '\u{1F3AE}'},
    // 'interest0058': {'name': '피파온라인4', 'icon': '\u{1F3AE}'},
    // 'interest0059': {'name': '산책', 'icon': '\u{1F3C3}'},
    // 'interest0060': {'name': '요리왕', 'icon': '\u{1F372}'},

    // ///
    // 'interest0061': {'name': '학생회', 'icon': '\u{1F64B}'},
    // 'interest0062': {'name': '자발적아싸', 'icon': '\u{1F6B6}'},
    // 'interest0063': {'name': '미술/예술', 'icon': '\u{1F3A8}'},
    // 'interest0064': {'name': '필라테스', 'icon': '\u{1F3BD}'},
  };
}
