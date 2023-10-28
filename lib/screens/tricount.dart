import 'package:flutter/material.dart';
import 'package:tricount/screens/create_transaction.dart';
import 'package:tricount/widgets/appbar.dart';
import 'package:tricount/widgets/qrcode.dart';

class TricountScreen extends StatefulWidget {
  const TricountScreen({super.key});

  @override
  State<TricountScreen> createState() => _TricountScreenState();
}

class _TricountScreenState extends State<TricountScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void onPressedQRCode() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30.0),
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            maxChildSize: 0.8,
            minChildSize: 0.1,
            builder: (context, scrollController) => SingleChildScrollView(
                controller: scrollController, child: const QRCode())),
        showDragHandle: true,
        isScrollControlled: true);
  }

  void onPressedCreateTransaction() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CreateTransactionScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TriCountAppBar(
        title: "My first Tricount !",
        onPressedQRCode: onPressedQRCode,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.swap_vert),
              text: "Transactions",
            ),
            Tab(
              icon: Icon(Icons.balance),
              text: "Balance"
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onPressedCreateTransaction,
        child: const Icon(Icons.add),
        shape: CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [const Text("My total: "), const Text("My balance: ")],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: Text("Expense page"),
          ),
          Center(
            child: Text("Balance page"),
          )
        ],
      ),
    );
  }
}
