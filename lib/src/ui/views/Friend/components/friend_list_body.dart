import 'package:flutter/material.dart';
import 'package:zamongcampus/src/business_logic/view_models/friend_list_viewmodel.dart';
import 'package:zamongcampus/src/ui/common_widgets/isLoading.dart';
import 'package:zamongcampus/src/ui/views/Friend/components/friend_list_tile.dart';
import 'package:zamongcampus/src/ui/views/Friend/components/search_bar.dart';

class FriendListBody extends StatelessWidget {
  final FriendListViewModel vm;
  final List<FriendPresentation> friends;
  const FriendListBody({Key? key, required this.vm, required this.friends})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SearchBar(vm: vm),
        vm.busy
            ? const IsLoading()
            : Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: friends.length,
                    itemBuilder: (BuildContext context, int index) =>
                        FriendListTile(vm: vm, friend: friends[index])))
      ],
    );
  }
}
