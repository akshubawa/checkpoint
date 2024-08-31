import 'package:flutter/material.dart';

class Myteam extends StatelessWidget {
  const Myteam({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text(
          'My Leaves',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  // Increase the size of the Stack for a larger circular progress bar
                  SizedBox(
  width: 200, // Adjust the size as needed
  height: 200, // Adjust the size as needed
  child: FittedBox(
    child: Stack(
       alignment: Alignment.center,
      children: [
        CircularProgressIndicator(
          value: 5 / 20,
          strokeWidth: 3,
          valueColor: const AlwaysStoppedAnimation<Color>(
            Colors.blueAccent,
          ),
          backgroundColor: Colors.grey.shade200,
        ),
        const Text(
                        '05',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
      ],
    ),
  ),
)
,
                  const SizedBox(height: 20),
                  const Text(
                    'Leave Balance',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Click to Apply for Leave',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Total Leaves',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '20',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Leaves Used',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '15',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                leaveCategory('Casual', 2, Colors.blue),
                leaveCategory('Medical', 4, Colors.pink),
                leaveCategory('Annual', 7, Colors.orange),
                leaveCategory('Maternity', 0, Colors.grey),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Approvals', style: TextStyle(color: Colors.white),),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Leaves History',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  leaveRequest('Casual Leave', '25th Mar to 26 Mar', 'REQUESTED'),
                  leaveRequest('Casual Leave', '02th Mar', 'APPROVED'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget leaveCategory(String title, int count, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Text(
            count.toString(),
            style: TextStyle(color: color),
          ),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget leaveRequest(String title, String date, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent.withOpacity(0.2),
            radius: 5,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: '$title ',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      TextSpan(
                        text: 'Applied form $date',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                const Text(
                  '10th Mar - 2:40 PM',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          statusBadge(status),
        ],
      ),
    );
  }

  Widget statusBadge(String status) {
    Color color;
    if (status == 'APPROVED') {
      color = Colors.green;
    } else if (status == 'REQUESTED') {
      color = Colors.orange;
    } else {
      color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(color: color),
      ),
    );
  }
}
