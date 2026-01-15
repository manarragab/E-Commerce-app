import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/remote_data/core.dart';
import 'package:ecommerce_app/features/auth/domain/controller/auth_controller.dart';
import 'package:ecommerce_app/features/home/domain/controller/home_controller.dart';
import 'package:ecommerce_app/features/home/presentation/widget/cart_body.dart';
import 'package:ecommerce_app/features/home/presentation/widget/home_body.dart';
import 'package:ecommerce_app/features/home/presentation/widget/search_body.dart';
import 'package:ecommerce_app/features/home/presentation/widget/settings_body.dart';
import 'package:ecommerce_app/features/home/presentation/widget/wishlist_body.dart';
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MainGetxController mainGetxController = Get.find<MainGetxController>();
  final AuthController controller = Get.find<AuthController>();
  HomeController homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
  });
  }

  @override
  Widget build(BuildContext context) {
    return
    GetBuilder<HomeController>(builder: (controller){
      final List<Widget> _pages = [
        const HomeBody(),
        WishlistBody(),
         CartBody(),
        const SearchBody(),
        const SettingsBody(),
      ];

      return  Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.selectedIndex,
        onTap: (index){
        controller.onItemTapped(index , null);
        },
        elevation: 4,
        showUnselectedLabels: true,
        showSelectedLabels: false,
        
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black87,
        selectedIconTheme: IconThemeData(size: 28.sp),
        items:  List.generate(5, (index) {
              return  icons(
                controller.iconsList[index] ,
                controller.selectedIndex==index?
                 CustomColors.primary.withOpacity(0.5) : Colors.transparent,controller.labelsList[index]
              ); }),
      ),  

      appBar: 
       CustomAppBar.homeAppBar(
        onChange: (val) {},
        actionWidget: CircleAvatar(
          radius: 15,
          backgroundColor: CustomColors.lightRED,
          child: CustomImage.network(demoImage, fit: BoxFit.contain),
        ),
      ),

      body: IndexedStack( 
        index: controller.selectedIndex,
        children: _pages,
      ),
      
    );
    });
    
  }
  BottomNavigationBarItem icons(Icon icon ,Color color , String label){
return BottomNavigationBarItem(
         icon: Container(
         padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
                  child: icon), label: label);
           
  }
  
  
  
  }