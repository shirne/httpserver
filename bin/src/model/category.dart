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
    List<String>? props,
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
  })  : props = props ?? <String>[],
        fields = fields ?? <int>[],
        keywords = keywords ?? <String>[];

  CategoryModel.fromJson(Json json)
      : this(
          id: json['id'] ?? 0,
          pid: json['pid'] ?? 0,
          short: json['short'] ?? '',
          title: json['title'] ?? '',
          name: json['name'] ?? '',
          icon: json['icon'] ?? '',
          image: json['image'] ?? '',
          sort: json['sort'] ?? 0,
          props: parseJson(json['props']),
          fields: json['fields'],
          pagesize: json['pagesize'] ?? 0,
          channelMode: json['channel_mode'] ?? false,
          status: json['status'] ?? 0,
          isLock: json['is_lock'] ?? false,
          isComment: json['is_comment'] ?? false,
          isImages: json['is_images'] ?? false,
          isAttachments: json['is_attachments'] ?? false,
          keywords: json['keywords'],
          description: json['description'] ?? '',
        );

  final int id;
  final int pid;
  final String short;
  final String title;
  final String name;
  final String icon;
  final String image;
  final int sort;
  final List<String> props;
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
