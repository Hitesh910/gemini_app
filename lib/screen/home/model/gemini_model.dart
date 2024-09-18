class GeminiModel
{
  List<CandidateModel>? candidate = [];

    GeminiModel({this.candidate});

    factory GeminiModel.mapToModel(Map m1)
    {
      List l1 = m1['candidate'];
      return GeminiModel(candidate: l1.map((e) => CandidateModel.mapToModel(e),).toList());
    }
}

class CandidateModel
{
  ContentModel? content;
  CandidateModel({this.content});

  factory CandidateModel.mapToModel(Map m1)
  {
    return CandidateModel(content: m1['content']);
  }
}

class ContentModel
{
  int? role;
  List<PartsModel>? partList = [];
  
  ContentModel({this.partList,this.role});
  
  factory ContentModel.mapToModel(Map m1)
  {
    List l1 = m1['parts'];
    return ContentModel(partList : l1.map((e) => PartsModel.mapToModel(e),).toList(),role: m1['role']);
  }
}

class PartsModel
{
  String? text;
  
  PartsModel({this.text});
  
  factory PartsModel.mapToModel(Map m1)
  {
    return PartsModel(text: m1['text']);
  }
}

// class Text
// {
//
// }