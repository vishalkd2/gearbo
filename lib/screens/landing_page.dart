import 'package:flutter/material.dart';
import 'package:gearbo/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'Home_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _handleLogin(UserProvider provider)async{
    if(_formKey.currentState!.validate()){
      final bool success = await provider.login(_emailController.text.trim(), _passwordController.text.trim());
      if(!mounted) return;
      if(success){
        print("Redirecting to homepage");
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(provider.errorMessage??'Login Failed'),backgroundColor: Colors.red));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final provider =  Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Landing Screen'),centerTitle: true,),
      body: Center(
        child: Form(key: _formKey,
          child: Padding(padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
              TextFormField(controller: _emailController,keyboardType: TextInputType.emailAddress,
                validator: (value){
                if(value==null || value.isEmpty){
                  return  "Please enter correct email.";
                }if (!value.contains('@')) {
                  return 'Please enter a valid email.';
                }
                return null;
                },
                decoration: InputDecoration(hintText: "Enter email here",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.00))),),
              const SizedBox(height: 16),
              TextFormField(controller: _passwordController,obscureText: true,
                validator: (value){
                if(value==null || value.isEmpty){
                  return  "Please enter correct password.";
                }
                return null;
                },
                decoration: InputDecoration(hintText: "Enter password here",border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.00))),),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,height: 50,
                child: ElevatedButton(
                    onPressed: provider.isLoading
                        ?null
                        :() => _handleLogin(provider),
                  child: provider.isLoading
                    ?CircularProgressIndicator(color: Colors.white)
                      :const Text('Login',style: TextStyle(fontSize: 16))
                ),
              ),
              SizedBox(height: 30,),
              TextButton(onPressed: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Not implemented yet")));
              },
                  child: Text("Create New Account",style: TextStyle(decoration: TextDecoration.underline),))

            ],),
          ),
        ),
      ),
    );
  }
}
