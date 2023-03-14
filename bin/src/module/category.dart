import '../core/module.dart';
import '../globals.dart';
import '../model/category.dart';

class CategoryModule extends Module<CategoryModel, int> {
  @override
  CategoryModel parser(Json json) => CategoryModel.fromJson(json);

  @override
  String get primary => 'id';

  @override
  String get table => 'category';
}
