class User {
  final int? id;
  final String name;
  final int time;
  final int attempts;

  User(
      {this.id,
      required this.name,
      required this.time,
      required this.attempts});

  User.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        time = res["time"],
        attempts = res["attempts"];

  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'time': time, 'attempts': attempts};
  }

  String getStr() {
    return "'id':$id,'name': $name, 'time': $time, 'attempts': $attempts";
  }
}
