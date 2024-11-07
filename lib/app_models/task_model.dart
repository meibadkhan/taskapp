// To parse this JSON data, do
//
//     final task = taskFromJson(jsonString);

import 'dart:convert';

Task taskFromJson(String str) => Task.fromJson(json.decode(str));

String taskToJson(Task data) => json.encode(data.toJson());

class Task {
  bool success;
  List<TaskListData> data;
  String message;

  Task({
    required this.success,
    required this.data,
    required this.message,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    success: json["success"],
    data: List<TaskListData>.from(json["data"].map((x) => TaskListData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class TaskListData {
  int id;
  String taskName;
  String description;
  String userName;
  String phoneNumber;
  DateTime date;
  String isComplete;
  DateTime createdAt;
  DateTime updatedAt;
  List<Media> media;

  TaskListData({
    required this.id,
    required this.taskName,
    required this.description,
    required this.userName,
    required this.phoneNumber,
    required this.date,
    required this.isComplete,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
  });

  factory TaskListData.fromJson(Map<String, dynamic> json) => TaskListData(
    id: json["id"],
    taskName: json["task_name"],
    description: json["description"],
    userName: json["user_name"],
    phoneNumber: json["phone_number"],
    date: DateTime.parse(json["date"]),
    isComplete: json["is_complete"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "task_name": taskName,
    "description": description,
    "user_name": userName,
    "phone_number": phoneNumber,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "is_complete": isComplete,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Media {
  int id;
  String modelType;
  int modelId;
  String uuid;
  String collectionName;
  String name;
  String fileName;
  String mimeType;
  String disk;
  String conversionsDisk;
  int size;
  List<dynamic> manipulations;
  List<dynamic> customProperties;
  List<dynamic> generatedConversions;
  List<dynamic> responsiveImages;
  int orderColumn;
  DateTime createdAt;
  DateTime updatedAt;
  String originalUrl;
  String previewUrl;

  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.uuid,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.conversionsDisk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.generatedConversions,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.originalUrl,
    required this.previewUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    modelType: json["model_type"],
    modelId: json["model_id"],
    uuid: json["uuid"],
    collectionName: json["collection_name"],
    name: json["name"],
    fileName: json["file_name"],
    mimeType: json["mime_type"],
    disk: json["disk"],
    conversionsDisk: json["conversions_disk"],
    size: json["size"],
    manipulations: List<dynamic>.from(json["manipulations"].map((x) => x)),
    customProperties: List<dynamic>.from(json["custom_properties"].map((x) => x)),
    generatedConversions: List<dynamic>.from(json["generated_conversions"].map((x) => x)),
    responsiveImages: List<dynamic>.from(json["responsive_images"].map((x) => x)),
    orderColumn: json["order_column"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    originalUrl: json["original_url"],
    previewUrl: json["preview_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "model_type": modelType,
    "model_id": modelId,
    "uuid": uuid,
    "collection_name": collectionName,
    "name": name,
    "file_name": fileName,
    "mime_type": mimeType,
    "disk": disk,
    "conversions_disk": conversionsDisk,
    "size": size,
    "manipulations": List<dynamic>.from(manipulations.map((x) => x)),
    "custom_properties": List<dynamic>.from(customProperties.map((x) => x)),
    "generated_conversions": List<dynamic>.from(generatedConversions.map((x) => x)),
    "responsive_images": List<dynamic>.from(responsiveImages.map((x) => x)),
    "order_column": orderColumn,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "original_url": originalUrl,
    "preview_url": previewUrl,
  };
}
