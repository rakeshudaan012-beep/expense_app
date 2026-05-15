import 'package:expenso_app/app_routes.dart';
import 'package:expenso_app/core/constant/app_constants.dart';
import 'package:expenso_app/features/presentation/bloc/expanse_bloc.dart';
import 'package:expenso_app/features/presentation/bloc/expanse_event.dart';
import 'package:expenso_app/features/presentation/bloc/expense_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavHomePage extends StatefulWidget {
  const NavHomePage({super.key});

  @override
  State<NavHomePage> createState() => NavHomePageState();
}

class NavHomePageState extends State<NavHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ExpenseBloc>().add(FetchInitialExpenseEvent());
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Log-Out'),
          content: const Text('Are you sure for Log Out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setInt(AppConstant.pref_user_id, 0);
                Navigator.pushReplacementNamed(context, AppRoute.login);
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title:Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: _showLogoutDialog,
            icon:Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<ExpenseBloc, ExpenseState>(
          builder: (context, state) {
            // Loading state
            if (state is ExpenseLoadingSate) {
              return const Center(child: CircularProgressIndicator());
            }

            // Error state
            if (state is ExpenseErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 60, color: Colors.red),
                    SizedBox(height: 12),
                    Text(state.errorMsg),
                  ],
                ),
              );
            }

            // Loaded state
            if (state is ExpenseLoadedState) {
              if (state.allExp.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.receipt_long,
                          size: 80, color: Colors.grey[400]),
                      SizedBox(height: 12),
                      Text(
                        'No Data Found!!',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              num totalIncome = 0;
              num totalExpense = 0;
              for (var e in state.allExp) {
                // expType == 1 → Income, expType == 0 → Expense
                if (e.expType == 1) {
                  totalIncome += e.amt;
                } else {
                  totalExpense += e.amt;
                }
              }
              num balance = totalIncome - totalExpense;

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildBalanceCard(balance),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildSmallCard(
                          title: 'Income',
                          amount: totalIncome,
                          color: Colors.green,
                          icon: Icons.arrow_downward,
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: _buildSmallCard(
                          title: 'Expense',
                          amount: totalExpense,
                          color: Colors.red,
                          icon: Icons.arrow_upward,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Recent Transactions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // Expense list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.allExp.length,
                    itemBuilder: (context, index) {
                      final exp = state.allExp[index];
                      return _buildExpenseTile(exp);
                    },
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      ),
    );
  }

  //Helper Widgets

  // Bada Balance Card
  Widget _buildBalanceCard(num balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.purple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Balance',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            '₹ $balance',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Chota card (Income/Expense)
  Widget _buildSmallCard({
    required String title,
    required num amount,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: color.withOpacity(0.15),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontSize: 13)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '₹ $amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  // Ek expense item ka tile
  Widget _buildExpenseTile(dynamic exp) {
    // exp = ExpenseModel object
    bool isIncome = exp.expType == 1;
    Color amountColor = isIncome ? Colors.green : Colors.red;
    IconData icon = isIncome ? Icons.arrow_downward : Icons.arrow_upward;
    String sign = isIncome ? '+' : '-';

    // Date format
    DateTime date = DateTime.fromMillisecondsSinceEpoch(exp.createdAt);
    String dateStr = '${date.day}/${date.month}/${date.year}';

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Left icon
          CircleAvatar(
            radius: 22,
            backgroundColor: amountColor.withOpacity(0.15),
            child: Icon(icon, color: amountColor),
          ),
          SizedBox(width: 12),

          // Title aur description
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  exp.desc,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  dateStr,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),

          // Right side amount
          Text(
            '$sign ₹${exp.amt}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: amountColor,
            ),
          ),
        ],
      ),
    );
  }
}