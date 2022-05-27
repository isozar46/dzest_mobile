class OfferImage {
  OfferImage({
    required this.id,
    required this.imageUrl,
  });

  int id;
  String imageUrl;

  factory OfferImage.fromJson(Map<String, dynamic> json) => OfferImage(
        id: json["id"],
        imageUrl: json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
      };
}
