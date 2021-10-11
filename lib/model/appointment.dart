class Appointment{
  int? id;
  String? title;
  String? description;
  String? apptDate;
  String? apptTime;

  Appointment({this.title, this.description, this.apptDate, this.apptTime});

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

  changeAppointmentForReorder(Appointment appointment){
    this.title = appointment.title;
    this.description = appointment.description;
    this.apptDate = appointment.apptDate;
    this.apptTime = appointment.apptTime;
  }
}