import 'package:chatting_app_clone/common.dart';
import 'package:chatting_app_clone/widgets/logout_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}
var _contents = '';
var user = FirebaseAuth.instance;
final _controller = TextEditingController();

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Text('채팅'),
        actions: [
          CupertinoButton(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Icon(Icons.logout_outlined,color: Colors.white,),
                ],
              ),
              onPressed: () async {
                showDialog(context: context, builder: (context) => LogoutDialog());
              }
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('chat').orderBy('time',descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if(snapshot.hasData){
                  final _chat = snapshot.data!.docs;
                  return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemCount: _chat.length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: mediaHeight(context, 0.02)),
                          child: Row(
                            mainAxisAlignment: _chat[index]['uid'] == user.currentUser!.uid ?MainAxisAlignment.end : MainAxisAlignment.start,
                            children: [
                              UnconstrainedBox(
                                child: Row(
                                  children: [
                                    Container(
                                        width: mediaHeight(context, 0.3),
                                        padding: EdgeInsets.all(mediaHeight(context, 0.01)),
                                        margin: EdgeInsets.symmetric(vertical: mediaHeight(context, 0.005)),
                                        decoration: BoxDecoration(
                                            color: _chat[index]['uid'] == user.currentUser!.uid ? Colors.blue : Colors.grey,
                                            borderRadius: BorderRadius.only(
                                                topRight: const Radius.circular(12),
                                                topLeft: const Radius.circular(12),
                                                bottomRight: _chat[index]['uid'] == user.currentUser!.uid ? const Radius.circular(0) :  const Radius.circular(12),
                                                bottomLeft: _chat[index]['uid'] == user.currentUser!.uid ? const Radius.circular(12) :  const Radius.circular(0)
                                            )
                                        ),
                                        child: Text(_chat[index]['text'],style: CustomTextStyle.w300(context,color: Colors.white),)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }else{
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                }
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: mediaHeight(context, 0.02)),
                  child: TextField(
                    maxLines: null,
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: '내용',
                    ),
                    onChanged: (value){
                      setState(() {
                        _contents = value;
                      });
                    },
                  ),
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.send_outlined),
                  onPressed:  (){
                    if(user.currentUser != null){
                      FirebaseFirestore.instance.collection('chat').add({
                        'text' : _contents,
                        'time' : Timestamp.now(), /// 시간값을 보내서 내림차순으로 적용
                        'uid' : user.currentUser!.uid /// uid를 보내서 사용자 마다 다른 메시지 적용
                      });
                    }
                    _controller.clear();
                  }
              )
            ],
          )
        ],
      ),
    );
  }
 }
