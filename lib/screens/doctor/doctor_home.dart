import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_card.dart';
import '../auth/login_page.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  int selectedIndex = 0;

  final titles = const [
    'Doctor Dashboard',
    'Appointments',
    'Patients',
    'Medical Records',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = const [
      DoctorDashboard(),
      DoctorAppointments(),
      DoctorPatients(),
      DoctorRecords(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
              color: AppTheme.primary,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.medical_services,
                      color: AppTheme.primary,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Dr. Sharma',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Veterinary Surgeon',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            for (int i = 0; i < titles.length; i++)
              ListTile(
                selected: selectedIndex == i,
                leading: Icon(
                  [
                    Icons.dashboard,
                    Icons.calendar_month,
                    Icons.people,
                    Icons.folder_shared,
                  ][i],
                ),
                title: Text(titles[i]),
                onTap: () {
                  setState(() {
                    selectedIndex = i;
                  });

                  Navigator.pop(context);
                },
              ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (_) => false,
                );
              },
            ),
          ],
        ),
      ),

      body: pages[selectedIndex],
    );
  }
}

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final appointments = DemoData.appointments
        .where((a) => a.doctor == 'Dr. Sharma')
        .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: AppTheme.primary,
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, Doctor 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Here is your clinic activity for today.',
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),

        const SizedBox(height: 25),

        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: const [
            DoctorStat(icon: Icons.calendar_month, value: '8', title: 'Today'),
            DoctorStat(icon: Icons.people, value: '32', title: 'Patients'),
            DoctorStat(
              icon: Icons.pending_actions,
              value: '3',
              title: 'Pending',
            ),
            DoctorStat(
              icon: Icons.check_circle,
              value: '27',
              title: 'Completed',
            ),
          ],
        ),

        const SizedBox(height: 25),

        const Text(
          'Today\'s Appointments',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        ...appointments.map(
          (appointment) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.softGreen,
                  child: Icon(Icons.pets, color: AppTheme.primary),
                ),
                title: Text(
                  appointment.pet,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${appointment.owner} • ${appointment.service}'),
                trailing: Text(
                  appointment.time,
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DoctorStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const DoctorStat({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primary),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                style: const TextStyle(color: Colors.grey, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DoctorAppointments extends StatelessWidget {
  const DoctorAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final appointments = DemoData.appointments
        .where((a) => a.doctor == 'Dr. Sharma')
        .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: appointments
          .map(
            (appointment) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.softGreen,
                    child: Icon(Icons.pets, color: AppTheme.primary),
                  ),
                  title: Text(
                    appointment.pet,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${appointment.owner}\n${appointment.service}',
                  ),
                  isThreeLine: true,
                  trailing: Text(
                    appointment.time,
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class DoctorPatients extends StatelessWidget {
  const DoctorPatients({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SearchBox(hint: 'Search patients...'),

        const SizedBox(height: 20),

        ...DemoData.pets.map(
          (pet) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppTheme.softGreen,
                  child: Icon(Icons.pets, color: AppTheme.primary),
                ),
                title: Text(
                  pet.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${pet.breed} • Owner: ${pet.owner}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DoctorRecords extends StatelessWidget {
  const DoctorRecords({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: const [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Max',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Diagnosis: Healthy'),
              Text('Weight: 24 kg'),
              Text('Treatment: Routine checkup'),
              Text('Prescription: Regular diet'),
            ],
          ),
        ),

        SizedBox(height: 12),

        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rocky',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Diagnosis: Mild skin irritation'),
              Text('Treatment: Skin medication'),
              Text('Follow-up: 7 days'),
            ],
          ),
        ),
      ],
    );
  }
}
