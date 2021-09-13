class Note{
  int? id;
  String? title;
  String? content;
  String color = 'white';

  Note({this.title, this.id, this.content, color});

  Note.mapToNote(Map<String, dynamic> inMap){
    this.id = inMap['id'];
    this.title = inMap['title'];
    this.content = inMap['content'];
    this.color = inMap['color'];
  }

  Map<String, dynamic> noteToMap(){
    Map<String, dynamic> outMap = {
      'title' : this.title ?? '',
      'content' : this.content ?? '',
      'color' : this.color
    };

    if(id != null){
      outMap['id'] = this.id;
    }

    return outMap;
  }

}