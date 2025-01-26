import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(HealthAssistantApp());
}

class HealthAssistantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Health Assistant',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Your personal healthcare companion'),
            SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16),
            Text('Or continue with'),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.g_mobiledata),
                  color: Colors.red,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.apple),
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Assistant'),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(Icons.person, color: Colors.blue),
          ),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back, John Doe',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFeatureCard(context, 'Chat with AI', Colors.blue[100]!, 'https://www.chatbase.co/chatbot-iframe/hf_8R6hV5iQsNEFRwLi-K'),
                _buildFeatureCard(context, 'Tasks', Colors.purple[100]!, 'https://www.chatbase.co/chatbot-iframe/Ho5hEvTOM-zNBL6bVPPWm'),
              ],
            ),
            SizedBox(height: 16),
            Text(
              "Today's Schedule",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildScheduleItem('9:00 AM', 'Morning Medicine', Colors.green),
            _buildScheduleItem('2:00 PM', 'Doctor Appointment', Colors.blue),
            _buildScheduleItem('8:00 PM', 'Evening Medicine', Colors.purple),
            SizedBox(height: 16),
            Text(
              'Health Stats',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                _buildStatCard('Steps', '6,540\nDaily Goal: 10,000', Icons.directions_walk, Colors.green),
                SizedBox(width: 16),
                _buildStatCard('Tasks', '3/5\nCompleted Today', Icons.check_circle, Colors.blue),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Calendar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildCalendar(context),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, String label, Color color, String url) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
          );
        },
        child: Card(
          color: color,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Icon(Icons.web, size: 40, color: Colors.black54),
                SizedBox(height: 8),
                Text(label),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String time, String task, Color color) {
    return ListTile(
      leading: CircleAvatar(
        radius: 5,
        backgroundColor: color,
      ),
      title: Text(task),
      subtitle: Text(time),
    );
  }

  Widget _buildStatCard(String title, String stats, IconData icon, Color color) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 40, color: color),
              SizedBox(height: 8),
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(stats, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendar(BuildContext context) {
    return Column(
      children: [
        CalendarDatePicker(
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          onDateChanged: (date) {},
        ),
        SizedBox(height: 16),
        ListTile(
          title: Text('Dr. Sarah Wilson'),
          subtitle: Text('General Checkup - Sept 6, 10:00 AM'),
          trailing: Icon(Icons.more_vert),
        ),
        ListTile(
          title: Text('Blood Test'),
          subtitle: Text('Lab Analysis - Sept 15, 9:30 AM'),
          trailing: Icon(Icons.more_vert),
        ),
      ],
    );
  }
}

class WebViewScreen extends StatelessWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..loadRequest(Uri.parse(url))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
