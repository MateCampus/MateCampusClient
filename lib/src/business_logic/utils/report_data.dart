class ReportTypeData {
  static korNameOf(String code) {
    return data[code]?['name'] ?? 'unknown name';
  }

  static final Map<String, Map<String, String>> data = {
    'report0000': {'name': ''},
    'report0001': {'name': '욕설 및 폭력적 언어 사용'},
    'report0002': {'name': '개인 정보 유출 및 도용'},
    'report0003': {'name': '음란성 및 불건전한 만남 유도'},
    'report0004': {'name': '분란 조장 및 혐오 표현 사용'},
    'report0005': {'name': '상업적 광고 및 판매'},
    'report0006': {'name': '낚시 및 도배성 글 작성'},
  };
}
