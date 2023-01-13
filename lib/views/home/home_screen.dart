import 'package:flutter/material.dart';
import 'package:flutter_mvvm_provider/view_models/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../add_product/add_screen.dart';
import 'widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var productViewModel = HomeViewModel();
  var _scrollController = ScrollController();
  var page = 1;
  var data = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    productViewModel.getProducts(1, 14);
    _scrollController.addListener(onScrollToTheMaxBottom);
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
                  case Status.LOADING: return const Center(child: CircularProgressIndicator());
                  case Status.COMPLETED:

                    data.addAll(products.apiResponse.data!.data!); // 14 + 14 = 28
                    var length = data.length; // 28
                    // Pull To Refresh
                    return RefreshIndicator(
                      onRefresh: () async {
                        page = 1;
                        data.clear();
                        productViewModel.getProducts(page, 14);
                      },
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: isLoading ? length + 1 : length,
                          itemBuilder: (context, index){
                            if(index == length){
                              return Center(child: CircularProgressIndicator());
                            }else{
                              var product = data![index].attributes; // 28
                              return ProductCard(product: product);
                            }
                          }),
                    );
                  default: return Center(child: Text('Default'));
                }
              },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => const AddProductScreen()));
          },
          child: Icon(Icons.add),
        ),
    );
  }

  void onScrollToTheMaxBottom() async{

    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      if(page != 3){
        setState(() {
          isLoading = true;
        });
        page += 1;
        await productViewModel.getProducts(page, 14);

        setState(() {
          isLoading = false;
        });
      }
      }
    }

}

