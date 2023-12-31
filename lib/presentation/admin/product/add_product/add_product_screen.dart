import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_mate/application/product/product_bloc.dart';
import 'package:shop_mate/domain/product/model/product.dart';
import 'package:shop_mate/presentation/constants/colors.dart';
import 'package:shop_mate/presentation/util/snackbar.dart';
import 'package:shop_mate/presentation/widgets/button_widgets.dart';
import 'package:shop_mate/presentation/widgets/text_form_field_widgets.dart';
import 'package:shop_mate/presentation/widgets/text_widgets.dart';
import 'package:image_pickers/image_pickers.dart';

class AddProductScreen extends StatefulWidget {
  AddProductScreen({
    super.key,
  });

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? name;

  String? description;

  String? amount;

  String? quantity;
  String? category;

  List<Media>? image;

  bool error = false;

  _AddProductScreenState();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.whiteColor,
      width: 1.sw,
      height: .9.sh,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  error == true
                      ? const CircleAvatar()
                      : const BuildHeadingText(text: 'Add Product'),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  )
                ],
              ),
              BuildTextFormField(
                label: "Product name",
                hintText: 'Enter product name',
                icon: Icons.abc,
                func: (value) {
                  name = value;
                },
              ),
              BuildTextAreaField(
                label: "Desciption",
                hintText: 'Enter product description',
                icon: Icons.description,
                func: (value) {
                  description = value;
                },
              ),
              BuildTextFormField(
                label: "Amount",
                hintText: 'Enter product amount',
                icon: Icons.money,
                keyboardType: TextInputType.number,
                func: (value) {
                  amount = value;
                },
              ),
              BuildTextFormField(
                label: "Quantity",
                hintText: 'Enter product quantity',
                icon: Icons.shopping_basket,
                keyboardType: TextInputType.number,
                func: (value) {
                  quantity = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownMenu(
                onSelected: (value) {
                  category = value;
                },
                menuStyle: const MenuStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColor.colorGrey3),
                ),
                hintText: "Category",
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'laptop', label: 'Laptops'),
                  DropdownMenuEntry(value: 'mobile', label: 'Mobiles'),
                  DropdownMenuEntry(value: 'earphone', label: 'Earphones'),
                ],
              ),
              TextButton.icon(
                onPressed: () async {
                  List<Media> selectedImages = await pickMultipleImages();
                  if (selectedImages.isNotEmpty) {
                    image = selectedImages;
                  }
                },
                icon: const Icon(
                  Icons.image,
                  color: AppColor.greenColor,
                ),
                label: image != null
                    ? const Text(
                        "Image Added",
                        style: TextStyle(color: AppColor.greenColor),
                      )
                    : const Text(
                        "Add Image",
                        style: TextStyle(color: AppColor.greenColor),
                      ),
              ),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return BuildButtonWidget(
                    text: "Upload",
                    onTap: () {
                      uploadData(context);
                    },
                    state: state,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Media>> pickMultipleImages() async {
    try {
      List<Media> selectedImages = await ImagePickers.pickerPaths(
        galleryMode: GalleryMode.image,
        selectCount: 5, // Set the maximum number of images to pick
      );
      return selectedImages;
    } catch (e) {
      snackBar(context: context, msg: 'Something went wrong');
      return [];
    }
  }

  void uploadData(context) {
    if (name == null ||
        description == null ||
        amount == null ||
        quantity == null ||
        image == null ||
        category == null) {
      snackBar(context: context, msg: 'Please fill the form');
      // return;
    } else {
      final am = double.parse(amount!);
      final qty = int.parse(quantity!);
      BlocProvider.of<ProductBloc>(context).add(
        ProductEvent.addProduct(
          product: ProductModel(
            name: name!,
            description: description!,
            amount: am,
            quantity: qty,
            category: category!,
            image: [],
          ),
          selectedImages: image!,
          context: context,
        ),
      );
    }
  }
}
