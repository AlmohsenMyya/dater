// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryItemModel {
  String categoryId;
  String categoryName;
  List<Option> options;

  CategoryItemModel({
    required this.categoryId,
    required this.categoryName,
    required this.options,
  });
}

class Option {
  String id;
  String name;
  bool isSelected;

  Option({
    required this.id,
    required this.name,
    this.isSelected = false,
  });
}
