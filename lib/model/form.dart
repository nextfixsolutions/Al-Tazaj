/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String product;
  String price;
  String image;
  String stock;

  FeedbackForm(this.product, this.price, this.image, this.stock);

  factory FeedbackForm.fromJson(dynamic json) {
    return FeedbackForm(
        "${json['product']}",
        "${json['price']}",
        "${json['image']}",
        "${json['stock']}"
    );
  }

  // Method to make GET parameters.
  Map toJson() => {
        'product': product,
        'price': price,
        'image': image,
        'stock': stock
      };
}
