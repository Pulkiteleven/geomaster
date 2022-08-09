class FeedbackForm {
  String name;
  String email;
  String phone;
  String subject;

  String ins;
  String course;
  String education;
  String jobType;

  String company;

  String message;

  String opportunity;



  FeedbackForm(this.name, this.email, this.phone,this.subject,
      this.ins,this.course,this.education,this.jobType,
      this.company,
      this.message,
      this.opportunity);


  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm("${json['name']}", "${json['email']}",
        "${json['phone']}", "${json['subject']}",
        "${json['ins']}", "${json['course']}","${json['education']}","${json['jobType']}"
        ,"${json['company']}"
        ,"${json['message']}",
        "${json['Opportunity']}");
  }

  // Method to make GET parameters.

  Map toJson() => {
    'name': name,
    'email': email,
    'phone' : phone,
    'subject' : subject,
    'ins' : ins,
    'course' : course,
    'education' : education,
    'jobType' : jobType,
    'message' : message,
    'Opportunity' : opportunity
  };

}