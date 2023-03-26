
// class Data{
//   DataSearch dataSearch;
//   Data({required this.dataSearch});

//   factory Data.fromJson(Map<String, dynamic> json){
//     return Data(dataSearch: DataSearch.fromJson(json["dataSearch"]));
//   }

// }


// class DataSearch{
//   final List<Major> content;

//   DataSearch({required this.content});

//   factory DataSearch.fromJson(Map<String, dynamic> json){

//     var list = json["content"] as List;
//     List<Major> contentList = list.map((content) =>Major.fromJson(content)).toList(); 
//     return DataSearch(
//       content: contentList
      
//     );
//   }w

// }




class Major {
  final String mClass;
  final String majorSeq;

  Major({required this.mClass, required this.majorSeq});

  factory Major.fromJson(Map<String, dynamic> json) {
    return Major(
      mClass: json['mClass'], 
      majorSeq: json['majorSeq']);
  }
}


