
import 'package:app_ru/models/users.dart';
import 'package:app_ru/ui/pages/pageFriends/friends.dart';
import 'package:app_ru/ui/widgets/refreshWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:app_ru/ui/pages/pageFriends/userslist.dart';
import '../../../domain/constants/controllers/firebaseuser_controller.dart';
import '../../widgets/serchWidget.dart';
import '../../widgets/usercard.dart';
import 'package:get/get.dart';
class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList>{
List<Users> entries = <Users>[];
String query = '';
List<Users> users = [];
FirebaseUserController fuserCont = Get.find();
  void initState(){
    FirebaseUserController fuserCont = Get.find();
    fuserCont.onInit();
    fuserCont.subscribeUpdates();
    loadData();
    super.initState();
  }
  Future loadData() async {
    users = await fuserCont.allUsers;

    setState(() {
      entries = users;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset("assets/logo_appbar.png", height: 60, width: 50),
        ),
      ),
        body: Container(
          child: 
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <Widget>[
            buildSearch(),
          Expanded(
            child: RefreshWidget(
              onRefresh: loadData,
              child:ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return Usercard(
                    user: entries[index],
                    onEventClick: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Column(
                          children: [
                            const SizedBox(height: 20),
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(entries[index].url),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              entries[index].name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(onPressed: () =>{
                              fuserCont.addFriend(entries[index].email),
                            Navigator.pop(context)
                            }
                            ,
                             child: const Text('Add'))
                          ],
                        )
                      );
                    },
                );
              }) ,
            ) 
          )  
        ]),
  ));
  }

  Widget buildSearch() => SearchWidget(
    text: query,
    hintText: 'Name',
    onChanged: searchUser,
  );

  void searchUser(String query) {
    final usersL = users.where((user) {
      final nameLower = user.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.entries = usersL;
    });
  }
  

  
}

