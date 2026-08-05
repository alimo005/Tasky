enum TaskItemActionsEnum {
  markAsDone(title: "Done || unDone"),

  update(title: "UpDate"),

  delete(title: "Delete");

  final String title;

  const TaskItemActionsEnum({required this.title});
}
