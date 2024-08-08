// import 'dart:convert';

// class BlogsModels {
//   final List<Blog>? blogs;

//   BlogsModels({
//     this.blogs,
//   });

//   factory BlogsModels.fromRawJson(String str) =>
//       BlogsModels.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory BlogsModels.fromJson(Map<String, dynamic> json) => BlogsModels(
//         blogs: json["blogs"] == null
//             ? []
//             : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "blogs": blogs == null
//             ? []
//             : List<dynamic>.from(blogs!.map((x) => x.toJson())),
//       };
// }

// class Blog {
//   final String? id;
//   final String? imageUrl;
//   final String? title;

//   Blog({
//     this.id,
//     this.imageUrl,
//     this.title,
//   });

//   factory Blog.fromRawJson(String str) => Blog.fromJson(json.decode(str));

//   String toRawJson() => json.encode(toJson());

//   factory Blog.fromJson(Map<String, dynamic> json) => Blog(
//         id: json["id"],
//         imageUrl: json["image_url"],
//         title: json["title"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "image_url": imageUrl,
//         "title": title,
//       };
// }

import 'dart:convert';

class BlogsModels {
  final String? id;
  final String? imageUrl;
  final String? title;

  BlogsModels({
    this.id,
    this.imageUrl,
    this.title,
  });

  factory BlogsModels.fromRawJson(String str) =>
      BlogsModels.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BlogsModels.fromJson(Map<String, dynamic> json) => BlogsModels(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
      };
}
