import 'package:fleet_tracker/Controller/Setting/UserBlockList/user_block_list_contorller.dart';
import 'package:fleet_tracker/Model/Entity/user.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/Dialog/custom_dialog.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_appbar.dart';
import 'package:fleet_tracker/View/Component/CustomWidget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserBlockListView extends StatefulWidget {
  const UserBlockListView({super.key});

  @override
  State<UserBlockListView> createState() => _UserBlockListViewState();
}

class _UserBlockListViewState extends State<UserBlockListView> {
  @override
  Widget build(BuildContext context) {
    UserBlockListController controller = UserBlockListController();
    return Scaffold(
      appBar: CustomAppBar(
        title: 'ブロックリスト',
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: controller.getBlockList(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                List<User> data = snapshot.data!;

                if (data.isEmpty) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.only(top: 18),
                      child: const CustomText(
                        text: 'ブロックユーザーがいません',
                        fontSize: 14,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: CustomText(
                          text: data[index].name,
                          fontSize: 14,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          CustomDialog().showCustomDialog(
                            context: context,
                            title: 'ブロック解除',
                            content: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            detail: '${snapshot.data![index].name}をブロック解除しますか？',
                            buttonText: '解除',
                            buttonAction: () {
                              controller.removeBlockList(data[index].uid);
                              Fluttertoast.showToast(msg: '該当ユーザーのブロックを解除しました');
                              setState(() {});
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop();
                            },
                            isShowRejectButton: true,
                            rejectButtonTest: 'キャンセル',
                            barrierDismissible: true,
                          );
                        },
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
