

// class Cat {
//   final String id;
//   final String name;
//   final String pic;
//   final String slug;
//   Cat({this.id, this.name, this.pic, this.slug});
//   factory Cat.fromJson(Map<String, dynamic> json) {
//     return Cat(
//         id: json['cat_id'],
//         name: json['cat_name'],
//         pic: json['picture'],
//         slug: json['slug']);
//   }
// }

// class SubCat {
//   final String id;
//   final String name;
//   final String slug;
//   SubCat({this.id, this.name, this.slug});
//   factory SubCat.fromJson(Map<String, dynamic> json) {
//     return SubCat(
//         id: json['sub_cat_id'], name: json['sub_cat_name'], slug: json['slug']);
//   }
// }

// class Boards {
//   final String id;
//   final String name;
//   Boards({this.id, this.name});
//   factory Boards.fromJson(Map<String, dynamic> json) {
//     return Boards(
//       id: json['b_id'],
//       name: json['b_name'],
//     );
//   }
// }

// class DiplomaC {
//   final String id;
//   final String name;
//   DiplomaC({this.id, this.name});
//   factory DiplomaC.fromJson(Map<String, dynamic> json) {
//     return DiplomaC(
//       id: json['id'],
//       name: json['course_name'],
//     );
//   }
// }

// class DiplomaU {
//   final String id;
//   final String name;
//   DiplomaU({this.id, this.name});
//   factory DiplomaU.fromJson(Map<String, dynamic> json) {
//     return DiplomaU(
//       id: json['u_id'],
//       name: json['u_name'],
//     );
//   }
// }

// class DiplomaSp {
//   final String id;
//   final String name;
//   DiplomaSp({this.id, this.name});
//   factory DiplomaSp.fromJson(Map<String, dynamic> json) {
//     return DiplomaSp(
//       id: json['id'],
//       name: json['specialization'],
//     );
//   }
// }

// class GraduateC {
//   final String id;
//   final String name;
//   GraduateC({this.id, this.name});
//   factory GraduateC.fromJson(Map<String, dynamic> json) {
//     return GraduateC(
//       id: json['id'],
//       name: json['course_name'],
//     );
//   }
// }

// class GraduateU {
//   final String id;
//   final String name;
//   GraduateU({this.id, this.name});
//   factory GraduateU.fromJson(Map<String, dynamic> json) {
//     return GraduateU(
//       id: json['u_id'],
//       name: json['u_name'],
//     );
//   }
// }

// class GraduateSp {
//   final String id;
//   final String name;
//   GraduateSp({this.id, this.name});
//   factory GraduateSp.fromJson(Map<String, dynamic> json) {
//     return GraduateSp(
//       id: json['id'],
//       name: json['specialization'],
//     );
//   }
// }

// class Medium {
//   final String id;
//   final String name;
//   Medium({this.id, this.name});
//   factory Medium.fromJson(Map<String, dynamic> json) {
//     return Medium(id: json['id'], name: json['s_medium']);
//   }
// }

// class PostgraduateC {
//   final String id;
//   final String name;
//   PostgraduateC({this.id, this.name});
//   factory PostgraduateC.fromJson(Map<String, dynamic> json) {
//     return PostgraduateC(
//       id: json['c_id'],
//       name: json['c_name'],
//     );
//   }
// }

// class PostgraduateU {
//   final String id;
//   final String name;
//   PostgraduateU({this.id, this.name});
//   factory PostgraduateU.fromJson(Map<String, dynamic> json) {
//     return PostgraduateU(
//       id: json['u_id'],
//       name: json['u_name'],
//     );
//   }
// }

// class PostgraduateSp {
//   final String id;
//   final String name;
//   PostgraduateSp({this.id, this.name});
//   factory PostgraduateSp.fromJson(Map<String, dynamic> json) {
//     return PostgraduateSp(
//       id: json['id'],
//       name: json['specialization'],
//     );
//   }
// }

// class PhdC {
//   final String id;
//   final String name;
//   PhdC({this.id, this.name});
//   factory PhdC.fromJson(Map<String, dynamic> json) {
//     return PhdC(
//       id: json['c_id'],
//       name: json['c_name'],
//     );
//   }
// }

// class PhdU {
//   final String id;
//   final String name;
//   PhdU({this.id, this.name});
//   factory PhdU.fromJson(Map<String, dynamic> json) {
//     return PhdU(
//       id: json['u_id'],
//       name: json['u_name'],
//     );
//   }
// }

// class PhdSp {
//   final String id;
//   final String name;
//   PhdSp({this.id, this.name});
//   factory PhdSp.fromJson(Map<String, dynamic> json) {
//     return PhdSp(
//       id: json['id'],
//       name: json['specialization'],
//     );
//   }
// }

// String formatDate(String date) {
//   return DateFormat("dd-MMM-yyyy hh:mm a")
//       .format(DateFormat("yyyy-MM-dd hh:mm").parse(date))
//       .toString();
// }

// //ID
// String desId(String res) {
//   return res.substring(res.indexOf('#') + 1);
// }

// String desBeforeHash(String res) {
//   return res.substring(0, res.indexOf('#'));
// }

// //Name
// String desBeforeAtRate(String res) {
//   return res.substring(0, res.indexOf('@'));
// }

// String desAfterAtRate(String res) {
//   return res.substring(res.indexOf('@') + 1);
// }

// //slug
// String desBetPerAt(String res) {
//   return res.substring(res.indexOf('%') + 1, res.indexOf('@'));
// }

// String desBetRateHash(String res) {
//   return res.substring(res.indexOf('@') + 1, res.indexOf('#'));
// }

// //pic
// String desBetAtUnder(String res) {
//   return res.substring(res.indexOf('@') + 1, res.indexOf('#'));
// }

// String desBefPer(String res) {
//   return res.substring(0, res.indexOf('%'));
// }

// String desBeforeComa(String res) {
//   return res.substring(0, res.indexOf(','));
// }
