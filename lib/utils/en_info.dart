// ignore_for_file: non_constant_identifier_names

class EnInfo {
  int currentPage;
  int limit;
  int total;
  int pages;
  bool hasNext;
  bool hasPrev;


 

  EnInfo({
    this.currentPage = 1,
    this.limit = 0,
    this.total = 0,
    this.pages = 0,
    this.hasNext = false,
    this.hasPrev = false,
   
  });

  factory EnInfo.fromJson(Map<String, dynamic> json) => EnInfo(
        currentPage: json['currentPage'] ?? 1,
        limit: json['limit'] ?? 0,
        total: json['total'] ?? 0,
        pages: json['pages'] ?? 0,
        hasNext: json['hasNext'] ?? false,
        hasPrev: json['hasPrev'] ?? false,
      );
  Map<String, dynamic> toJson() => {
        'currentPage': currentPage,
        'limit': limit,
        'total': total,
        'pages': pages,
        'hasNext': hasNext,
        'hasPrev': hasPrev,
      };
}
