import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:test_app/helper/helper_widget.dart';
import 'package:test_app/model/items/items_users_model.dart';
import 'package:test_app/notifier/list_controller_notifier.dart';

class ListUserPage extends StatefulWidget {

  static const String route_name = "/list_user_page";

  ListUserPage({
    Key? key
  }) : super(key: key);

  @override
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {

  PagingController<int, UsersModel>? _pagingController = PagingController(firstPageKey: 1);
  late ListControllerNotifier _listControllerNotifier;

  @override
  void initState() {
    // TODO: implement initState
    _listControllerNotifier = Provider.of(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _listControllerNotifier.setControllerUsers(_pagingController);
    });
    _pagingController?.addPageRequestListener((pageKey) {
      _listControllerNotifier.fetchDataUsers(context, pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pagingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.buildAppBar(context, "Users"),
      body: _buildBodyContent(),
    );
  }

  Widget _buildBodyContent() {
    final _mediaHeight = MediaQuery.of(context).size.height;
    final _mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      height: _mediaHeight,
      width: _mediaWidth,
      child: RefreshIndicator(
        onRefresh: _listControllerNotifier.refreshDataUsers,
        child: PagedListView<int?, UsersModel>(
          pagingController: _pagingController!,
          builderDelegate: PagedChildBuilderDelegate<UsersModel>(
              animateTransitions: true,
              transitionDuration: const Duration(milliseconds: 500),
              itemBuilder: (context, item, index)  => Container(
                child: _buildListItem(item.fullName, item.email, item.id),
              )
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String? firstName, String? email, int? id) {
    final _mediaHeight = MediaQuery.of(context).size.height;
    final _mediaWidth = MediaQuery.of(context).size.width;

    return Container(
      child: Row(
        children: [
          Container(
            width: _mediaWidth/1.15,
            child: ListTile(
              title: Text("$firstName",
                style: GoogleFonts.poppins(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: _mediaHeight/45),
              ),
              subtitle: Text("$email",
                style: GoogleFonts.poppins(
                    color: Colors.teal,
                    fontSize: _mediaHeight/60
                ),
              ),
            ),
          ),
          Flexible(
            child: Container(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
                size: _mediaWidth/20,
              ),
            ),
          )
        ],
      ),
    );
  }


}
