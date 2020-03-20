class MoreResults {
  final String totalCases;
  final String totalDeaths;
  final String totalRecovered;
  final String totalActiveCases;
  final String totalClosedCases;
  final String totalMild;
  final String totalSeriousCritical;
  final String totalDischarged;

  MoreResults({
    this.totalCases,
    this.totalDeaths,
    this.totalRecovered,
    this.totalActiveCases,
    this.totalClosedCases,
    this.totalMild,
    this.totalSeriousCritical,
    this.totalDischarged,
  });

  factory MoreResults.fromJson(Map<String, dynamic> json) {
    return MoreResults(
      totalCases: json['totalCases'],
      totalDeaths: json['totalDeaths'],
      totalRecovered: json['totalRecovered'],
      totalActiveCases: json['totalActiveCases'],
      totalClosedCases: json['totalClosedCases'],
      totalMild: json['totalMild'],
      totalSeriousCritical: json['totalSeriousCritical'],
      totalDischarged: json['totalDischarged'],
    );
  }
}
