import 'package:flutter/material.dart';
import 'package:inscribevs/components/inscribe_post.dart';
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       floatingActionButton: FloatingActionButton.small(
          backgroundColor: const Color.fromRGBO(82, 183, 136, 1),
          onPressed: (){
             Navigator.pushNamed(context, '/newpostpage').then((_) => setState(() {}));
          },
          child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),   
     body: SafeArea(
       child: Center(
         
         // child: InscribePost(username: 'lab-test', num_of_likes: 1000, post_content: "1mtUYzmFvGLrdPMfwbSu7sxnAHy9AzB389XGzjO9Qjmpe1Utm3H6JWAHnKQsXxBquEy1guIp9MBM2Tg0AzX550mEp1k6USbSggz4f141NdmkdmMHOcHdg2TCBmJ3lXmPBxEiwxdh9RSph9ul3GbuPELUIItcMA0lJaJrrHUyHLdaZSwegJH40RDnHGa7pMvNiNE5DdzuVYILFbjzV0BvctEX1b1XDCYMQrz2N73F5QMAECeosiSRE8MWdEdTwYY",did_i_like_post: false),
          
       ),
     ),
    );
  }
}