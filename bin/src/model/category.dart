import '../core/model.dart';
import '../globals.dart';

class CategoryModel extends Model<int> {
  CategoryModel({
    this.id = 0,
    this.pid = 0,
    this.short = '',
    this.title = '',
    this.name = '',
    this.icon = '',
    this.image = '',
    this.sort = 0,
    Map<String, String>? props,
    List<int>? fields,
    this.pagesize = 10,
    this.channelMode = false,
    this.status = 0,
    this.isLock = false,
    this.isComment = false,
    this.isImages = false,
    this.isAttachments = false,
    List<String>? keywords,
    this.description = '',
  })  : props = props ?? <String, String>{},
        fields = fields ?? <int>[],
        keywords = keywords ?? <String>[];

  CategoryModel.fromJson(Json json)
      : this(
          id: json['id'] ?? 0,
          pid: json['pid'] ?? 0,
          title: json['title'] ?? '',
          name: json['name'] ?? 'name',
          icon: json['icon'] ?? 'icon',
        );

  final int id;
  final int pid;
  final String short;
  final String title;
  final String name;
  final String icon;
  final String image;
  final int sort;
  final Map<String, String> props;
  final List<int> fields;
  final int pagesize;
  final bool channelMode;
  final int status;
  final bool isLock;
  final bool isComment;
  final bool isImages;
  final bool isAttachments;
  final List<String> keywords;
  final String description;

  @override
  CategoryModel copyWith({
    int? id,
    int? pid,
    String? title,
    String? name,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      pid: pid ?? this.pid,
      title: title ?? this.title,
      name: name ?? this.name,
    );
  }

  @override
  int get primary => id;

  @override
  Json toJson([bool excludePrimary = false]) => {
        if (!excludePrimary) 'id': id,
        'pid': pid,
        'title': title,
        'name': name,
      };
}
