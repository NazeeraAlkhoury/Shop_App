class ChangefavoritesModel {
  bool? status;
  String? message;

  ChangefavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
