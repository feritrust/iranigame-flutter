class Token {
  bool isDone;
  Data data;

  Token.fromJson(Map<String, dynamic> json)
      : isDone = json['isDone'],
        data = Data.fromJson(json['data']);
}

class Data {
  String token;

  Data.fromJson(Map<String, dynamic> json) :
    token = json['token'];

}
