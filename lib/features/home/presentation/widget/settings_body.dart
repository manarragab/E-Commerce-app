import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({Key? key}) : super(key: key);

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== Profile Section =====
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    Icons.person,
                    size: 45,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  authController.name ?? "",
                  style: TFonts.montFont(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  authController.email ?? "",
                  style: TFonts.montFont(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// ===== Settings Card =====
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Column(
              children: [

                /// Dark Mode
                GetBuilder<AuthController>(
                  builder: (controller) => ListTile(
                    leading: Icon(
                      controller.isDark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      color: Colors.orange,
                    ),
                    title: Text(
                    !controller.isDark ?  "Dark Mode" : "Light Mode",
                      style: TFonts.montFont(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Switch(
                      value: controller.isDark,
                      onChanged: (val) {
                        controller.toggleTheme(val);
                      },
                    ),
                  ),
                ),

                const Divider(height: 1),

                /// Logout (example)
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.red,
                  ),
                  title: Text(
                    "Logout",
                    style: TFonts.montFont(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                  //  authController.logout();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
