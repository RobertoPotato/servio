import 'package:flutter/material.dart';
import 'package:servio/constants.dart';
import 'package:servio/components/divider_component.dart';
import 'package:servio/components/image_container.dart';
import 'package:servio/screens/image_screen.dart';
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

  String getInitials(String fullNames) {
    var name = fullNames.trim();
    var nameArr = name.split(" ");
    if (nameArr.length > 1) {
      //First letter of the first string in array
      var firstInitial = nameArr[0].toString()[0];
      //First letter of the second string in array
      var secondInitial = nameArr[1].toString()[0];

      return "$firstInitial.$secondInitial";
    }
    //If only one name is given, take its first character in capital and use it instead
    return nameArr[0].toString().toUpperCase()[0];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: kMainHorizontalPadding + 4, top: kMainHorizontalPadding + 4, right: kMainHorizontalPadding + 4),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundColor: kPrimaryColor,
                    child: Center(
                      child: Text(
                        getInitials(userName).toUpperCase(),
                        style: kTestTextStyleWhite,
                      ),
                    ),
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
                          DividerComponent(
                            height: 30,
                            color: Colors.black54,
                            width: 1.0,
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
                          DividerComponent(
                            height: 30,
                            color: Colors.black54,
                            width: 1.0,
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
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ImageScreen(
                        imageUrl: picture,
                        isNetworkImage: true),
                  ),
                );
              },
              child: ImageContainer(
                height: 300,
                borderRadius: 5.0,
                imageUrl: picture,
                elevation: 0.0,
                isNetworkImage: true,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              child: Text("User's Bio: $bio", style: kMainBlackTextStyle.copyWith(fontSize: 18),),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
