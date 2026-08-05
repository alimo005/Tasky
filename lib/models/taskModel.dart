class TaskModel {
  int id;
  String taskName;
  String taskDescription;
  bool isHighPriority;
  bool isDone;


  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id :json["id"] ?? 0,
      taskName: json["taskName"],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone: json['isDone']??false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id" : id,
      "taskName": taskName,
      "taskDescription": taskDescription,
      "isHighPriority": isHighPriority,
      "isDone":isDone
    };
  }
}
