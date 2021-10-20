// @dart=2.9
import 'package:ffdiamonds/services/FireBaseServices.dart';
import 'package:ffdiamonds/utils/common.dart';
import 'package:ffdiamonds/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10),
            AppBarWidget(title: "Notification"),
            FutureBuilder<dynamic>(
                future: FBService.getInsideData(
                    'notification', FBService.getUser().uid),
                builder: (context, data) {
                  return !data.hasData
                      ? Utils.loading()
                      : data.data.value == null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    height: 350,
                                    child: Lottie.asset(
                                        'assets/animation/error.json')),
                              ],
                            )
                          : ListView.builder(
                              itemCount: data.data.value.length,
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var item = data.data[index];
                                return Container(
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        color: primaryColor.withOpacity(.2)),
                                    child: ListTile(
                                        title: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: Text(item['title']),
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(item['body']),
                                        )));
                              });
                })
          ],
        ),
      ),
    );
  }
}
