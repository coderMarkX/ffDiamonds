// @dart=2.9
import 'package:ffdiamonds/utils/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key key}) : super(key: key);

  // makeSeen() async {
  //   await ApiHelper.post(updateData, {
  //     "table": "app_noti",
  //     "where": {"user_id": userData['id']},
  //     "data2": {'seen': '1'}
  //   });

  //   for (var i in notif) {
  //     if (i.containsValue('0')) {
  //       i['seen'] = '1';
  //     }
  //   }
  //   return notif;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            AppBarWidget(title: "Notification"),
            // FutureBuilder<dynamic>(
            //     future: makeSeen(),
            //     builder: (context, data) {
            //       return !data.hasData
            //           ? Utils.loading()
            //           : ListView.builder(
            //               itemCount: data.data.length,
            //               physics: BouncingScrollPhysics(),
            //               shrinkWrap: true,
            //               itemBuilder: (context, index) {
            //                 var item = data.data[index];
            //                 return GestureDetector(
            //                   onTap: () {
            //                     Navigator.push(
            //                         context,
            //                         CupertinoPageRoute(
            //                             builder: (context) => NotiJobDetail(
            //                                 item['job_id'], false)));
            //                   },
            //                   child: Container(
            //                       margin: EdgeInsets.all(10),
            //                       decoration: BoxDecoration(
            //                           borderRadius:
            //                               BorderRadius.all(Radius.circular(15)),
            //                           color: primaryColor.withOpacity(.2)),
            //                       child: ListTile(
            //                           title: Padding(
            //                             padding:
            //                                 const EdgeInsets.only(top: 8.0),
            //                             child: Text(item['title']),
            //                           ),
            //                           subtitle: Padding(
            //                             padding: const EdgeInsets.symmetric(
            //                                 vertical: 8.0),
            //                             child: Text(item['body']),
            //                           ))),
            //                 );
            //               });
            //     })
          ],
        ),
      ),
    );
  }
}
