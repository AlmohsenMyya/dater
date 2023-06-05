// ignore_for_file: public_member_api_docs, sort_constructors_first
class CategoryItemModel {
  String categoryId;
  String categoryName;
  List<Option> options;
  bool showMore;

  CategoryItemModel({
    required this.categoryId,
    required this.categoryName,
    required this.options,
    this.showMore = false,
  });
}

class Option {
  String id;
  String name;
  String image;
  bool isSelected;

  Option({
    required this.id,
    required this.name,
    required this.image,
    this.isSelected = false,
  });
}
