
import 'package:flutter/material.dart';
import 'package:learn_flutter/data/services/login/login_services.dart';
import 'package:learn_flutter/ui/manager/bottom_tab/bottomTab/bottomTab.dart';
import 'package:fluttertoast/fluttertoast.dart';

 loginSuccess() async => await Fluttertoast.showToast(
    msg: "Đăng nhập thành công",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.green,
    textColor: Colors.white,
    fontSize: 16.0
);

class Login extends StatefulWidget {
  const Login({super.key, required this.title});

  final String title;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _loginServices = LoginServices();
  final _nameController = TextEditingController(text: 'tungnt');
  final _passwordController = TextEditingController(text: '12345678aA@');
  final Color selectionColor = Colors.blue[400]!;
  final Color selectionHoverColor = Colors.blue[800]!;
  final String fontFamily = 'Dosis';
  final _loginForm = GlobalKey<FormState>();

  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      isLoading = true;
    });
    final String username = _nameController.text;
    final String password = _passwordController.text;
    try{
      bool response = await _loginServices.login(username, password);
      if(response){
        await loginSuccess();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavigationBarExampleApp()),
        );
      }else{
        print("Gặp lỗi ở Login");
      }
    }catch(e){
      print('Error during login: $e');
    }finally{
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _loginForm,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: fontFamily,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: selectionHoverColor, width: 1.5),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: selectionColor, width: 1.5),
                            ),
                            hintText: 'Tên đăng nhập',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tên đăng nhập không được để trống';
                            }
                            return null;
                          },
                          readOnly: isLoading),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            border: const OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: selectionHoverColor, width: 1.5),
                            ),
                            hintText: 'Mật khẩu',
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: selectionColor, width: 1.5),
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mật khẩu không được để trống';
                            }
                            return null;
                          },
                          readOnly: isLoading),
                    ),
                    Padding(
                        padding:
                            const EdgeInsets.only(left: 30, right: 30, top: 16),
                        child: SizedBox(
                          width: 400,
                          height: 50,
                          child: TextButton(
                            onPressed: isLoading ? null : () {
                              if (_loginForm.currentState!.validate()) {
                                _submit();
                              }
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: selectionHoverColor,
                              padding:
                                  const EdgeInsets.only(left: 120, right: 120),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24.0,
                                    height: 24.0,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Đăng nhập',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontFamily,
                                    ),
                                  ),
                          ),
                        )),
                  ],
                )),
          ),
        ) /* add child content here */,
      ),
    ));
  }
}
