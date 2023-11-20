import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:watime/model/main_model.dart';
import 'package:watime/services/main_service.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isSort = ValueNotifier(true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("List"),
        actions: [
          ValueListenableBuilder(
              valueListenable: isSort,
              builder: (
                BuildContext context,
                bool value,
                Widget? child,
              ) {
                if (!value) {
                  return Container();
                } else {
                  return GestureDetector(
                    onTap: () {
                      HapticFeedback.mediumImpact();
                      isSort.value = false;
                    },
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.only(right: 12),
                      color: Colors.transparent,
                      child: Center(
                        child: Text(
                          "delete",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                        ),
                      ),
                    ),
                  );
                }
              })
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: MainService.main,
          builder: (
            BuildContext context,
            MainModel data,
            Widget? child,
          ) {
            return ReorderableListView.builder(
              itemCount: data.locations.length,
              onReorderStart: (_) => HapticFeedback.mediumImpact(),
              onReorderEnd: (_) => HapticFeedback.mediumImpact(),
              onReorder: (int previous, int current) =>
                  MainService.onReorder(previous, current),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      bottom: index == data.locations.length - 1 ? 40 : 0),
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                        width: 0.5,
                        color: Color.fromRGBO(155, 155, 155, 1),
                      )),
                      color: Colors.transparent),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 16, bottom: 16),
                  width: MediaQuery.of(context).size.width,
                  key: ValueKey(index),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data.locations[index].location,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              data.locations[index].timezone.inHours > 0
                                  ? "+${data.locations[index].timezone.inHours.toString().padLeft(2, "0")}:00"
                                  : "-${data.locations[index].timezone.inHours.abs().toString().padLeft(2, "0")}:00",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      ValueListenableBuilder(
                          valueListenable: isSort,
                          builder: (
                            BuildContext context,
                            bool value,
                            Widget? child,
                          ) {
                            return Row(
                              children: [
                                Icon(
                                  Icons.reorder_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                if (!value) ...[
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      HapticFeedback.mediumImpact();
                                      MainService.onRemove(index);
                                    },
                                    child: Icon(
                                      Icons.close_rounded,
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  ),
                                ],
                              ],
                            );
                          }),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
