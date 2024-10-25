import 'package:flutter/material.dart';
import '../../controllers/rewards_controller.dart';

class RewardPage extends StatefulWidget {
  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  late RewardController _rewardController;
  List<Map<String, dynamic>> _topUsers = [];

  @override
  void initState() {
    super.initState();
    _rewardController = RewardController();
    _loadTopUsers();
  }

  Future<void> _loadTopUsers() async {
    List<Map<String, dynamic>> topUsers = await _rewardController.getTopUsers();
    setState(() {
      _topUsers = topUsers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top 10 Rewards'),
      ),
      body: _topUsers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _topUsers.length,
        itemBuilder: (context, index) {
          final user = _topUsers[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text((index + 1).toString()),
            ),
            title: Text(user['username']),
            subtitle: Text('Points: ${user['total_points']}'),
          );
        },
      ),
    );
  }
}
