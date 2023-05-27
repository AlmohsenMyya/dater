class UploadUserImage {
  String id;
  String imageUrl;
  bool isImageFromNetwork;

  UploadUserImage({required this.imageUrl,
    required this.isImageFromNetwork,
    required this.id,
  });

  factory UploadUserImage.fromJson(Map<String, dynamic> json) => UploadUserImage(
    id: json['id'],
      imageUrl: json['image'],
    isImageFromNetwork: json['isImageFromNetwork']
  );

}