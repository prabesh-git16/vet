import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_card.dart';
import '../auth/login_page.dart';

class ClientHome extends StatefulWidget {
  const ClientHome({super.key});

  @override
  State<ClientHome> createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {
  int selectedIndex = 0;

  final titles = const ['Home', 'My Pets', 'Appointments', 'Medical Records'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      const ClientDashboard(),
      const ClientPets(),
      const ClientAppointments(),
      const ClientRecords(),
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
                    child: Icon(Icons.person, color: AppTheme.primary),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Sabo Luffy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text('Client', style: TextStyle(color: Colors.white70)),
                ],
              ),
            ),

            for (int i = 0; i < titles.length; i++)
              ListTile(
                selected: selectedIndex == i,
                leading: Icon(
                  [
                    Icons.home,
                    Icons.pets,
                    Icons.calendar_month,
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

      floatingActionButton: selectedIndex == 1
          ? FloatingActionButton.extended(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('Add Pet'),
            )
          : null,
    );
  }
}

class ClientDashboard extends StatelessWidget {
  const ClientDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = DemoData.pets
        .where((pet) => pet.owner == 'Sabo Luffy')
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
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, Sabo 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Keep your pets healthy and happy.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Icon(Icons.pets, color: Colors.white24, size: 65),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'Upcoming Appointment',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        const AppCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppTheme.softGreen,
                child: Icon(Icons.pets, color: AppTheme.primary),
              ),

              SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Max',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      'General Checkup • Dr. Sharma',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Today • 10:30 AM',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(Icons.arrow_forward_ios, size: 15),
            ],
          ),
        ),

        const SizedBox(height: 25),

        const Text(
          'My Pets',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        ...pets.map(
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
                subtitle: Text('${pet.breed} • ${pet.age}'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClientPets extends StatelessWidget {
  const ClientPets({super.key});

  @override
  Widget build(BuildContext context) {
    final pets = DemoData.pets
        .where((pet) => pet.owner == 'Sabo Luffy')
        .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SearchBox(hint: 'Search my pets...'),

        const SizedBox(height: 20),

        ...pets.map(
          (pet) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundColor: AppTheme.softGreen,
                  child: Icon(Icons.pets, color: AppTheme.primary),
                ),
                title: Text(
                  pet.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${pet.species} • ${pet.breed} • ${pet.age}'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClientAppointments extends StatelessWidget {
  const ClientAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    final appointments = DemoData.appointments
        .where((a) => a.owner == 'Sabo Luffy')
        .toList();

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        ...appointments.map(
          (appointment) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appointment.pet,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    appointment.service,
                    style: const TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    '${appointment.doctor} • ${appointment.time}',
                    style: const TextStyle(color: AppTheme.primary),
                  ),

                  const SizedBox(height: 10),

                  Chip(label: Text(appointment.status)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ClientRecords extends StatelessWidget {
  const ClientRecords({super.key});

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
                'Max — Medical Record',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 12),

              Text('Last Visit: General Checkup'),

              Text('Doctor: Dr. Sharma'),

              Text('Weight: 24 kg'),

              Text('Status: Healthy'),

              SizedBox(height: 12),

              Text(
                'Prescription: Continue regular diet and exercise.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
