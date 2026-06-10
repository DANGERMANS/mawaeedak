/// Prayer Times Model
class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  const PrayerTimes({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory PrayerTimes.fromMap(Map<String, dynamic> map) {
    return PrayerTimes(
      fajr: map['fajr'] ?? '04:30',
      sunrise: map['sunrise'] ?? '05:45',
      dhuhr: map['dhuhr'] ?? '11:45',
      asr: map['asr'] ?? '15:15',
      maghrib: map['maghrib'] ?? '18:45',
      isha: map['isha'] ?? '20:00',
    );
  }

  Map<String, String> toMap() => {
    'fajr': fajr,
    'sunrise': sunrise,
    'dhuhr': dhuhr,
    'asr': asr,
    'maghrib': maghrib,
    'isha': isha,
  };

  static const PrayerTimes mock = PrayerTimes(
    fajr: '04:30',
    sunrise: '05:45',
    dhuhr: '11:45',
    asr: '15:15',
    maghrib: '18:45',
    isha: '20:00',
  );

  PrayerTimes copyWith({
    String? fajr,
    String? sunrise,
    String? dhuhr,
    String? asr,
    String? maghrib,
    String? isha,
  }) {
    return PrayerTimes(
      fajr: fajr ?? this.fajr,
      sunrise: sunrise ?? this.sunrise,
      dhuhr: dhuhr ?? this.dhuhr,
      asr: asr ?? this.asr,
      maghrib: maghrib ?? this.maghrib,
      isha: isha ?? this.isha,
    );
  }
}

/// Prayer Item for display
class PrayerItem {
  final String key;
  final String label;
  final String time;
  final String icon;

  const PrayerItem({
    required this.key,
    required this.label,
    required this.time,
    required this.icon,
  });
}

/// Financial Event Model
class FinancialEvent {
  final String id;
  final String name;
  final String nameAr;
  final String date;
  final String? amount;
  final String type;
  final int daysRemaining;

  const FinancialEvent({
    required this.id,
    required this.name,
    this.nameAr = '',
    required this.date,
    this.amount,
    required this.type,
    required this.daysRemaining,
  });

  factory FinancialEvent.fromMap(Map<String, dynamic> map) {
    return FinancialEvent(
      id: map['id']?.toString() ?? '',
      name: map['name'] ?? '',
      nameAr: map['name_ar'] ?? map['name'] ?? '',
      date: map['date'] ?? '',
      amount: map['amount']?.toString(),
      type: map['type'] ?? 'salary',
      daysRemaining: map['days_remaining'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'name_ar': nameAr,
    'date': date,
    'amount': amount,
    'type': type,
    'days_remaining': daysRemaining,
  };
}

/// Appointment Model
class Appointment {
  final String id;
  final String title;
  final String date;
  final String time;
  final String type;
  final String? notes;

  const Appointment({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.type,
    this.notes,
  });

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id']?.toString() ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      type: map['type'] ?? 'personal',
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'date': date,
    'time': time,
    'type': type,
    'notes': notes,
  };
}

/// Service Center Model
class ServiceCenter {
  final int id;
  final String name;
  final String icon;
  final List<String> services;

  const ServiceCenter({
    required this.id,
    required this.name,
    required this.icon,
    required this.services,
  });
}

/// User Model
class User {
  final String id;
  final String name;
  final String email;
  final String city;
  final String cityKey;
  final String timezone;
  final String role;
  final bool onboardingComplete;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
    required this.cityKey,
    required this.timezone,
    required this.role,
    required this.onboardingComplete,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      city: map['city'] ?? 'الرياض',
      cityKey: map['cityKey'] ?? 'riyadh',
      timezone: map['timezone'] ?? 'Asia/Riyadh',
      role: map['role'] ?? 'user',
      onboardingComplete: map['onboardingComplete'] ?? false,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'city': city,
    'cityKey': cityKey,
    'timezone': timezone,
    'role': role,
    'onboardingComplete': onboardingComplete,
  };

  static const User empty = User(
    id: '',
    name: '',
    email: '',
    city: 'الرياض',
    cityKey: 'riyadh',
    timezone: 'Asia/Riyadh',
    role: 'user',
    onboardingComplete: false,
  );
}

/// Daily Message Model
class DailyMessage {
  final int id;
  final String message;
  final String? displayDate;
  final bool isActive;

  const DailyMessage({
    required this.id,
    required this.message,
    this.displayDate,
    required this.isActive,
  });

  factory DailyMessage.fromMap(Map<String, dynamic> map) {
    return DailyMessage(
      id: map['id'] ?? 0,
      message: map['message'] ?? '',
      displayDate: map['display_date'],
      isActive: map['is_active'] ?? true,
    );
  }
}

/// Notification Model
class AppNotification {
  final String id;
  final String title;
  final String body;
  final String type;
  final bool read;
  final bool isImportant;
  final String? targetPage;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.read,
    this.isImportant = false,
    this.targetPage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppNotification.fromMap(Map<String, dynamic> map) {
    return AppNotification(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      body: map['body'] ?? '',
      type: map['type'] ?? 'general',
      read: map['read'] ?? false,
      isImportant: map['is_important'] ?? false,
      targetPage: map['target_page'],
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'body': body,
    'type': type,
    'read': read,
    'is_important': isImportant,
    'target_page': targetPage,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  AppNotification copyWith({
    String? id,
    String? title,
    String? body,
    String? type,
    bool? read,
    bool? isImportant,
    String? targetPage,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppNotification(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      read: read ?? this.read,
      isImportant: isImportant ?? this.isImportant,
      targetPage: targetPage ?? this.targetPage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Trip Model
class Trip {
  final String id;
  final String from;
  final String to;
  final String? flightNumber;
  final String date;
  final String time;
  final String status;
  final String? notes;
  final bool hasReminder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Trip({
    required this.id,
    required this.from,
    required this.to,
    this.flightNumber,
    required this.date,
    required this.time,
    this.status = 'pending',
    this.notes,
    this.hasReminder = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      id: map['id'] ?? '',
      from: map['from'] ?? '',
      to: map['to'] ?? '',
      flightNumber: map['flight_number'],
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      status: map['status'] ?? 'pending',
      notes: map['notes'],
      hasReminder: map['has_reminder'] ?? false,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'from': from,
    'to': to,
    'flight_number': flightNumber,
    'date': date,
    'time': time,
    'status': status,
    'notes': notes,
    'has_reminder': hasReminder,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  Trip copyWith({
    String? id,
    String? from,
    String? to,
    String? flightNumber,
    String? date,
    String? time,
    String? status,
    String? notes,
    bool? hasReminder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Trip(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      flightNumber: flightNumber ?? this.flightNumber,
      date: date ?? this.date,
      time: time ?? this.time,
      status: status ?? this.status,
      notes: notes ?? this.notes,
      hasReminder: hasReminder ?? this.hasReminder,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Trip Checklist Item Model
class TripChecklistItem {
  final String id;
  final String tripId;
  final String name;
  final bool isChecked;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TripChecklistItem({
    required this.id,
    required this.tripId,
    required this.name,
    this.isChecked = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripChecklistItem.fromMap(Map<String, dynamic> map) {
    return TripChecklistItem(
      id: map['id'] ?? '',
      tripId: map['trip_id'] ?? '',
      name: map['name'] ?? '',
      isChecked: map['is_checked'] ?? false,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'trip_id': tripId,
    'name': name,
    'is_checked': isChecked,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  TripChecklistItem copyWith({
    String? id,
    String? tripId,
    String? name,
    bool? isChecked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return TripChecklistItem(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      name: name ?? this.name,
      isChecked: isChecked ?? this.isChecked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Complaint Ticket Model
class ComplaintTicket {
  final String id;
  final String type;
  final String title;
  final String description;
  final String priority;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ComplaintTicket({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    this.priority = 'normal',
    this.status = 'pending',
    required this.createdAt,
    required this.updatedAt,
  });

  factory ComplaintTicket.fromMap(Map<String, dynamic> map) {
    return ComplaintTicket(
      id: map['id'] ?? '',
      type: map['type'] ?? 'complaint',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      priority: map['priority'] ?? 'normal',
      status: map['status'] ?? 'pending',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'type': type,
    'title': title,
    'description': description,
    'priority': priority,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  ComplaintTicket copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    String? priority,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ComplaintTicket(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Greeting Template Model
class GreetingTemplate {
  final String id;
  final String name;
  final String content;
  final String type;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GreetingTemplate({
    required this.id,
    required this.name,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GreetingTemplate.fromMap(Map<String, dynamic> map) {
    return GreetingTemplate(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      content: map['content'] ?? '',
      type: map['type'] ?? 'general',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'content': content,
    'type': type,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

/// Greeting Card Model
class GreetingCard {
  final String id;
  final String recipientName;
  final String senderName;
  final String type;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  const GreetingCard({
    required this.id,
    required this.recipientName,
    required this.senderName,
    required this.type,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GreetingCard.fromMap(Map<String, dynamic> map) {
    return GreetingCard(
      id: map['id'] ?? '',
      recipientName: map['recipient_name'] ?? '',
      senderName: map['sender_name'] ?? '',
      type: map['type'] ?? 'general',
      content: map['content'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'recipient_name': recipientName,
    'sender_name': senderName,
    'type': type,
    'content': content,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  GreetingCard copyWith({
    String? id,
    String? recipientName,
    String? senderName,
    String? type,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GreetingCard(
      id: id ?? this.id,
      recipientName: recipientName ?? this.recipientName,
      senderName: senderName ?? this.senderName,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Contact Message Model
class ContactMessage {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String type;
  final String message;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ContactMessage({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    required this.type,
    required this.message,
    this.status = 'sent',
    required this.createdAt,
    required this.updatedAt,
  });

  factory ContactMessage.fromMap(Map<String, dynamic> map) {
    return ContactMessage(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'],
      phone: map['phone'],
      type: map['type'] ?? 'inquiry',
      message: map['message'] ?? '',
      status: map['status'] ?? 'sent',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'type': type,
    'message': message,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  ContactMessage copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? type,
    String? message,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ContactMessage(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      type: type ?? this.type,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// News Item Model
class NewsItem {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final String? sourceUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  const NewsItem({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return NewsItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['image_url'],
      sourceUrl: map['source_url'],
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'content': content,
    'image_url': imageUrl,
    'source_url': sourceUrl,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

/// Job Item Model
class JobItem {
  final String id;
  final String title;
  final String company;
  final String location;
  final String description;
  final String? salary;
  final DateTime createdAt;
  final DateTime updatedAt;

  const JobItem({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
    required this.description,
    this.salary,
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobItem.fromMap(Map<String, dynamic> map) {
    return JobItem(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      company: map['company'] ?? '',
      location: map['location'] ?? '',
      description: map['description'] ?? '',
      salary: map['salary'],
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'company': company,
    'location': location,
    'description': description,
    'salary': salary,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

/// Calendar Event Model
class CalendarEvent {
  final String id;
  final String title;
  final String date;
  final String time;
  final String category;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CalendarEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CalendarEvent.fromMap(Map<String, dynamic> map) {
    return CalendarEvent(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      category: map['category'] ?? 'personal',
      notes: map['notes'],
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'date': date,
    'time': time,
    'category': category,
    'notes': notes,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? date,
    String? time,
    String? category,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      time: time ?? this.time,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Daily Card Template Model
class DailyCardTemplate {
  final String id;
  final String name;
  final Map<String, dynamic> config;
  final DateTime createdAt;
  final DateTime updatedAt;

  const DailyCardTemplate({
    required this.id,
    required this.name,
    required this.config,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyCardTemplate.fromMap(Map<String, dynamic> map) {
    return DailyCardTemplate(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      config: map['config'] ?? {},
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'config': config,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };
}

/// Cost Goal Model
class CostGoal {
  final String id;
  final String name;
  final double targetAmount;
  final double currentAmount;
  final String duration;
  final String type;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CostGoal({
    required this.id,
    required this.name,
    required this.targetAmount,
    this.currentAmount = 0,
    required this.duration,
    this.type = 'financial',
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  double get remaining => targetAmount - currentAmount;
  double get dailyTarget => targetAmount / (int.tryParse(duration) ?? 30);
  double get weeklyTarget => targetAmount / ((int.tryParse(duration) ?? 30) / 7);
  double get monthlyTarget => targetAmount / ((int.tryParse(duration) ?? 30) / 30);

  factory CostGoal.fromMap(Map<String, dynamic> map) {
    return CostGoal(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      targetAmount: (map['target_amount'] ?? 0).toDouble(),
      currentAmount: (map['current_amount'] ?? 0).toDouble(),
      duration: map['duration'] ?? '30',
      type: map['type'] ?? 'financial',
      status: map['status'] ?? 'active',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'target_amount': targetAmount,
    'current_amount': currentAmount,
    'duration': duration,
    'type': type,
    'status': status,
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  CostGoal copyWith({
    String? id,
    String? name,
    double? targetAmount,
    double? currentAmount,
    String? duration,
    String? type,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CostGoal(
      id: id ?? this.id,
      name: name ?? this.name,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      duration: duration ?? this.duration,
      type: type ?? this.type,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

/// Cost Item Model
class CostItem {
  final String id;
  final String goalId;
  final String name;
  final double amount;
  final String status;
  final DateTime? paidAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CostItem({
    required this.id,
    required this.goalId,
    required this.name,
    required this.amount,
    this.status = 'pending',
    this.paidAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CostItem.fromMap(Map<String, dynamic> map) {
    return CostItem(
      id: map['id'] ?? '',
      goalId: map['goal_id'] ?? '',
      name: map['name'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      status: map['status'] ?? 'pending',
      paidAt: map['paid_at'] != null ? DateTime.tryParse(map['paid_at']) : null,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'goal_id': goalId,
    'name': name,
    'amount': amount,
    'status': status,
    'paid_at': paidAt?.toIso8601String(),
    'created_at': createdAt.toIso8601String(),
    'updated_at': updatedAt.toIso8601String(),
  };

  CostItem copyWith({
    String? id,
    String? goalId,
    String? name,
    double? amount,
    String? status,
    DateTime? paidAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CostItem(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      paidAt: paidAt ?? this.paidAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}