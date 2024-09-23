class HistoryModel
{
  int? i,status;
  String? search;

  HistoryModel({this.i, this.search,this.status});

  factory HistoryModel.mapToModel(Map m1)
  {
   return HistoryModel(i: m1['cid'],search: m1['history'],status: m1['status']);
  }
}