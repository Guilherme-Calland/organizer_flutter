class Note{
  int? id;
  String? title;
  String? content;
  String? color;

  Note({this.title, this.id, this.content, this.color = 'white'});

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

  changeNoteForReorder(Note note){
    this.title = note.title;
    this.content = note.content;
    this.color = note.color;
  }

}