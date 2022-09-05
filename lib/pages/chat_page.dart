import 'dart:io';

import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

import '../widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool isWritting = false;
  /*final List<ChatMessage> _messages = [
    ChatMessage(text: "Hello World", uid: "123"),
    ChatMessage(text: "Hello World", uid: "123"),
    ChatMessage(text: "Hello World", uid: "123"),
    ChatMessage(text: "Hello World", uid: "123"),
    ChatMessage(text: "Hello World", uid: "22222"),
    ChatMessage(text: "Hello World", uid: "55555"),
  ];*/
  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              maxRadius: 15,
              backgroundColor: Colors.blue[100],
              child: Text(
                "Te",
                style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text("Testing 1")
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                // renderiza los mensajes
                itemBuilder: (_, index) => _messages[index],
                itemCount: _messages.length,
                reverse: true,
              ),
            ),
            const Divider(
              height: 1,
            ),
            //TODO: caja de texto
            Container(
              color: Colors.white,
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (text) {
                  //TODO: saber cuando hay un valor para poder postear
                  setState(() {
                    if (text.trim().length > 0) {
                      isWritting = true;
                    } else {
                      isWritting = false;
                    }
                  });
                },
                decoration:
                    const InputDecoration.collapsed(hintText: "Enviar Mensaje"),
                focusNode: _focusNode,
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Platform.isIOS
                    ? CupertinoButton(
                        onPressed: isWritting
                            ? () => _handleSubmit(_textController.text.trim())
                            : null,
                        child: const Text("Enviar"),
                      )
                    : Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconTheme(
                          data: IconThemeData(color: Colors.blue[400]),
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(
                              Icons.send,
                            ),
                            onPressed: isWritting
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                          ),
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  _handleSubmit(String text) {
    if (text.trim().length == 0) return;
    print(text);
    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
      text: text,
      uid: "123",
      animationController: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 300)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      isWritting = false;
    });
  }

  @override
  void dispose() {
    // TODO: off Socket

    // limpiar los animations controllers que son creados cada vez se envia
    //un mensaje
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
