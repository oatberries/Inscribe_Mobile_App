import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inscribevs/authentication/data_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inscribevs/components/inscribe_post.dart';
import 'package:inscribevs/components/login/elevated_button.dart';
import 'package:inscribevs/model/profileModel.dart';
// import 'package:inscribevs/components/top_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _page = 1;
  int _limit = 10;
  bool _firstLoadingRunning = false;
  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  List posts = [];
  bool circular = true;
  bool loading = true;
  final secureStorage = DataService.getInstance;
  ProfileModel profileModel = ProfileModel();
  late ScrollController _controller;
   

  @override
   void initState() {

    setState(() {
      
    });

    super.initState();
    _getUserInfo();
    _getPostsFirst();
    _controller = ScrollController()..addListener(_loadMorePosts);
   }
    void _getUserInfo() async{
      setState(() {
        _firstLoadingRunning = true;
      });

      String token = await secureStorage.read('token');
      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/get-user-info';

      final response = await http.get(
        Uri.parse(URL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200) {

        final responseData = jsonDecode(response.body);
        setState(() {
          profileModel = ProfileModel.fromJson(responseData["data"]);
          circular = false;
        });
      
        print("Grabbing user info successful: ${responseData}");
      }
      else {
        print("Grabbing user info successful: ${response.body}"); 
      }
      
  }

  void _getPostsFirst() async {
    setState(() {
      _firstLoadingRunning = true;
    });
    String token = await secureStorage.read('token');

    const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/get-posts';
    try {
      final response = await http.get(
      Uri.parse("$URL?page=$_page&limit$_limit"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        },
      );

      final responseData = jsonDecode(response.body);
      final postList = responseData["data"];
      setState(() {
        posts = postList;
        print("List of Posts: ${posts}");
      });

    } catch (error) {
      if (kDebugMode) {
        print("Something went wrong");
      }
    }

    setState(() {
      _firstLoadingRunning = false;
    });
    
  }

    void _loadMorePosts() async {
      String token = await secureStorage.read('token');

      const String URL = 'https://inscribed-22337aee4c1b.herokuapp.com/api/user/get-posts';
      if (_hasNextPage == true &&
        _firstLoadingRunning == false && _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300
        ) {

            setState(() {
              _isLoadMoreRunning = true;
            });

          _page += 1;

          try {
            final response = await http.get(
            Uri.parse("$URL?page=$_page&limit$_limit"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token"
              },
            );

            final responseData = jsonDecode(response.body);
            final postList = responseData["data"] as List;

            if (postList.isNotEmpty) {
              setState(() {
              posts.addAll(postList);
              //print("List of Posts: ${posts}");
              });
            } else {
              setState(() {
                _hasNextPage = false;
              });
            }
           

          } catch (error) {
            if (kDebugMode) {
              print("${error}");
            }
          }
          

            setState(() {
              _isLoadMoreRunning = false;
            });
      }
    }
   
  @override
  Widget build(BuildContext context) {
  
    return circular?SizedBox(height: MediaQuery.of(context).size.height / 1.3, child: Center(child: CircularProgressIndicator())):Scaffold(
       floatingActionButton: FloatingActionButton.small(
          backgroundColor: const Color.fromRGBO(82, 183, 136, 1),
          onPressed: (){
             Navigator.pushNamed(context, '/newpostpage').then((_) => setState(() {}));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),   
      backgroundColor: const Color.fromARGB(255, 216, 243, 220),
      body: SafeArea(
        
        // appBar: TopBar(title: '${profileModel.username}'),
        child:SingleChildScrollView(
          
          controller: _controller,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                color: const Color.fromARGB(255, 216, 243, 220),
                child: Column (
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  // Profile 
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.indigoAccent,
                      ),
                      InkWell(
                       onTap: () {},
                       child: const CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red, 
                          child: Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                     )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      "${profileModel.first_name} ${profileModel.last_name}",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                        
                    Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
                    child: Text(
                      "${profileModel.email}",
                      style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400
                      ),  
                    ),
                  ),
                  // Profile Bio
                  
                    Text(
                            '${profileModel.bio}',
                            style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300
                            )
                          ),
                        
                  Row (
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          //// Followers Button
                        // ToDo Implement Followers List
                          Text(
                            "${profileModel.follower_count}",
                             style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox(height: 2),
                          
                          Text(
                            'Followers',
                            style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300
                            )
                          ),
                        ],
                      ),
                        // Following Button
                        // ToDo Implement Following Users List
                        Column(
                        children: [
                          Text(
                            "${profileModel.following_count}",
                           style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold
                            )
                          ),
                          const SizedBox(height: 2),
                          
                          Text(
                            'Following',
                             style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w300
                            )
                          ),
                        ],
                      ),
                    ],
                    ),
                    // Update Bio Button
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButtonWithoutIcon(
                        labelText: 'Update Bio', 
                        onPressed: () {
                          Navigator.pushNamed(context, '/changebiopage');
                        }),
                    ),
                  
                    const SizedBox(height: 26),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          
                      // Posts Title
                      child: Text(
                        'Posts',
                          style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold
                          )
                        ),
                    ),
                   
                    const SizedBox(height: 12),
                     // List view or Posts
                   _firstLoadingRunning? const Center(
                      child: CircularProgressIndicator()): Column(children: [
                              
                    // Lists of Posts in form of Cards    
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (_, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                          child: InscribePost(updateStartPage: () {setState(() {});}, username: posts[index]['username'], post_content: posts[index]['post_content'], num_of_likes: posts[index]['number_of_likes'], did_i_like_post: posts[index]['did_i_like_post'], postId: posts[index]['_id'],)
                          // child: ListTile(
                          //   tileColor: Color.fromRGBO(183, 228, 199,1),
                          //   title: Text(posts[index]['username']),
                          //   subtitle: Text(posts[index]['post_content']),
                          // ),
                        );
                      },
                     
                    ),
                    // Loading indicator for the posts
                    if (_isLoadMoreRunning == true)
                      const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 40),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    
                    // If there are no more pages to load
                    if (_hasNextPage == false)
                      // if the user has no posts
                      if (posts.isEmpty)
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color:const Color.fromARGB(255, 216, 243, 220),
                        child: Column(children: [
                          Icon(Icons.emoji_emotions_outlined),
                          const Text("You haven't created a post yet")
                        ],),
                      )
                    
                      else
                      // if there are no more posts to be loaded from the api
                      Container(
                        padding: const EdgeInsets.only(top: 30, bottom: 40),
                        color:const Color.fromARGB(255, 216, 243, 220),
                        child: Column(children: [
                          Icon(Icons.emoji_emotions_outlined),
                          const Text("You have reach the end of the your posts")
                        ],),
                      )
                  
                  ],
                  ),
                ],
                ),
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}