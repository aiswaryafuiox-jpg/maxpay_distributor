class GraphModel {
  bool? success;
  GraphData? data;
  String? message;
  int? code;

  GraphModel({this.success, this.data, this.message, this.code});

  GraphModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? GraphData.fromJson(json['data']) : null;
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}

class GraphData {
  String? type;
  List<String>? categories;
  List<GraphSeries>? series;
  String? totalSales;
  num? growth;
  num? yMax;

  GraphData(
      {this.type,
      this.categories,
      this.series,
      this.totalSales,
      this.growth,
      this.yMax});

  GraphData.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    categories = json['categories']?.cast<String>();
    if (json['series'] != null) {
      series = <GraphSeries>[];
      json['series'].forEach((v) {
        series!.add(GraphSeries.fromJson(v));
      });
    }
    totalSales = json['total_sales'];
    growth = json['growth'];
    yMax = json['y_max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['categories'] = categories;
    if (series != null) {
      data['series'] = series!.map((v) => v.toJson()).toList();
    }
    data['total_sales'] = totalSales;
    data['growth'] = growth;
    data['y_max'] = yMax;
    return data;
  }
}

class GraphSeries {
  String? name;
  List<num>? data;

  GraphSeries({this.name, this.data});

  GraphSeries.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    data = json['data']?.cast<num>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['data'] = this.data;
    return data;
  }
}
