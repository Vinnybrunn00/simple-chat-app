import 'package:flutter/material.dart';
import 'package:ghost/constants/app_colors.dart';
import 'package:ghost/core/models/chat/chat_model.dart';
import 'package:ghost/core/models/chat/message.dart';
import 'package:ghost/core/providers/current_platform.dart';
import 'package:ghost/ui/components/bubble_message.dart';
import 'package:ghost/ui/widgets/input_message.dart';
import 'package:ghost/utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserChatModel _userChatModel = UserChatModel();

  final Utils _utils = Utils();

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _scroller() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _onScroll() {
    _scroller();
  }

  @override
  void initState() {
    super.initState();
    _scroller();
  }

  void _sendMessage(BuildContext context, UserChatModel userChatModel) async {
    try {
      _textEditingController.clear();
      final String msg = userChatModel.message;
      final Message message = Message(message: msg);
      message.validate();
      await userChatModel.sendMessage(msg);
      _scroller();

      if (!context.mounted) return;
    } on FirebaseException catch (messageError) {
      _utils.showMessageError(context, message: messageError.toString());
    } catch (messageError) {
      _utils.showMessageError(context, message: messageError.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final Message message = _userChatModel.message;
    final viewInsetsButton = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF232323),
        title: Text('Chat'),
        titleTextStyle: TextStyle(color: AppColors.whiteColor, fontSize: 18),
      ),
      backgroundColor: Color.from(
        alpha: 1,
        red: 0.063,
        green: 0.063,
        blue: 0.063,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _userChatModel.streamMessages(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text('Error');

                  if (!snapshot.hasData) {
                    return Column(
                      children: [LinearProgressIndicator(color: Colors.green)],
                    );
                  }

                  final docs = snapshot.data!.docs;

                  _scroller();

                  return ListView.builder(
                    controller: _scrollController,
                    keyboardDismissBehavior: .onDrag,
                    shrinkWrap: true,
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final Map<String, dynamic> data = docs[index].data();

                      final bool isNotMe = _userChatModel.uid != data['uid'];

                      return Row(
                        mainAxisAlignment: isNotMe ? .start : .end,
                        children: [
                          BubbleMessage(
                            username: data['username'],
                            message: data['message'],
                            time: _userChatModel.dateFormatBubble(data['time']),
                            isNotMe: isNotMe,
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: isMobile.value
                    ? viewInsetsButton - viewInsetsButton
                    : 0.0,
              ),
              child: InputMessage(
                controller: _textEditingController,
                onChanged: (msg) => _userChatModel.message = msg,
                sendMessage: () async => _sendMessage(context, _userChatModel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
