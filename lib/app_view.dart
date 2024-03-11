import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_repository/income_repository.dart';
import 'package:semuny/screens/auth/views/welcome_screen.dart';
import 'package:semuny/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:semuny/screens/home/bloc/get_incomes_bloc/get_incomes_bloc.dart'; // Import the GetIncomesBloc
import 'package:semuny/screens/home/views/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "expence track",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              primary: const Color(0xFF00B2E7),
              secondary: const Color(0xFFE064F7),
              tertiary: const Color(0XFFFF8D6C),
              outline: Colors.grey.shade400)),
      home: FutureBuilder<bool>(
        future: _isUserLoggedIn(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.data == true) {
            return FutureBuilder<String>(
              future: _getUserId(context),
              builder: (context, userIdSnapshot) {
                if (userIdSnapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (userIdSnapshot.hasData) {
                  print(
                      '-------------------User passed ID: ${userIdSnapshot.data}-----------------------------');
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) => GetExpensesBloc(
                          FirebaseExpenseRepo(),
                          userIdSnapshot.data!, // Pass the user ID to the bloc
                        )..add(GetExpenses()),
                      ),
                      BlocProvider(
                        create: (context) => GetIncomesBloc(
                          FirebaseIncomeRepo(),
                          userIdSnapshot
                              .data!, // Assuming you have a similar repository for incomes
                        )..add(
                            GetIncomes()), // Assuming you have a similar event for fetching incomes
                      ),
                    ],
                    child: const HomeScreen(),
                  );
                } else {
                  // Handle the case where the user ID is not found
                  return const WelcomeScreen();
                }
              },
            );
          } else {
            // Assuming you have a WelcomeScreen for new users
            return const WelcomeScreen();
          }
        },
      ),
    );
  }

  Future<bool> _isUserLoggedIn(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    print(
        '-------------------Is Logged In pref: ${prefs.getBool('isLoggedIn')}-----------------------');
    print(
        '-------------------Is Logged In: $isLoggedIn-----------------------');
    return isLoggedIn;
  }

  Future<String> _getUserId(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId') ?? '';
    print('-------------------User ID: $userId-----------------------------');
    return userId;
  }
}
