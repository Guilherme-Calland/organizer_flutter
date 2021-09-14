class Appointment{
  int? id;
  String? title;
  String? description;
  String? apptDate;
  String? apptTime;

  Appointment();

  Appointment.mapToAppointment(Map<String, dynamic> inMap){
    this.id = inMap['id'];
    this.title = inMap['title'];
    this.description = inMap['description'];
    this.apptDate = inMap['apptDate'];
    this.apptTime = inMap['apptTime'];
  }

  Map<String, dynamic> appointmentToMap(){
    Map<String, dynamic> outMap = {
      'title' : this.title,
      'description' : this.description,
      'apptDate' : this.apptDate,
      'apptTime' : this.apptTime
    };

    if(this.id != null){
      outMap['id'] = this.id;
    }

    return outMap;
  }
}