import 'package:flutter/material.dart';
import '../lists/menu_list.dart';
import '../lists/announcement_list.dart';
import '../lists/member_list.dart';
import '../design/letters_design.dart';
import '../design/colors.dart';
import '../design/one_announcement_page.dart';

class MainPageDesign extends StatelessWidget {
  final List<AnnouncementInformation> _announcementInformations;
  final List<MenuList> _menuList;
  final MemberList _memberList;

  MainPageDesign(
      this._announcementInformations, this._menuList, this._memberList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: announcementGrey,
      appBar: _appBarFunction(context),
      body: Padding(
        padding: const EdgeInsets.all(3), //mete o espaço em cima
        child: ListView.builder(
          itemCount: this._announcementInformations.length,
          itemBuilder: _designPage,
        ),
      ),
      drawer: _drawerFunction(context),
    );
  }

  Widget _appBarFunction(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundGreen,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Devia pôr como Image.network mas o site não autoriza
          //Alinhar ao centro!
          Align(
            child: Image.asset(
              'assets/hs_logo.png',
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
              color: textGrey,
              height: 50,
            ),
          ),
        ],
      ),
    );
  }

  Widget _designPage(BuildContext context, int index) {
    var announcementInformations = this._announcementInformations[index];
    return Card(
        child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://www.google.com/maps/uv?pb=!1s0xd1933a3bf58649d%3A0xd7f3d7a384498675!3m1!7e115!4shttps%3A%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipMZnTcodgPmAnEkVfiH9fI5BVK8NcbYDDPxhRTB%3Dw160-h160-k-no!5shacker%20school%20-%20Pesquisa%20Google!15sCgIgAQ&imagekey=!1e10!2sAF1QipMZnTcodgPmAnEkVfiH9fI5BVK8NcbYDDPxhRTB&hl=pt-PT&sa=X&ved=2ahUKEwimjMm6xKTvAhWGYcAKHWQtDKkQoiowEnoECBoQAw&cshid=1615338400130077#'),
            ),
            tileColor: backgroundGrey,
            contentPadding: EdgeInsets.all(10),
            title: _oneAnnouncementTitle(announcementInformations),
            subtitle: _oneAnnouncementDate(announcementInformations),
            trailing: _oneAnnouncementPublicationDate(announcementInformations),
            onTap: () {
              _openAnnouncementPage(context, announcementInformations);
            }));
  }

  Widget _drawerFunction(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: this._menuList.length,
        itemBuilder: _designMenu,
      ),
    );
  }

  Widget _designMenu(BuildContext context, int index) {
    var menuInformations = this._menuList[index];

    if (index == 0) {
      return DrawerHeader(
        decoration: BoxDecoration(
          color: backgroundGrey,
        ),
        margin: const EdgeInsets.only(bottom: 0), //espaço entre header e o menu
        /* child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: CircleAvatar(
            backgroundImage: AssetImage('assets/${_memberList.photo}'),
            radius: 50.0,
          ),
          title: Text(
            _memberList.name,
          ),
          subtitle: Text('ist1${_memberList.id}'),
        ), */
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              //alignment: Alignment(-1, 0.2),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/${_memberList.photo}'),
                radius: 40.0,
              ),
            ),
            Align(
              //alignment: Alignment(0, 0),
              alignment: Alignment.centerLeft + Alignment(1.4, -0.2),
              child: Text(
                _memberList.name,
                style: TextStyle(color: textGrey, fontSize: 20.0),
              ),
            ),
            Align(
              //alignment: Alignment(-0.35, 0.4),
              alignment: Alignment.centerLeft + Alignment(0.9, 0.2),
              child: Text(
                'ist1${_memberList.id}',
                style: TextStyle(color: textGrey, fontSize: 10.0),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListTile(
        tileColor: backgroundGrey,
        leading: Icon(
          menuInformations.icon,
          color: textGrey,
        ),
        title: Text(
          menuInformations.title,
          style: Styles.textDesign,
        ),
        onTap: () {
          //_announcementPage(context,index);
        },
      );
    }
  }

  Widget _oneAnnouncementTitle(
      AnnouncementInformation announcementInformation) {
    return Text(
      announcementInformation.title,
      style: Styles.titleDesign,
    );
  }

  Widget _oneAnnouncementDate(AnnouncementInformation announcementInformation) {
    return Text(
      announcementInformation.event_date,
      style: Styles.textDesign,
    );
  }

  Widget _oneAnnouncementPublicationDate(
      AnnouncementInformation announcementInformation) {
    return Text(
      'Published: \n ${announcementInformation.publication_date}',
      style: Styles.publicationDateDesign,
    );
  }

  void _openEmptyPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: backgroundGrey,
          appBar: AppBar(
            backgroundColor: backgroundGreen,
          ),
        );
      },
    ));
  }

  void _openAnnouncementPage(
      BuildContext context, AnnouncementInformation announcementInformations) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                OneAnnouncementPage(announcementInformations)));
  }
}
