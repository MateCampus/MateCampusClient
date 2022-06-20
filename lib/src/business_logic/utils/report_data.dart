enum ReportType {
  report0000,
  report0001,
  report0002,
  report0003,
  report0004,
  report0005,
  report0006,
  report0007
}

class ReportTypeData {
  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'report0000': {'name': ''},
    'report0001': {'name': '욕설/비방/인신공격'},
    'report0002': {'name': '개인정보유출/사칭/사기'},
    'report0003': {'name': '음란성/선정성/불건전한 만남유도'},
    'report0004': {'name': '분란조장/혐오표현'},
    'report0005': {'name': '상업성/광고/판매'},
    'report0006': {'name': '낚시/도배'},
    'report0007': {'name': '기타'},
  };
}
