class Task{
  int? id;
  String? description;
  String? dueDate;
  String completed = 'false';

  Task();

  Task.mapToTask(Map<String, dynamic> inData){
    this.id = inData['id'];
    this.description = inData['description'];
    this.dueDate = inData['dueDate'];
    this.completed = inData['completed'];
  }

  Map<String, dynamic> taskToMap(){
    Map<String, dynamic> outMap = {
      'description' : this.description,
      'dueDate' : this.dueDate,
      'completed' : this.completed
    };

    if(id != null){
      outMap['id'] = this.id;
    }

    return outMap;
  }
}