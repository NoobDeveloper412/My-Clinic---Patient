
class FeedbackModel{

  String uid;
  String name;
  String phn;
  String feedbacktext;

  FeedbackModel({
    this.uid,
    this.phn,
    this.name,
    this.feedbacktext
  });

  Map<String,dynamic>addJson(){
    return {
      "uid":this.uid,
      "name":this.name,
      "phn":this.phn,
      "feedback_text":this.feedbacktext

    };

  }

}