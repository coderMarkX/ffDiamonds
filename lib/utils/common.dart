// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'const.dart';
import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static mediaQ(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static Widget flatButton(context, double width, String title,
      {double fSize = 16}) {
    return Container(
        height: 50,
        width: width,
        decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: fSize)))));
  }

  static Widget button(String title, double width,
      {double radius: 10, double height = 50, Color color = primaryColor}) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: color,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 17, color: Colors.white),
      ),
    );
  }

  static Widget iosRoute(BuildContext context, Widget nav, Widget wid) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, CupertinoPageRoute(builder: (context) => nav));
        },
        child: wid);
  }

  // static Widget hireOrFind(String title, Color color, Color btnColor,
  //     double width, double height, String src, String btnText) {
  //   return Center(
  //     child: Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
  //         child: Container(
  //             height: height,
  //             width: width,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.all(Radius.circular(20)),
  //               color: color,
  //             ),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.spaceAround,
  //               children: [
  //                 Text(
  //                   title,
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 Container(height: 120, width: 120, child: Lottie.asset(src)),
  //                 // Image.asset(
  //                 //   src,
  //                 //   height: 100,
  //                 // ),
  //                 Utils.button(btnText, 100, height: 40, color: btnColor)
  //               ],
  //             ))),
  //   );
  // }

  static Widget normalTextField(String title, TextEditingController controller,
      {bool enabled = true,
      TextInputType type = TextInputType.text,
      int len = 500,
      int line = 1,
      icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0, right: 20, left: 20),
      child: TextField(
        controller: controller,
        maxLength: len,
        enabled: enabled,
        maxLines: line,
        keyboardType: type,
        decoration: InputDecoration(
          focusColor: primaryColor,
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            width: 2,
            color: primaryColor,
          )),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Colors.grey,
          )),
          counterText: "",
          border: new OutlineInputBorder(),
          labelText: title,
        ),
      ),
    );
  }

  // static Widget postFirst(String title, String msg, var icon) {
  //   return Container(
  //     height: 100,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //       children: [
  //         Icon(icon, color: primaryColor, size: 40),
  //         Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(title, style: TextStyle(fontSize: 14)),
  //             SizedBox(height: 3),
  //             Text(msg, style: TextStyle(fontSize: 12))
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static Widget jobCard(item, context,
  //     {isApplied = false, appliedCount, isEmp = false}) {
  //   const double leftP = 70.0;
  //   Future<String> getCity(cityId) async {
  //     var data2 = {
  //       "table": "job_cities",
  //       "where": {"id": cityId}
  //     };
  //     var cityD = jsonDecode(await ApiHelper.post(getDataWhere, data2));
  //     return cityD['data'][0]['asciiname'];
  //   }

  //   var jsonDec;
  //   var desSkill;
  //   if (item['data'] != null) {
  //     jsonDec = jsonDecode(item['data']);
  //     desSkill = jsonDec.containsKey('skills') ? jsonDec['skills'][0] : null;
  //   }

  //   Future<String> getType(typeId) async {
  //     var data2 = {
  //       "table": "job_product_type",
  //       "where": {"id": typeId}
  //     };
  //     var cityD = jsonDecode(await ApiHelper.post(getDataWhere, data2));
  //     return cityD['data'][0]['title'];
  //   }

  //   Future<String> getCcode(code) async {
  //     var data2 = {
  //       "table": "job_countries",
  //       "where": {"code": code}
  //     };
  //     var cityD = jsonDecode(await ApiHelper.post(getDataWhere, data2));
  //     return cityD['data'][0]['phone'];
  //   }

  //   Future<String> getSubName(id) async {
  //     var data2 = {
  //       "table": "job_catagory_sub",
  //       "where": {"sub_cat_id": id}
  //     };
  //     var cityD = jsonDecode(await ApiHelper.post(getDataWhere, data2));
  //     return cityD['data'][0]['sub_cat_name'] ?? "";
  //   }

  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
  //     child: ClayContainer(
  //       color: scafBg,
  //       parentColor: item['highlight'] == '1' ? Color(0xFF9EA4F8) : scafBg,
  //       depth: 30,
  //       spread: item['highlight'] == '1' ? 7 : 7,
  //       borderRadius: 15,
  //       child: Padding(
  //         padding: EdgeInsets.only(top: 10),
  //         child: Column(
  //           children: [
  //             SizedBox(height: 5),
  //             Row(
  //               // mainAxisAlignment: MainAxisAlignment.start,
  //               // crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Image.asset("assets/images/money.png",
  //                     color: primaryColor, height: 50, width: 70),
  //                 // item['company_image'] != null
  //                 //     ? Container(
  //                 //         margin: EdgeInsets.only(left: 10),
  //                 //         child: CircleAvatar(
  //                 //             radius: 20,
  //                 //             backgroundImage: CachedNetworkImageProvider(
  //                 //                 product_store + item['company_image'])),
  //                 //       )
  //                 //     : Container(
  //                 //         margin: EdgeInsets.only(left: 10),
  //                 //         padding: EdgeInsets.all(5),
  //                 //         decoration: BoxDecoration(
  //                 //           color: primaryColor,
  //                 //           borderRadius: BorderRadius.all(Radius.circular(30)),
  //                 //         ),
  //                 //         height: 40,
  //                 //         width: 40,
  //                 //         child: Center(
  //                 //           child: Text(
  //                 //               item['product_name']
  //                 //                   .substring(0, 1)
  //                 //                   .toUpperCase(),
  //                 //               textAlign: TextAlign.center,
  //                 //               style: TextStyle(
  //                 //                   color: Colors.white, fontSize: 20)),
  //                 //         ),
  //                 //       ),
  //                 // SizedBox(width: 10),
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Container(
  //                         margin: EdgeInsets.only(bottom: 5),
  //                         width: Utils.mediaQ(context).width - 150,
  //                         child: Text(item['product_name'],
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(
  //                                 color: primaryColor,
  //                                 fontSize: 17.0,
  //                                 fontWeight: FontWeight.w800))),
  //                     FutureBuilder<dynamic>(
  //                         future: getSubName(item['sub_category']),
  //                         builder: (context, dataa) {
  //                           return Container(
  //                             width: Utils.mediaQ(context).width - 150,
  //                             child: Text(dataa.data.toString() ?? "",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: TextStyle(color: Colors.grey[600])),
  //                           );
  //                         }),
  //                     SizedBox(height: 3),
  //                     Container(
  //                         width: Utils.mediaQ(context).width - 150,
  //                         child: Text(item['company_name'] ?? "",
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(color: blackColor))),
  //                     SizedBox(height: 5),
  //                   ],
  //                 ),
  //                 IconButton(
  //                   onPressed: () {
  //                     Share.share(
  //                         """Hey friends ! I just came across this amazing job opportunity of ${item['product_name']} at ${item['company_name']} of salary ${item['salary_min']} - ${item['salary_max']} ${item['salary_type'] == "4" ? "Hourly" : item['salary_type'] == "5" ? "Daily" : item['salary_type'] == "6" ? "Monthly" : "Yearly"} through the solvewins.com app - India’s largest and easy job-search app! This exactly matches your profile, hence check it out and Apply ASAP https://solvewins.com/job/${item['id']}""");
  //                   },
  //                   icon: Icon(Icons.share, color: Colors.grey[800]),
  //                 )
  //               ],
  //             ),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.end,
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 if (item['featured'] == '1')
  //                   Container(
  //                       margin: EdgeInsets.only(top: 8, left: leftP),
  //                       decoration: BoxDecoration(
  //                           color: Color(0xFF31A53B).withOpacity(.2),
  //                           borderRadius: BorderRadius.all(Radius.circular(5))),
  //                       child: Padding(
  //                         padding: const EdgeInsets.only(
  //                             right: 5, top: 2, bottom: 2, left: 5),
  //                         child: Text("Featured",
  //                             style: TextStyle(color: Color(0xFF31A53B))),
  //                       )),
  //                 if (item['urgent'] == '1')
  //                   Container(
  //                       margin: EdgeInsets.only(
  //                           top: 8, left: item['featured'] == '1' ? 10 : leftP),
  //                       decoration: BoxDecoration(
  //                         color: Color(0xFFFF0000).withOpacity(.2),
  //                         borderRadius: BorderRadius.all(Radius.circular(5)),
  //                       ),
  //                       child: Padding(
  //                           padding: const EdgeInsets.only(
  //                               right: 5, top: 2, bottom: 2, left: 5),
  //                           child: Text("Urgent",
  //                               style: TextStyle(color: Color(0xFFCC3F3F))))),
  //                 Row(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(
  //                           left: (item['featured'] == '1' &&
  //                                   item['urgent'] == '1')
  //                               ? 0
  //                               : leftP),
  //                       child: Icon(Icons.access_time_outlined,
  //                           color: primaryColor, size: 20),
  //                     ),
  //                     SizedBox(width: 5),
  //                     Container(
  //                         width: mediaQ(context).width / 4.3,
  //                         child: Text(
  //                             timeago
  //                                 .format(DateTime.parse(item['created_at'])),
  //                             overflow: TextOverflow.ellipsis,
  //                             style: TextStyle(color: Colors.grey[700]))),
  //                     SizedBox(width: 10),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 20),
  //             Row(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Padding(
  //                         padding: const EdgeInsets.only(left: leftP),
  //                         child: Icon(Icons.place_outlined,
  //                             color: primaryColor, size: 20)),
  //                     Container(
  //                         margin: EdgeInsets.only(left: 2),
  //                         child: FutureBuilder<dynamic>(
  //                             future: getCity(item['city']),
  //                             builder: (context, dataa) {
  //                               return Text(dataa.data.toString() ?? "",
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TextStyle(color: Colors.grey[700]));
  //                             })),
  //                   ],
  //                 ),
  //                 SizedBox(width: 20),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.timelapse_outlined,
  //                         color: primaryColor, size: 20),
  //                     Container(
  //                         margin: EdgeInsets.only(left: 2),
  //                         child: FutureBuilder<dynamic>(
  //                             future: getType(item['product_type']),
  //                             builder: (context, dataa) {
  //                               return Text(dataa.data.toString() ?? "",
  //                                   overflow: TextOverflow.ellipsis,
  //                                   style: TextStyle(color: Colors.grey[700]));
  //                             })),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             SizedBox(height: 10),
  //             Row(
  //               children: [
  //                 Row(
  //                   children: [
  //                     // SizedBox(width: 52),
  //                     Padding(
  //                         padding: const EdgeInsets.only(left: leftP + 2),
  //                         child: Icon(Icons.payments_outlined,
  //                             color: primaryColor, size: 20)),
  //                     Container(
  //                         margin: EdgeInsets.only(left: 5),
  //                         child: Text(
  //                           "${item['salary_min']}" +
  //                                   " - " +
  //                                   "${item['salary_max']}" ??
  //                               "",
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(color: Colors.grey[700]),
  //                         )),
  //                   ],
  //                 ),

  //                 jsonDec != null
  //                     ? Row(
  //                         children: [
  //                           SizedBox(width: 10),
  //                           Icon(Icons.business_center_outlined,
  //                               color: primaryColor, size: 20),
  //                           Container(
  //                               margin: EdgeInsets.only(left: 2),
  //                               child: Text(
  //                                 jsonDec.containsKey('experience')
  //                                     ? "${jsonDec['experience']['min']} - ${jsonDec['experience']['max']} Years"
  //                                     : "",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: TextStyle(color: Colors.grey[700]),
  //                               )),
  //                         ],
  //                       )
  //                     : Container(),

  //                 // Row(
  //                 //   children: [
  //                 //     SizedBox(width: 10),
  //                 //     Icon(Icons.place_outlined, color: primaryColor, size: 20),
  //                 //     Container(
  //                 //         margin: EdgeInsets.only(left: 2),
  //                 //         child: FutureBuilder<dynamic>(
  //                 //             future: getCity(item['city']),
  //                 //             builder: (context, dataa) {
  //                 //               return Text(
  //                 //                 dataa.data.toString() ?? "",
  //                 //                 overflow: TextOverflow.ellipsis,
  //                 //                 style: TextStyle(color: Colors.grey[700]),
  //                 //               );
  //                 //             })),
  //                 //   ],
  //                 // ),
  //               ],
  //             ),
  //             SizedBox(height: 5),
  //             appliedCount == null
  //                 ? Container()
  //                 : Padding(
  //                     padding: EdgeInsets.only(left: leftP + 2),
  //                     child: appliedCount,
  //                   ),
  //             SizedBox(height: 10),
  //             desSkill != null
  //                 ? Column(
  //                     children: [
  //                       Row(
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.only(left: leftP),
  //                             child: Text(
  //                                 "Skills : $desSkill +${jsonDec['skills'].length - 1}",
  //                                 style: TextStyle(color: Colors.grey)),
  //                           ),
  //                         ],
  //                       ),
  //                       SizedBox(height: 10),
  //                     ],
  //                   )
  //                 : Text(""),
  //             isApplied
  //                 ? Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       isEmp
  //                           ? Container(
  //                               margin: EdgeInsets.only(left: 20),
  //                               decoration: BoxDecoration(
  //                                 color: item['status'] == 'active'
  //                                     ? Color(0xFF31A53B).withOpacity(.2)
  //                                     : item['status'] == 'pending'
  //                                         ? Color(0xFFFF9204).withOpacity(.2)
  //                                         : Color(0xFFD14444).withOpacity(.2),
  //                                 borderRadius:
  //                                     BorderRadius.all(Radius.circular(5)),
  //                               ),
  //                               child: Padding(
  //                                 padding: const EdgeInsets.only(
  //                                     right: 10, top: 10, bottom: 10, left: 10),
  //                                 child: item['status'] == 'active'
  //                                     ? Text("Active",
  //                                         style: TextStyle(
  //                                             color: Color(0xFF31A53B),
  //                                             fontSize: 18))
  //                                     : item['status'] == 'pending'
  //                                         ? Text("Pending",
  //                                             style: TextStyle(
  //                                                 color: Color(0xFFD88519),
  //                                                 fontSize: 18))
  //                                         : Text("Expired",
  //                                             style: TextStyle(
  //                                                 color: Color(0xFFD14444),
  //                                                 fontSize: 18)),
  //                               ))
  //                           : Container(),
  //                       Container(
  //                           margin: EdgeInsets.only(right: 00),
  //                           width: Utils.mediaQ(context).width / 2.2,
  //                           height: 50,
  //                           decoration: BoxDecoration(
  //                             color: primaryColor,
  //                             borderRadius: BorderRadius.only(
  //                                 bottomRight: Radius.circular(15),
  //                                 topLeft: Radius.circular(15)),
  //                           ),
  //                           child: Center(
  //                               child: Text("View",
  //                                   style: TextStyle(
  //                                       color: whiteColor, fontSize: 20))))
  //                     ],
  //                   )
  //                 : Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: [
  //                       // likedId.contains(item['id'])
  //                       //     ? IconButton(
  //                       //         onPressed: () async {
  //                       //           Utils.showLoadingDialog(
  //                       //               context, _keyLoader);
  //                       //           likedId
  //                       //               .remove(item['id']);
  //                       //           jsonDecode(
  //                       //               await ApiHelper.post(
  //                       //                   deleteData, {
  //                       //             "table": "job_favads",
  //                       //             "data2": {
  //                       //               "user_id":
  //                       //                   userData['id'],
  //                       //               "product_id":
  //                       //                   item['id']
  //                       //             }
  //                       //           }));
  //                       //           likedJobs.remove(item);
  //                       //           setState(() {});
  //                       //           Navigator.of(context,
  //                       //                   rootNavigator:
  //                       //                       true)
  //                       //               .pop('dialog');
  //                       //           showToast(
  //                       //               "Job Removed from Favorite");
  //                       //         },
  //                       //         icon: Icon(Icons.favorite,
  //                       //             color: Colors.red[400],
  //                       //             size: 30),
  //                       //         // size: 23,
  //                       //       )
  //                       //     : IconButton(
  //                       //         onPressed: () async {
  //                       //           Utils.showLoadingDialog(
  //                       //               context, _keyLoader);
  //                       //           likedId.add(item['id']);
  //                       //           jsonDecode(
  //                       //               await ApiHelper.post(
  //                       //                   addData, {
  //                       //             "table": "job_favads",
  //                       //             "data2": {
  //                       //               "user_id":
  //                       //                   userData['id'],
  //                       //               "product_id":
  //                       //                   item['id']
  //                       //             }
  //                       //           }));
  //                       //           likedJobs.add(item);
  //                       //           setState(() {});
  //                       //           Navigator.of(context,
  //                       //                   rootNavigator:
  //                       //                       true)
  //                       //               .pop('dialog');
  //                       //           showToast(
  //                       //               "Job Added in Favorite");
  //                       //         },
  //                       //         icon: Icon(
  //                       //             Icons.favorite_border,
  //                       //             color: primaryColor),
  //                       //       ),

  //                       GestureDetector(
  //                         onTap: () async {
  //                           var code = item['country'] != null
  //                               ? await getCcode(item['country'])
  //                               : "91";
  //                           var url =
  //                               "https://wa.me/${code + item['phone']}?text=Hi ${item['company_name']}, %0a I got your number from the *Solvewins App*. I am interested in your job - *${item['product_name']}, ${item['location']}* https://solvewins.com/job/${item['id']}. Please check out my detailed profile at - https://solvewins.com/userInfoApp?id=${userData['id']} Eagerly looking forward to hearing from you.";
  //                           await launch(url);
  //                         },
  //                         child: Container(
  //                             margin: EdgeInsets.only(top: 2),
  //                             width: Utils.mediaQ(context).width / 2.2,
  //                             height: 45,
  //                             decoration: BoxDecoration(
  //                                 color: Colors.green[400],
  //                                 borderRadius: BorderRadius.only(
  //                                     bottomLeft: Radius.circular(15))),
  //                             child: Center(
  //                                 child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 Text("Whatsapp",
  //                                     style: TextStyle(
  //                                         color: whiteColor, fontSize: 20)),
  //                                 SizedBox(width: 10),
  //                                 Icon(FontAwesomeIcons.whatsapp,
  //                                     color: Colors.white, size: 30),
  //                               ],
  //                             ))),
  //                       ),
  //                       Container(
  //                           margin: EdgeInsets.only(top: 2),
  //                           width: Utils.mediaQ(context).width / 2.2,
  //                           height: 45,
  //                           decoration: BoxDecoration(
  //                             color: primaryColor,
  //                             borderRadius: BorderRadius.only(
  //                                 bottomRight: Radius.circular(15)),
  //                           ),
  //                           child: Center(
  //                               child: Text("Apply",
  //                                   style: TextStyle(
  //                                       color: whiteColor, fontSize: 20)))),
  //                     ],
  //                   )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // static Widget postedJobTile(String pName, String date, String subcat,
  //     String status, String views, var size) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
  //     child: Container(
  //         decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.grey,
  //                   blurRadius: 3,
  //                   offset: Offset.zero // Shadow position
  //                   ),
  //             ],
  //             borderRadius: BorderRadius.all(Radius.circular(15)),
  //             color: Colors.white),
  //         child: Column(
  //           children: [
  //             Utils.leftContainer(
  //                 Row(
  //                   children: [
  //                     Icon(
  //                       Icons.access_time_outlined,
  //                       color: primaryColor,
  //                       size: 20,
  //                     ),
  //                     Text(timeago.format(DateTime.parse(date))),
  //                   ],
  //                 ),
  //                 top: 5,
  //                 left: 8),
  //             SizedBox(height: 10),
  //             Row(
  //               children: [
  //                 Container(
  //                   margin: EdgeInsets.only(top: 10, left: 30),
  //                   decoration: BoxDecoration(
  //                     color: primaryColor,
  //                     borderRadius: BorderRadius.all(Radius.circular(30)),
  //                   ),
  //                   height: 50,
  //                   width: 50,
  //                   child: Center(
  //                     child: Text(pName.substring(0, 1).toUpperCase(),
  //                         textAlign: TextAlign.center,
  //                         style: TextStyle(color: Colors.white, fontSize: 25)),
  //                   ),
  //                 ),
  //                 Container(
  //                   margin: EdgeInsets.only(left: 20, right: 10),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: [
  //                       Container(
  //                         width: size.width - 170,
  //                         child: Text(
  //                           pName,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: headTitle,
  //                         ),
  //                       ),
  //                       Container(
  //                         width: size.width - 170,
  //                         child: Text(
  //                           subcat,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: titleSmall,
  //                         ),
  //                       ),
  //                       Container(
  //                           margin: EdgeInsets.only(top: 8),
  //                           decoration: BoxDecoration(
  //                             color: status == 'active'
  //                                 ? Color(0xFF31A53B).withOpacity(.2)
  //                                 : status == 'pending'
  //                                     ? Color(0xFFFF9204).withOpacity(.2)
  //                                     : Color(0xFFD14444).withOpacity(.2),
  //                             borderRadius:
  //                                 BorderRadius.all(Radius.circular(5)),
  //                           ),
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(
  //                                 right: 5, top: 2, bottom: 2, left: 5),
  //                             child: status == 'active'
  //                                 ? Text("Active",
  //                                     style:
  //                                         TextStyle(color: Color(0xFF31A53B)))
  //                                 : status == 'pending'
  //                                     ? Text("Pending",
  //                                         style: TextStyle(
  //                                             color: Color(0xFFD88519)))
  //                                     : Text("Expired",
  //                                         style: TextStyle(
  //                                             color: Color(0xFFD14444))),
  //                           )),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 Icon(Icons.remove_red_eye_outlined,
  //                     color: primaryColor, size: 20),
  //                 Container(
  //                     margin: EdgeInsets.only(right: 10, left: 3),
  //                     child: Text(views, style: blackHeadingTextStyle)),
  //               ],
  //             ),
  //           ],
  //         )),
  //   );
  // }

  // static Widget userInfoTile(context, item,
  //     {bool check = false, fav, haveAd = false}) {
  //   Future<String> getExp(id) async {
  //     var exp = jsonDecode(await ApiHelper.post(getUserExpYear, {"id": id}));
  //     return exp['data'].toString();
  //   }

  //   var desc;
  //   if (item['data'] != null && item['data'].length > 1) {
  //     desc = jsonDecode(item['data']);
  //   }

  //   return ClayContainer(
  //       color: scafBg,
  //       parentColor: scafBg,
  //       depth: 30,
  //       spread: 7,
  //       borderRadius: 15,
  //       // decoration: BoxDecoration(
  //       //     boxShadow: [
  //       //       BoxShadow(
  //       //           color: Colors.grey,
  //       //           blurRadius: 3,
  //       //           offset: Offset.zero // Shadow position
  //       //           ),
  //       //     ],
  //       //     borderRadius: BorderRadius.all(Radius.circular(15)),
  //       //     color: Colors.white),
  //       child:
  //           // item.containsKey('adUrl')
  //           //     ? CachedNetworkImage(
  //           //         imageUrl: desBeforeAtRate(item['adUrl']), height: 130)
  //           //     :

  //           Column(
  //         children: [
  //           SizedBox(height: 10),
  //           Row(
  //             children: [
  //               Container(
  //                 margin: EdgeInsets.only(left: 20, top: 20),
  //                 height: 60,
  //                 width: 60,
  //                 decoration:
  //                     BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
  //                 child: CircleAvatar(
  //                   backgroundColor: primaryColor,
  //                   child: CircleAvatar(
  //                     radius: 90.0,
  //                     child: ClipOval(
  //                         child:
  //                             Utils.cachedImage(profile_store + item['image'])),
  //                     backgroundColor: Colors.white,
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: EdgeInsets.only(left: 20, right: 10),
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     Container(
  //                       width: mediaQ(context).width - 170,
  //                       child: Text(
  //                         item['name'] ?? "",
  //                         overflow: TextOverflow.ellipsis,
  //                         style: TextStyle(
  //                           color: blackColor,
  //                           fontSize: 17.0,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Text(
  //                       item['sex'] ?? "",
  //                       style: TextStyle(color: primaryColor, fontSize: 15),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Row(
  //                       children: [
  //                         item['asciiname'] != null
  //                             ? Row(
  //                                 children: [
  //                                   Icon(Icons.location_on_outlined,
  //                                       size: 20, color: primaryColor),
  //                                   Text(
  //                                     item['asciiname'],
  //                                     overflow: TextOverflow.ellipsis,
  //                                     style: titleSmall,
  //                                   ),
  //                                 ],
  //                               )
  //                             : Text(""),
  //                         SizedBox(width: 10),
  //                         Row(
  //                           children: [
  //                             Icon(Icons.payments_outlined,
  //                                 size: 20, color: primaryColor),
  //                             Text(
  //                                 " " +
  //                                     "${item['salary_min']} - ${item['salary_max']}",
  //                                 overflow: TextOverflow.ellipsis,
  //                                 style: titleSmall),
  //                           ],
  //                         )
  //                       ],
  //                     ),
  //                     SizedBox(height: 10),
  //                     Row(
  //                       children: [
  //                         Row(
  //                           children: [
  //                             Icon(Icons.work_outline,
  //                                 color: primaryColor, size: 20),
  //                             Container(
  //                                 margin: EdgeInsets.only(left: 2),
  //                                 child: FutureBuilder<dynamic>(
  //                                     future: getExp(item['id']),
  //                                     builder: (context, dataa) {
  //                                       return Text(
  //                                           dataa.data.toString() + " Years",
  //                                           overflow: TextOverflow.ellipsis,
  //                                           style: TextStyle(
  //                                               color: Colors.grey[700]));
  //                                     })),
  //                           ],
  //                         ),
  //                         SizedBox(width: 10),
  //                         (desc != null && desc.length > 1)
  //                             ? Row(
  //                                 children: [
  //                                   Icon(Icons.school_outlined,
  //                                       color: primaryColor, size: 20),
  //                                   Container(
  //                                       margin: EdgeInsets.only(left: 2),
  //                                       child: Text(desc['highEdu'])),
  //                                 ],
  //                               )
  //                             : Container(),
  //                       ],
  //                     ),
  //                     SizedBox(height: 10),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //           fav,
  //           SizedBox(height: 5)
  //         ],
  //       ));
  // }

  // static Widget optionTile(
  //     BuildContext context, Widget wid, var icon, String title) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 7),
  //     child: ClayContainer(
  //       color: scafBg,
  //       depth: 30,
  //       spread: 7,
  //       borderRadius: 15,
  //       child: ListTile(
  //           onTap: () {
  //             Navigator.push(
  //                 context, CupertinoPageRoute(builder: (context) => wid));
  //           },
  //           title: Text(title),
  //           leading: Icon(icon, color: primaryColor.withOpacity(.7)),
  //           trailing: Icon(Icons.arrow_forward_ios, size: 20)),
  //     ),
  //   );
  // }

  static Widget leftContainer(Widget wid, {double top: 20, double left: 20}) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top),
      child: wid,
    );
  }

  static Widget simpleTitle(String title,
      {double top: 20,
      double left: 20,
      double right: 20,
      double fSize = 25,
      Color color = primaryColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color.withOpacity(0.1),
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top, right: right, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
            style: TextStyle(
                color: color, fontSize: fSize, fontWeight: FontWeight.bold)),
      ),
    );
  }

  static Widget titleWIcon(String title, IconData icon,
      {double top: 20,
      double left: 20,
      double right: 20,
      double fSize = 25,
      double iSize = 25,
      Color color = primaryColor,
      Color iColor = primaryColor}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: color.withOpacity(0.2),
      ),
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: left, top: top, right: right, bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                icon,
                color: iColor ?? color,
                size: iSize,
              ),
            ),
            Text(title,
                style: TextStyle(
                    color: color,
                    fontSize: fSize,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  static Widget noData({color: primaryColor}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.bolt_slash,
              size: 180,
              color: primaryColor,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Data Found",
            style: TextStyle(
                color: primaryColor, fontSize: 30, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  static Widget noDataSmall({color: primaryColor}) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.bolt_slash,
              size: 40,
              color: color,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "No Data Found",
            style: TextStyle(
                color: color, fontSize: 15, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  static Widget loading() {
    return Center(
      child: new Container(
        width: 140.0,
        height: 140.0,
        child: Column(
          children: [
            Lottie.asset('assets/animation/loading.json'),
  
          ],
        ),
      ),
    );
  }

  // static Widget cachedImage(url, {double height = 100, double width = 100}) {
  //   return CachedNetworkImage(
  //     imageUrl: url,
  //     imageBuilder: (context, imageProvider) => Container(
  //         height: height,
  //         width: width,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             image: imageProvider,
  //             fit: BoxFit.cover,
  //           ),
  //         )),
  //   );
  // }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.white,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(primaryColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: primaryColor),
                        )
                      ]),
                    )
                  ]));
        });
  }

  // flatDialog(context, width) {
  //   return showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         elevation: 5.0,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
  //         child: Container(
  //           // padding: EdgeInsets.all(20.0),
  //           child: Wrap(
  //             children: <Widget>[
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: <Widget>[
  //                   Padding(
  //                     padding: EdgeInsets.all(10.0),
  //                     child: Text(
  //                       "asd",
  //                       // AppTranslations.of(this.context)
  //                       //     .text('key_sureLogout'),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 10.0,
  //                   ),
  //                   Padding(
  //                     padding: EdgeInsets.only(right: 10.0, left: 10.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: <Widget>[
  //                         InkWell(
  //                           onTap: () {
  //                             Navigator.pop(context);
  //                           },
  //                           child: Container(
  //                             width: (width / 3.5),
  //                             alignment: Alignment.center,
  //                             padding: EdgeInsets.all(10.0),
  //                             decoration: BoxDecoration(
  //                               color: Colors.grey[300],
  //                               borderRadius: BorderRadius.circular(5.0),
  //                             ),
  //                             child: Text(
  //                               "asd",
  //                               // AppTranslations.of(this.context).text('key_no'),
  //                               style: TextStyle(
  //                                 fontSize: 15.0,
  //                                 color: Colors.black,
  //                                 fontWeight: FontWeight.w400,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: 20.0,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static snackbar(context, String text, {bgColor = Colors.black}) {
    final snackBar = SnackBar(
      content: Text('$text '),
      backgroundColor: bgColor,
      duration: Duration(seconds: 3),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static success(context, Widget wid,
      {String text = "Success", IconData icon = Icons.check_circle}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(milliseconds: 300), () async {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (BuildContext context) => wid),
                (route) => false);
          });
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                  width: 180.0,
                  height: 130.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Icon(icon, color: primaryColor, size: 70),
                      Text(text,
                          style: TextStyle(color: primaryColor, fontSize: 30))
                    ],
                  )),
            ),
          );
        });
  }
}

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({
    this.isBackButton = true,
    this.title,
    this.actions,
    this.goto,
    this.isGoto = false,
    Key key,
  }) : super(key: key);
  final bool isBackButton;
  final String title;
  final List<Widget> actions;
  final bool isGoto;
  final Widget goto;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isBackButton
          ? null
          : BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                !isBackButton
                    ? Container()
                    : GestureDetector(
                        onTap: () {
                          isGoto
                              ? Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) => goto))
                              : Navigator.pop(context);
                        },
                        child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: primaryColor.withOpacity(.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              // border: Border.all(
                              //   color: primaryColor,
                              //   width: 1,
                              // ),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_left,
                              color: primaryColor,
                              size: 28,
                            )),
                      ),
                title == null
                    ? Container()
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          actions == null
              ? Container()
              : Row(
                  children: actions,
                ),
        ],
      ),
    );
  }
}

// void showToast(message, {Color color = Colors.black}) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_LONG,
//       timeInSecForIos: 2,
//       backgroundColor: color,
//       textColor: Colors.white,
//       fontSize: 16.0);
// }

class LinePathClass extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 50);

    var firstEndPoint = Offset(size.width * .7, size.height - 40);
    var firstControlPoint = Offset(size.width * .25, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, size.height - 45);
    var secondControlPoint = Offset(size.width * 0.84, size.height - 50);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return false;
  }
}
