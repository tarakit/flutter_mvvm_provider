import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/data/response/api_response.dart';
import 'package:flutter_mvvm_provider/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var productViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    productViewModel.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (BuildContext ctx) => productViewModel,
          child: Consumer<HomeViewModel>(
              builder: (context, products, _) {
                var status = products.apiResponse.status;
                print('status $status');

                switch(status){
                  case Status.LOADING: return Center(child: const CircularProgressIndicator());
                  case Status.COMPLETED:
                    return Center(child: Text('Hello Flutter'));
                  default: return Center(child: Text('Default'));
                }
              },

          ),
        )
    );
  }
}