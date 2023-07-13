import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:restaurant/screens/homepage/widgets/restaurant_card.dart';
import 'package:restaurant/service/restaurants.dart';
import 'package:restaurant/utils/sharedpref.dart';
import 'package:restaurant/utils/willpop.dart';
import 'package:restaurant/widgets/snackbar.dart';

RestaurantsModel? _restaurantsModel;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    try {
      _restaurantsModel = await getRestaurants();

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      getSnackbar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => WillPopService().exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Restaurants'),
              GestureDetector(
                onTap: () => Service().logout(context),
                child: Row(
                  children: [
                    const Icon(Remix.logout_box_r_line),
                    SizedBox(width: 4.w),
                    Text(
                      'Logout',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: _restaurantsModel == null
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4.h,
                  horizontal: 4.w,
                ),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return RestaurantCard(
                        restaurantData: _restaurantsModel!.restaurant![index]);
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 14.h),
                  itemCount: _restaurantsModel!.restaurant!.length,
                ),
              ),
      ),
    );
  }
}
