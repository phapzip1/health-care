import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_care/bloc/app_bloc.dart';
import 'package:health_care/bloc/app_event.dart';
// import 'package:health_care/services/notification_service.dart';

class HeaderSection extends StatelessWidget {
  final String url;
  final String userName;

  const HeaderSection({super.key, required this.url, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          radius: 28.0,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Good Morning,',
              style: TextStyle(
                color: Color(0xFF828282),
                fontSize: 16,
              ),
            ),
            Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Flexible(
          fit: FlexFit.loose,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              icon: const Icon(
                Icons.more_vert,
              ),
              items: const [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      Text('Logout'),
                    ],
                  ),
                )
              ],
              onChanged: (itemIdentifier) async {
                if (itemIdentifier == 'logout') {
                  // await NotificationService.cancelSchedule();
                  context.read<AppBloc>().add(const AppEventLogout());
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
