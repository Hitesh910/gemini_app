class HistoryModel
{
  int? i;
  String? search,data;

  HistoryModel({this.i, this.search,this.data});

  factory HistoryModel.mapToModel(Map m1)
  {
   return HistoryModel(i: m1['cid'],search: m1['history'],data: m1['data']);
  }
}