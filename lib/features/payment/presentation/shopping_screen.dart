import 'package:ecommerce_app/data/const/export.dart';
import 'package:ecommerce_app/data/remote_data/core.dart';
import 'package:ecommerce_app/features/payment/domain/controller/payment_controller.dart';
import 'package:ecommerce_app/res/router/pages.dart';
import 'package:flutter/material.dart';

class ShoppingScreen extends StatefulWidget {
  final String? image;

  const ShoppingScreen({Key? key, this.image}) : super(key: key);

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  var selectedColorIndex = (-1).obs;
  var quantity = 1.obs;
 final isSelected =0 ;
 
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
      appBar: CustomAppBar.appBar("Shopping Screen"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ================= Product Card =================
           Obx(() {
                          return    Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ---------- Image ----------
                  
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CustomImage.network(
                        data[0] ?? demoImage,
                        height: 150,
                        width: 120,
                        fit: BoxFit.cover,
                        color: selectedColorIndex.value == 0 ? Colors.green :
                        selectedColorIndex.value == 1 ? Colors.blue :
                        selectedColorIndex.value == 2 ? Colors.red :
                        selectedColorIndex.value == 3 ? Colors.yellow :
                        selectedColorIndex.value == 4 ? Colors.purple :

                         null,
                       changeColor: BlendMode.color   , 
                      ),
                    ),
                    const SizedBox(width: 16),

                    // ---------- Details ----------
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            data[1] ?? "Product Title",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),

                          // Subtitle
                          Text(
                            data[2] ?? "Product Subtitle",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),

                          // Price
                          Text(
                            "\$${data.length > 3 ? data[3] : "0.00"}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(height: 12),

                          // ---------- Color Selection Label ----------
                          const Text(
                            "Select Color:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // ---------- Color Buttons ----------
                        
                       Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: List.generate(5, (index) {
                              final colors = [
                                Colors.green,
                                Colors.blue,
                                Colors.red,
                                Colors.yellow,
                                Colors.purple
                              ];
                             final  isSelected = selectedColorIndex.value == index;

                              return GestureDetector(
                                onTap: () {
                                 
                                    selectedColorIndex.value = index;
                                
                                },
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: colors[index],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.black
                                          : Colors.grey.shade300,
                                      width: isSelected ? 2.5 : 1.5,
                                    ),
                                    boxShadow: isSelected
                                        ? [
                                            BoxShadow(
                                              color: colors[index]
                                                  .withOpacity(0.4),
                                              blurRadius: 8,
                                              spreadRadius: 2,
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 18,
                                        )
                                      : null,
                                ),
                              );
                            }),
                          ),
                       
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );}),

            const SizedBox(height: 24),

            // ================= Quantity Section =================
        Obx(() {
                          return     Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Quantity:",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        // Decrease Button
                        IconButton(
                          onPressed: () {
                            if (quantity > 1) {
                              
                                quantity.value--;
                              
                            }
                          },
                          icon: const Icon(Icons.remove_circle_outline , size: 22,),
                          color: Colors.red,
                        ),
                        
                        // Quantity Display
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "${quantity.value}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        
                        // Increase Button
                        IconButton(
                          onPressed: () {
                          
                              quantity.value++;
                           
                          },
                          icon: const Icon(Icons.add_circle_outline , size: 22,),
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );}),

            const SizedBox(height: 24),

            // ================= Action Buttons =================
           
            SizedBox(
              width: double.infinity,
              child: MainButton(
                onPressed: () {
                 final controller=Get.find<PaymentController>();
                 controller.price = data[3];
                 Get.toNamed(CustomPage.payPage ,arguments: (int.tryParse(data[3]) ?? 0) * quantity.value);
                },
                title: "Buy Now",
                height: 50,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                icon: const Icon(
                  Icons.flash_on,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ================= Product Info Tabs =================
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     SizedBox(height: 10,),

           Text(
                "Product Name",
                style: TextStyle(
                   fontSize: 18,
                        fontWeight: FontWeight.bold,
                      
                ),
              ),
                                  const SizedBox(height: 8),

              Text(
                      data[1],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 15),
                                        const Divider( color: Color.fromARGB(255, 88, 88, 88),),
                    const SizedBox(height: 15),
                    const Text(
                      "Product Details",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.length > 2 ? data[2] : "No description available",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Divider( color: Color.fromARGB(255, 88, 88, 88),),
                    const SizedBox(height: 16),
                    
                    // Specifications
                   // _buildInfoRow("Brand:", "Sample Brand"),
                    _buildInfoRow("Category:", "${data[4]}"),
                    _buildInfoRow("Availability:", "In Stock"),
                    _buildInfoRow("Shipping:", "Free Delivery"),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper Widget for Info Rows
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}