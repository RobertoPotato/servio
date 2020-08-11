import 'package:flutter/material.dart';
import 'package:servio/components/icon_button_text.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/my_vertical_divider.dart';

class UserProfile extends StatelessWidget {
  final String userName;
  final String bio;
  final String picture;
  final String avatar;
  final String phoneNumber;
  final bool isVerified;
  final String updatedAt;
  final String tierTitle;
  final String tierDescription;
  final String tierBadgeUrl;
  final String roleTitle;
  final String roleDescription;

  const UserProfile(
      {@required this.userName,
      @required this.bio,
      @required this.picture,
      @required this.avatar,
      @required this.phoneNumber,
      @required this.isVerified,
      @required this.updatedAt,
      @required this.tierTitle,
      @required this.tierDescription,
      @required this.tierBadgeUrl,
      @required this.roleTitle,
      @required this.roleDescription});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(kMainHorizontalPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(avatar),
                    radius: 40.0,
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        userName,
                        style: kHeadingTextStyle,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.supervisor_account,
                                size: 28.0,
                                color: Colors.greenAccent,
                              ),
                              Text(roleTitle),
                            ],
                          ),
                          MyVerticalDivider(
                            height: 30, color: Colors.black54, width: 1.0,
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.star,
                                size: 28.0,
                                color: Colors.orangeAccent,
                              ),
                              Text(tierTitle),
                            ],
                          ),
                          MyVerticalDivider(
                            height: 30, color: Colors.black54, width: 1.0,
                          ),
                          Column(
                            children: <Widget>[
                              Icon(
                                Icons.verified_user,
                                color: isVerified ? Colors.blue : Colors.grey,
                                size: 28.0,
                              ),
                              Text(isVerified ? 'Verified' : 'Not Verified'),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Image.network(picture),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(bio),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButtonWithText(
                  text: "Call",
                  icon: Icons.call,
                  materialColor: kMyBidsColor,
                  onTap: () {
                    print("Call User");
                  },
                ),
                IconButtonWithText(
                  text: "Chat",
                  icon: Icons.chat,
                  materialColor: kAccentColor,
                  onTap: () {
                    print("Message User");
                  },
                ),
                IconButtonWithText(
                  text: "Done",
                  icon: Icons.close,
                  materialColor: kRedAlert,
                  onTap: () {
                    Navigator.pop(context);
                    print("Close");
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
