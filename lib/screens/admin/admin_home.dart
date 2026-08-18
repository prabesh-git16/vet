import '../../models/appointment_model.dart';
import 'package:flutter/material.dart';

import '../../data/demo_data.dart';
import '../../theme/app_theme.dart';
import '../../widgets/app_card.dart';
import '../auth/login_page.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  int selectedIndex = 0;

  final titles = const [
    'Dashboard',
    'Veterinarians',
    'Clients',
    'Pets',
    'Appointments',
    'Services',
    'Reports',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    final pages = const [
      AdminDashboard(),
      AdminDoctors(),
      AdminClients(),
      AdminPets(),
      AdminAppointments(),
      AdminServices(),
      AdminReports(),
      AdminSettings(),
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
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundColor: AppTheme.softGreen,
            child: Icon(Icons.admin_panel_settings, color: AppTheme.primary),
          ),
          const SizedBox(width: 15),
        ],
      ),

      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 25),
              color: AppTheme.primary,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.pets, size: 35, color: AppTheme.primary),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'PawCare',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'Veterinary Clinic',
                    style: TextStyle(color: Colors.white70),
                  ),

                  SizedBox(height: 15),

                  Text(
                    'ADMIN PANEL',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  for (int i = 0; i < titles.length; i++)
                    ListTile(
                      selected: selectedIndex == i,
                      selectedTileColor: AppTheme.softGreen,
                      leading: Icon(
                        [
                          Icons.dashboard,
                          Icons.medical_services,
                          Icons.people,
                          Icons.pets,
                          Icons.calendar_month,
                          Icons.local_hospital,
                          Icons.bar_chart,
                          Icons.settings,
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
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(15),
              child: ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginPage()),
                    (_) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),

      body: pages[selectedIndex],
    );
  }
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
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
                      'Welcome, Admin 👋',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Manage your veterinary clinic from one place.',
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Icon(Icons.admin_panel_settings, size: 70, color: Colors.white24),
            ],
          ),
        ),

        const SizedBox(height: 30),

        const Text(
          'Clinic Overview',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        GridView.count(
          crossAxisCount: MediaQuery.of(context).size.width > 700 ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.5,
          children: const [
            AdminStat(icon: Icons.people, title: 'Clients', value: '248'),
            AdminStat(
              icon: Icons.medical_services,
              title: 'Veterinarians',
              value: '12',
            ),
            AdminStat(icon: Icons.pets, title: 'Pets', value: '386'),
            AdminStat(
              icon: Icons.calendar_month,
              title: 'Appointments',
              value: '54',
            ),
          ],
        ),

        const SizedBox(height: 30),

        const Text(
          'Today\'s Appointments',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 15),

        ...DemoData.appointments.map(
          (appointment) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppointmentCard(appointment: appointment),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          'Recent Activity',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 12),

        const ActivityItem(
          icon: Icons.person_add,
          title: 'New client registered',
          subtitle: 'Sunita Rai created an account',
          time: '10 min ago',
        ),

        const ActivityItem(
          icon: Icons.calendar_month,
          title: 'New appointment booked',
          subtitle: 'Max • General Checkup',
          time: '25 min ago',
        ),

        const ActivityItem(
          icon: Icons.medical_services,
          title: 'New veterinarian added',
          subtitle: 'Dr. Anisha joined PawCare',
          time: '1 hour ago',
        ),
      ],
    );
  }
}

class AdminStat extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const AdminStat({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: AppTheme.softGreen,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Icon(icon, color: AppTheme.primary),
          ),

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

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 25,
            backgroundColor: AppTheme.softGreen,
            child: Icon(Icons.pets, color: AppTheme.primary),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment.pet,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${appointment.service} • ${appointment.doctor}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  'Owner: ${appointment.owner}',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                appointment.time,
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              Chip(
                label: Text(
                  appointment.status,
                  style: const TextStyle(fontSize: 10),
                ),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppTheme.softGreen,
              child: Icon(icon, color: AppTheme.primary),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),

            Text(
              time,
              style: const TextStyle(color: Colors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDoctors extends StatelessWidget {
  const AdminDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagementPage(
      title: 'Veterinarian',
      searchHint: 'Search veterinarians...',
      items: DemoData.doctors
          .map(
            (doctor) => ManagementItem(
              icon: Icons.medical_services,
              title: doctor.name,
              subtitle: '${doctor.email} • Veterinary Surgeon',
              status: 'Active',
            ),
          )
          .toList(),
    );
  }
}

class AdminClients extends StatelessWidget {
  const AdminClients({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagementPage(
      title: 'Client',
      searchHint: 'Search clients...',
      items: DemoData.clients
          .map(
            (client) => ManagementItem(
              icon: Icons.person,
              title: client.name,
              subtitle: client.email,
              status: 'Active',
            ),
          )
          .toList(),
    );
  }
}

class AdminPets extends StatelessWidget {
  const AdminPets({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagementPage(
      title: 'Pet',
      searchHint: 'Search pets...',
      items: DemoData.pets
          .map(
            (pet) => ManagementItem(
              icon: Icons.pets,
              title: pet.name,
              subtitle: '${pet.breed} • ${pet.age} • Owner: ${pet.owner}',
              status: pet.species,
            ),
          )
          .toList(),
    );
  }
}

class AdminAppointments extends StatelessWidget {
  const AdminAppointments({super.key});

  @override
  Widget build(BuildContext context) {
    return ManagementPage(
      title: 'Appointment',
      searchHint: 'Search appointments...',
      items: DemoData.appointments
          .map(
            (appointment) => ManagementItem(
              icon: Icons.calendar_month,
              title: '${appointment.pet} • ${appointment.service}',
              subtitle:
                  '${appointment.doctor} • ${appointment.owner} • ${appointment.time}',
              status: appointment.status,
            ),
          )
          .toList(),
    );
  }
}

class ManagementPage extends StatelessWidget {
  final String title;
  final String searchHint;
  final List<ManagementItem> items;

  const ManagementPage({
    super.key,
    required this.title,
    required this.searchHint,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          SearchBox(hint: searchHint),

          const SizedBox(height: 20),

          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppTheme.softGreen,
                      child: Icon(item.icon, color: AppTheme.primary),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            item.subtitle,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Chip(label: Text(item.status)),

                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_vert),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: Text('Add $title'),
      ),
    );
  }
}

class ManagementItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;

  const ManagementItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
  });
}

class AdminServices extends StatelessWidget {
  const AdminServices({super.key});

  @override
  Widget build(BuildContext context) {
    const services = [
      (
        'General Checkup',
        'Complete health examination',
        'Rs. 500',
        Icons.health_and_safety,
      ),
      ('Vaccination', 'Pet vaccination services', 'Rs. 800', Icons.vaccines),
      (
        'Surgery',
        'Minor and major surgeries',
        'From Rs. 5,000',
        Icons.medical_services,
      ),
      ('Grooming', 'Pet grooming and cleaning', 'Rs. 1,000', Icons.clean_hands),
      ('Pharmacy', 'Veterinary medicines', 'Various', Icons.medication),
    ];

    return Scaffold(
      backgroundColor: AppTheme.background,
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: services.map((service) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      color: AppTheme.softGreen,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(service.$4, color: AppTheme.primary),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          service.$1,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          service.$2,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          service.$3,
                          style: const TextStyle(
                            color: AppTheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.edit_outlined),
                  ),

                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppTheme.primary,
        foregroundColor: Colors.white,
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Service'),
      ),
    );
  }
}

class AdminReports extends StatelessWidget {
  const AdminReports({super.key});

  @override
  Widget build(BuildContext context) {
    const reports = [
      (
        'Appointment Report',
        'View appointment statistics',
        Icons.calendar_month,
      ),
      ('Client Report', 'View registered client statistics', Icons.people),
      ('Pet Report', 'View registered pet statistics', Icons.pets),
      ('Revenue Report', 'View clinic revenue and payments', Icons.payments),
      (
        'Veterinarian Report',
        'View doctor performance',
        Icons.medical_services,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Clinic Reports',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        ...reports.map(
          (report) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  backgroundColor: AppTheme.softGreen,
                  child: Icon(report.$3, color: AppTheme.primary),
                ),
                title: Text(
                  report.$1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(report.$2),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AdminSettings extends StatelessWidget {
  const AdminSettings({super.key});

  @override
  Widget build(BuildContext context) {
    const settings = [
      ('Clinic Information', Icons.local_hospital_outlined),
      ('Working Hours', Icons.schedule),
      ('Notification Settings', Icons.notifications_outlined),
      ('Security', Icons.security),
      ('User Roles & Permissions', Icons.people_outline),
      ('Backup & Restore', Icons.backup_outlined),
      ('About PawCare', Icons.info_outline),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Clinic Settings',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        ...settings.map(
          (setting) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppCard(
              padding: EdgeInsets.zero,
              child: ListTile(
                leading: Icon(setting.$2, color: AppTheme.primary),
                title: Text(setting.$1),
                trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                onTap: () {},
              ),
            ),
          ),
        ),
      ],
    );
  }
}
