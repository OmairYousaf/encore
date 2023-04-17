class EventList {
  bool? status;
  String? message;
  List<Event>? data;

  EventList({this.status, this.message, this.data});

  EventList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Event>[];
      json['data'].forEach((v) {
        data!.add(Event.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Event {
  int? id;
  String? eventOccur;
  String? followupOccur;
  String? userId;
  String? note;
  String? followupDateTime;
  String? phone;
  String? name;
  String? priority;
  String? createdAt;
  bool? isExpanded; // only for frontend...

  Event({
    this.id,
    this.eventOccur,
    this.followupOccur,
    this.userId,
    this.note,
    this.followupDateTime,
    this.phone,
    this.name,
    this.priority,
    this.createdAt,
    this.isExpanded = false,
  });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventOccur = json['event_occur'];
    followupOccur = json['followup_occur'];
    userId = json['user_id'];
    note = json['note'];
    followupDateTime = json['followup_date_time'];
    phone = json['phone'];
    name = json['name'];
    priority = json['priority'];
    createdAt = json['created_at'];
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['event_occur'] = eventOccur;
    data['followup_occur'] = followupOccur;
    data['user_id'] = userId;
    data['note'] = note;
    data['followup_date_time'] = followupDateTime;
    data['phone'] = phone;
    data['name'] = name;
    data['priority'] = priority;
    data['created_at'] = createdAt;
    return data;
  }
}
