import 'package:cached_network_image/cached_network_image.dart';
import 'package:dietbetes/models/user.dart';
import 'package:dietbetes/util/data.dart';
import 'package:dietbetes/util/validator.dart';
import 'package:dietbetes/view/profile/profile_controller.dart';
import 'package:dietbetes/wigdet/loading.dart';
// import 'package:card_settings/card_settings.dart';
import 'package:flutter/material.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with ValidationMixin {
  ProfileCtrl profileCtrl;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formAccountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formUserKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formGlucoseKey = GlobalKey<FormState>();

  final pwdFocus = FocusNode();

  @override
  void initState() {
    profileCtrl = new ProfileCtrl();
    super.initState();
  }

  @override
  void dispose() {
    profileCtrl?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
              color: Colors.green.shade600
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProfileAvatar(
                  initialsText: Text("R", style: TextStyle(fontSize: 40, color: Colors.white)),
                  imageUrl: "http://i.pravatar.cc/300",
                  elevation: 5.0,
                  borderWidth: .5,
                  borderColor: Colors.grey,
                  onTap: () {
                    print('Event Upload Image');
                  },
                ),
                SizedBox(height: 15.0),
                StreamBuilder(
                  initialData: "User",
                  stream: profileCtrl.getFullName,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return Text(snapshot.data, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24));
                  }
                )
              ],
            ),
          ),
          Form(
            key: _formAccountKey,
            child: ExpansionTile(
              title: Text("Account Setting"),
              trailing: StreamBuilder(
                stream: profileCtrl.getIcon1,
                builder: (context, AsyncSnapshot<IconData> snapshot) => Icon(snapshot.data)
              ),
              onExpansionChanged: (v) => profileCtrl.updateIcon1(v ? Icons.expand_less:Icons.expand_more),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("Note : Jika anda merubah password, maka akan diarahkan ke halaman login kembali", style: TextStyle(color: Colors.red, fontSize: 12)),
                ),
                Divider(),
                StreamBuilder(
                  stream: profileCtrl.getUserData,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    return TextFormField(
                      controller: profileCtrl.initialValue(snapshot.hasData ? snapshot.data.email:""),
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                      ),
                    );
                  }
                ),
                TextFormField(
                  validator: validatePassword,
                  onSaved: null,
                  onFieldSubmitted: (v) => FocusScope.of(context).requestFocus(pwdFocus),
                  textInputAction: TextInputAction.next,
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Masukan Kata Sandi',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                  ),
                ),
                TextFormField(
                  validator: validatePassword,
                  onSaved: null,
                  textInputAction: TextInputAction.done,
                  focusNode: pwdFocus,
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Ulangi Kata Sandi',
                    contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: RaisedButton(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: Center(child: Text("Simpan", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)))
                    ),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          Form(
            key: _formUserKey,
            child: ExpansionTile(
              title: Text("Profile Setting"),
              trailing: StreamBuilder(
                stream: profileCtrl.getIcon2,
                builder: (context, AsyncSnapshot<IconData> snapshot) => Icon(snapshot.data)
              ),
              onExpansionChanged: (v) => profileCtrl.updateIcon2(v ? Icons.expand_less:Icons.expand_more),
              children: <Widget>[
                Divider(),
                StreamBuilder(
                  stream: profileCtrl.getUserData,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    return TextFormField(
                      controller: profileCtrl.initialValue(snapshot.hasData ? snapshot.data.userDetail.fullName:""),
                      validator: validateRequired,
                      onSaved: null,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Nama Lengkap',
                        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                      ),
                    );
                  }
                ),
                StreamBuilder(
                  stream: profileCtrl.getUserData,
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    return TextFormField(
                      controller: profileCtrl.initialValue(snapshot.hasData ? snapshot.data.userDetail.callName:""),
                      validator: validateRequired,
                      onSaved: null,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Nama Panggilan',
                        contentPadding: EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0)
                      ),
                    );
                  }
                ),
                StreamBuilder(
                  stream: profileCtrl.getUserData,
                  builder: (ctx, AsyncSnapshot<User> snapshoot) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.7)
                        )
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: RadioListTile(
                              value: 1,
                              title: Text('Laki-laki', style: TextStyle(fontSize: 14.0)),
                              groupValue: snapshoot.hasData ? snapshoot.data.userDetail.gender:null,
                              onChanged: (v) {

                              },
                            )
                          ),
                          Expanded(
                            child: RadioListTile(
                              value: 0,
                              title: Text('Perempuan', style: TextStyle(fontSize: 14.0)),
                              groupValue: snapshoot.hasData ? snapshoot.data.userDetail.gender:null,
                              onChanged: (v) {

                              },
                            )
                          ),
                        ],
                      ),
                    );
                  }
                ),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: RaisedButton(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: Center(child: Text("Simpan", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)))
                    ),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
          
          Form(
            key: _formGlucoseKey,
            child: ExpansionTile(
              title: Text("Glucose Setting"),
              trailing: StreamBuilder(
                stream: profileCtrl.getIcon3,
                builder: (context, AsyncSnapshot<IconData> snapshot) => Icon(snapshot.data)
              ),
              onExpansionChanged: (v) => profileCtrl.updateIcon3(v ? Icons.expand_less:Icons.expand_more),
              children: <Widget>[
                Divider(),
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: RaisedButton(
                    child: SizedBox(
                      width: double.infinity,
                      height: 45.0,
                      child: Center(child: Text("Simpan", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)))
                    ),
                    color: Colors.green,
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}