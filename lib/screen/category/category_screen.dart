import 'package:all_events/constants/app_colors.dart';
import 'package:all_events/controller/category/category_controller.dart';
import 'package:all_events/custom_widget/custom_textfield.dart';
import 'package:all_events/custom_widget/custom_widgets.dart';
import 'package:all_events/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/category/category_model.dart';
import '../../model/event/event_model.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({super.key});

  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  TextEditingController searchCtrl = TextEditingController();
  bool loading = false;
  bool showGridView = false;
  String categoryValue = 'Category';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = ref.watch(categoryControllerProvider);
      loading = true;
      setState(() {});
      await provider.getEventsFromCategory();
      loading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(categoryControllerProvider);
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: AppUtils.getHeight(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: loading
                ? [CircularProgressIndicator()]
                : [
                    searchField(),
                    categoryField(),
                    eventView(provider),
                  ],
          ),
        ),
      ),
    );
  }

  categoryField() => Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: () {
            opensheet();
          },
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 8.0.w, top: 4.h, bottom: 14.0.h),
                alignment: Alignment.center,
                width: 100.0.h,
                height: 30.0.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.sp), border: Border.all(color: AppColors.black)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(categoryValue), horizontalBox(), Icon(Icons.keyboard_arrow_down_rounded),
                    // Spacer(),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    showGridView = !showGridView;
                    setState(() {});
                  },
                  child: Icon(Icons.sort)),
              horizontalBox(width: 8.w),
            ],
          ),
        ),
      );

  searchField() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextField(
          hintText: 'Search',
          controller: searchCtrl,
          showBorder: true,
        ),
      );

  eventView(provider) => Expanded(child: showGridView ? gridView(provider) : listView(provider));

  listView(provider) => ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 15.0.h,
          );
        },
        itemCount: provider.eventList.length,
        itemBuilder: (context, index) {
          EventItem data = ref.read(categoryControllerProvider).eventList[index];
          // EventItem data = provider.eventList[index];
          return GestureDetector(
            onTap: () {
              AppUtils.launchUri(data.eventUrl);
            },
            child: Container(
              height: 100.h,
              // color: Colors.red,
              margin: EdgeInsets.only(left: 8.0.w, right: 8.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  networkImage(data.thumbUrl ?? ''),
                  horizontalBox(width: 10.0),
                  Flexible(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      eventName(data.eventname ?? ''),
                      verticalBox(height: 5),
                      subtitleText(data.location ?? ''),
                      Spacer(),
                      // verticalBox(height: 10),
                      horizontalDivider(width: double.maxFinite),
                      Spacer(),
                      Row(
                        children: [
                          subtitleText(data.startTimeDisplay?.split('at')[0].toString() ?? ''),
                          Spacer(),
                          Icon(
                            Icons.star,
                            color: AppColors.grey,
                          ),
                          horizontalBox(),
                          Icon(Icons.ios_share_outlined, color: AppColors.grey)
                        ],
                      )
                    ],
                  )),
                  horizontalBox(width: 10.0),
                ],
              ),
            ),
          );
        },
      );

  gridView(provider) => GridView.builder(
        itemCount: provider.eventList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
        itemBuilder: (BuildContext context, int index) {
          EventItem data = ref.read(categoryControllerProvider).eventList[index];
          return GestureDetector(
            onTap: () {
              AppUtils.launchUri(data.eventUrl);
            },
            child: SizedBox(
              child: Column(
                children: [
                  networkImage(data.thumbUrl ?? ''),
                  verticalBox(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 15.0.w, right: 10.0.w),
                      child: eventName(data.eventname ?? ''),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );

  eventName(String name) => Text(
        name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: normalTextStyle(fontSize: 14.sp),
      );

  networkImage(String url) => ClipRRect(
        borderRadius: BorderRadius.circular(12.sp),
        child: Image.network(
          url,
          width: 150.w,
          height: 100.h,
          fit: BoxFit.cover,
        ),
      );

  subtitleText(String val) => Text(
        val,
        overflow: TextOverflow.ellipsis,
        style: normalTextStyle(fontSize: 12.sp, color: AppColors.grey),
      );

  void opensheet() async {
    showModalBottomSheet(
        context: context,
        enableDrag: true,
        isDismissible: true,
        builder: (context) {
          return SizedBox(
            height: 250.0.h,
            child: Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.w, right: 10.w),
              child: Column(
                children: [
                  horizontalDivider(height: 4.0, width: 50.w),
                  verticalBox(),
                  Row(
                    children: [
                      Text(
                        'Choose your preferred category',
                        style: normalTextStyle(fontSize: 22.sp),
                      ),
                      Spacer(),
                      Icon(Icons.apps_rounded),
                    ],
                  ),
                  Expanded(
                    // height: 100.0,
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          CategoryModel data = ref.watch(categoryControllerProvider).category[index];
                          return GestureDetector(
                            onTap: () {
                              ref.read(categoryControllerProvider).selectedCategory = [data];
                              categoryValue = data.category ?? 'Category';
                              getData();
                              AppUtils.goBack(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 12.0, bottom: 12.0.h),
                              child: Text(
                                data.category ?? '',
                                style: normalTextStyle(),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return horizontalDivider();
                        },
                        itemCount: ref.read(categoryControllerProvider).category.length),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
