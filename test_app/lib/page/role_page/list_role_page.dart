import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:test_app/helper/helper.dart';
import 'package:test_app/helper/helper_widget.dart';
import 'package:test_app/model/items/items_role_model.dart';
import 'package:test_app/notifier/list_controller_notifier.dart';
import 'package:test_app/page/role_page/create_role_page.dart';

class ListRolePage extends StatefulWidget {

  static const String route_name = "/list_role_page";

  ListRolePage({
    Key? key
  }) : super(key: key);

  @override
  _ListRolePageState createState() => _ListRolePageState();
}

class _ListRolePageState extends State<ListRolePage> {

  PagingController<int, RoleModel>? _pagingController = PagingController(firstPageKey: 1);
  late ListControllerNotifier _listControllerNotifier;

  @override
  void initState() {
    // TODO: implement initState
    _listControllerNotifier = Provider.of(context, listen: false);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _listControllerNotifier.setControllerRole(_pagingController);
    });
    _pagingController?.addPageRequestListener((pageKey) {
      _listControllerNotifier.fetchDataRoles(context, pageKey);
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
      appBar: WidgetHelper.buildAppBar(context, "Roles"),
      body: _buildBodyContent(),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  Widget _buildBodyContent() {
    final _mediaHeight = MediaQuery.of(context).size.height;
    final _mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      height: _mediaHeight,
      width: _mediaWidth,
      child: RefreshIndicator(
        onRefresh: _listControllerNotifier.refreshDataRoles,
        child: PagedListView<int?, RoleModel>(
          pagingController: _pagingController!,
          builderDelegate: PagedChildBuilderDelegate<RoleModel>(
              animateTransitions: true,
              transitionDuration: const Duration(milliseconds: 500),
              itemBuilder: (context, item, index)  {
                String? desc;
                if(item.description != null) {
                  desc = Helper.parseHtmlString(item.description);
                } else {
                  desc = "-";
                }

                return Container(
                  child: _buildListItem(item.title, desc, item.id),
                );
              }
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
                Icons.flag_outlined,
                color: Colors.grey,
                size: _mediaWidth/20,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildFloatingButton() {
    final _mediaHeight = MediaQuery.of(context).size.height;

    return FloatingActionButton(
      backgroundColor: Colors.blueAccent,
      onPressed: () {
        Navigator.of(context).pushNamed(CreateRolePage.route_name).then((value) async => await _listControllerNotifier.refreshDataRoles());
      },
      child: Icon(
        Icons.add,
        color: Colors.white,
        size: _mediaHeight/35,
      ),
    );
  }

}
