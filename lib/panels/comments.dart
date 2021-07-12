import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:majorproject_covid19_tracker/constants.dart';

class CommentPage extends StatefulWidget {
  static const String id = 'comment_screen';
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late String commenttext;
  bool logged = false;

  @override
  void initState() {
    super.initState();
    this.getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          this.loggedInUser = user;
          this.logged = true;
        });

        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return !logged
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              title: Text('Comments'),
              backgroundColor: Colors.lightBlue,
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    decoration: kMessageContainerDecoration,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              commenttext =
                                  value; //Do something with the user input.
                            },
                            decoration: kMessageTextFieldDecoration,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //messagetext+loggedinuser.email
                            _firestore.collection('comments').add({
                              'text': commenttext,
                              'sender': loggedInUser.email
                            });
                          },
                          child: Text(
                            'Save',
                            style: kSendButtonTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('comments')
                          .snapshots(includeMetadataChanges: true),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final comments = snapshot.requireData.docs.reversed;
                          List<CommentBubble> commentWidgets = [];
                          for (var comment in comments) {
                            final commentText = comment.get('text');
                            final commentSender = comment.get('sender');
                            final commentWidget = CommentBubble(
                                commenttext: commentText,
                                commentsender: commentSender);

                            commentWidgets.add(commentWidget);
                          }
                          return Expanded(
                            child: ListView(
                              reverse: false,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 20.0),
                              children: commentWidgets,
                            ),
                          );
                        } else {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('images/ko.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // logo here

                                Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      }
                      ),
                ],
              ),
            ),
          );
  }
}

class CommentBubble extends StatelessWidget {
  CommentBubble({required this.commenttext, required this.commentsender});

  final String commenttext;
  final String commentsender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Material(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                commenttext + '\n          -' + commentsender,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
