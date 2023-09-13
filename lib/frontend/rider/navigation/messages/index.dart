import 'package:flutter/material.dart';
import '/package.dart';

class Messages extends StatefulWidget {
  static String route = '/Messages';

  const Messages({super.key});

  @override
  State<Messages> createState() => MessagesState();
}

class MessagesState extends State<Messages> {
  List users = [];
  List messages = [];
  late Stream stream;
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserChat();
      await chatUserList();
      setState(() {});
    });

    api.request.broadcast((controller) {
      stream = controller;
      subscription = stream.listen((event) {});
    });

    // api.request.broadcast((callback) {
    // });
  }

  Future chatUserList() async {
    await api.request.chatUserList(
      onIndicator: (response) {
        // Indicator.call(response, context: context);
      },
      onCache: (response) {
        setState(() {
          users = response;
        });
      },
      onSuccess: (response) {
        if (response.data.length > 0) {
          setState(() {
            users = response.data ?? [];
          });
        }
      },
      onError: (err) {
        // Snackbar.error(context, message: err);
      },
    );
  }

  Future getUserChat() async {
    await api.request.getUserChat(
      onIndicator: (response) {
        // Indicator.call(response, context: context);
      },
      onCache: (response) {
        setState(() {
          messages = response;
        });
      },
      onSuccess: (response) {
        if (response.data.length > 0) {
          setState(() {
            messages = response.data ?? [];
          });
        }
      },
      onError: (err) {
        // Snackbar.error(context, message: err);
      },
    );
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Messages').text.black.make(),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                showMyDialog(context, users: users[index], messages: messages);
              },
              title: Text(
                "${users[index]['first_name']} ${users[index]['last_name']}",
              ),
              subtitle: Text(
                "${users[index]['updated_at']}",
              ),
              trailing: SizedBox(
                height: 50,
                width: 50,
                child: users[index]['image'] == null
                    ? ClipOval(
                        child: Image.asset(
                          Assets.drawable.profile,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipOval(
                        child: Image.network(
                          'https://via.placeholder.com/150',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
          );
        },
      ).px(12).py(20),
    );
  }

  void showMyDialog(context, {required users, required messages}) async {
    TextEditingController? controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        List<Widget> children = [];
        for (var message in messages) {
          if (users['id'].toString() == message['receiver_id'].toString()) {
            children.add(
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 1 / 2,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: "${message['message']}".text.make(),
                ).pOnly(bottom: 4, left: 10),
              ),
            );
          } else if (users['id'].toString() ==
              message['sender_id'].toString()) {
            children.add(
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 1 / 2,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                  child:
                      "${message['message']}".text.color(Colors.white).make(),
                ),
              ).pOnly(bottom: 15, right: 10),
            );
          }
        }

        return StatefulBuilder(
          builder: (context, setState) {
            void onSend() {
              children.add(
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width * 1 / 2,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: controller.text.text.make(),
                  ).pOnly(bottom: 4, left: 10),
                ),
              );
              api.request.postMessage(
                receiverId: users['id'],
                message: controller.text,
                onIndicator: (response) {
                  // Indicator.call(response, context: context);
                },
                onSuccess: (response) {
                  setState(() {});
                },
                onError: (err) {
                  // Snackbar.error(context, message: err);
                },
              );
              controller.clear();
              setState(() {});
            }

            return AlertDialog(
              actionsPadding: const EdgeInsets.symmetric(horizontal: 0),
              titlePadding: const EdgeInsets.symmetric(horizontal: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 25,
                ),
                title: Text(
                  "${users['first_name']} ${users['last_name']}",
                ),
                subtitle: const Text("Active Now"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.call,
                      size: 25,
                      color: Colors.black,
                    ).onTap(() {}),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.cancel_sharp,
                      size: 25,
                      color: Colors.black54,
                    ).onTap(() {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: children,
                ),
              ),
              actions: [
                SizedBox(width: MediaQuery.of(context).size.width),
                const Divider(
                  indent: 500,
                  thickness: 100,
                ),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15,
                    ),
                    hintText: "Enter Message",
                    suffixIcon: SizedBox(
                      child: IconButton(
                        onPressed: onSend,
                        icon: const Icon(Icons.send),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
