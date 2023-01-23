class CollegeData {
  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  // icon를 학교 이미지로 변경 필요, 0000은 빈 값
  static final Map<String, Map<String, String>> data = {
    'college0000': {'name': '', 'image': '\u{1F601}'},
    'college0001': {'name': '가톨릭대학교', 'image': '\u{1F601}'},
    'college0002': {'name': '강남대학교', 'image': '\u{1F1F7}'},
    'college0003': {'name': '강서대학교', 'image': '\u{1F4B5}'},
    'college0004': {'name': '건국대학교', 'image': '\u{2708}'},
    'college0005': {'name': '경기대학교', 'image': '\u{2600}'},
    'college0006': {'name': '경운대학교', 'image': '\u{1F308}'},
    'college0007': {'name': '경희대학교', 'image': '\u{1F3AE}'},
    'college0008': {'name': '고려대학교', 'image': '\u{1F308}'},
    'college0009': {'name': '광운대학교', 'image': '\u{1F3AE}'},

    'college0010': {'name': '국민대학교', 'image': '\u{1F601}'},
    'college0011': {'name': '국제예술대학교', 'image': '\u{1F601}'},
    'college0012': {'name': '단국대학교', 'image': '\u{1F1F7}'},
    'college0013': {'name': '덕성여자대학교', 'image': '\u{1F4B5}'},
    'college0014': {'name': '동국대학교', 'image': '\u{2708}'},
    'college0015': {'name': '동덕여자대학교', 'image': '\u{2600}'},
    'college0016': {'name': '동양미래대학교', 'image': '\u{1F308}'},
    'college0017': {'name': '동의대학교', 'image': '\u{1F3AE}'},
    'college0018': {'name': '명지대학교', 'image': '\u{1F308}'},
    'college0019': {'name': '명지전문대학교', 'image': '\u{1F3AE}'},

    'college0020': {'name': '배화여자대학교', 'image': '\u{1F601}'},
    'college0021': {'name': '백석예술대학교', 'image': '\u{1F601}'},
    'college0022': {'name': '삼육대학교', 'image': '\u{1F1F7}'},
    'college0023': {'name': '삼육보건대학교', 'image': '\u{1F4B5}'},
    'college0024': {'name': '상명대학교', 'image': '\u{2708}'},
    'college0025': {'name': '서강대학교', 'image': '\u{2600}'},
    'college0026': {'name': '서울과학기술대학교', 'image': '\u{1F308}'},
    'college0027': {'name': '서울교육대학교', 'image': '\u{1F3AE}'},
    'college0028': {'name': '서울대학교', 'image': '\u{1F308}'},
    'college0029': {'name': '서울시립대학교', 'image': '\u{1F3AE}'},

    'college0030': {'name': '서울여자간호대학교', 'image': '\u{1F601}'},
    'college0031': {'name': '서울여자대학교', 'image': '\u{1F601}'},
    'college0032': {'name': '서일대학교', 'image': '\u{1F1F7}'},
    'college0033': {'name': '성공회대학교', 'image': '\u{1F4B5}'},
    'college0034': {'name': '성균관대학교', 'image': '\u{2708}'},
    'college0035': {'name': '성신여자대학교', 'image': '\u{2600}'},
    'college0036': {'name': '세종대학교', 'image': '\u{1F308}'},
    'college0037': {'name': '숙명여자대학교', 'image': '\u{1F3AE}'},
    'college0038': {'name': '숭실대학교', 'image': '\u{1F308}'},
    'college0039': {'name': '숭의여자대학교', 'image': '\u{1F3AE}'},

    'college0040': {'name': '신한대학교', 'image': '\u{1F601}'},
    'college0041': {'name': '연세대학교', 'image': '\u{1F601}'},
    'college0042': {'name': '유한대학교', 'image': '\u{1F1F7}'},
    'college0043': {'name': '육군사관학교', 'image': '\u{1F4B5}'},
    'college0044': {'name': '이화여자대학교', 'image': '\u{2708}'},
    'college0045': {'name': '인덕대학교', 'image': '\u{2600}'},
    'college0046': {'name': '정화예술대학교', 'image': '\u{1F308}'},
    'college0047': {'name': '중앙대학교', 'image': '\u{1F3AE}'},
    'college0048': {'name': '총신대학교', 'image': '\u{1F308}'},
    'college0049': {'name': '추계예술대학교', 'image': '\u{1F3AE}'},

    'college0050': {'name': '충남대학교', 'image': '\u{1F601}'},
    'college0051': {'name': '한국공학대학교', 'image': '\u{1F601}'},
    'college0052': {'name': '한국과학기술원', 'image': '\u{1F1F7}'},
    'college0053': {'name': '한국예술종합대학교', 'image': '\u{1F4B5}'},
    'college0054': {'name': '한국외국어대학교', 'image': '\u{2708}'},
    'college0055': {'name': '한국체육대학교', 'image': '\u{2600}'},
    'college0056': {'name': '한국폴리텍대학', 'image': '\u{1F308}'},
    'college0057': {'name': '한성대학교', 'image': '\u{1F3AE}'},
    'college0058': {'name': '한양대학교', 'image': '\u{1F308}'},
    'college0059': {'name': '한양여자대학교', 'image': '\u{1F3AE}'},

    'college0060': {'name': '홍익대학교', 'image': '\u{1F601}'},
  };
}
