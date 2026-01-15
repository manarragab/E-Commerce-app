// import 'dart:io';

// import 'package:ecommerce_app/data/const/export.dart';

// import '../../../data/remote_data/core.dart';

// class CustomImageNetwork extends StatelessWidget {
//   CustomImageNetwork({
//     required this.path,
//     this.height = 100,
//     this.width = 100,
//     this.fit = BoxFit.fill,
//     Key? key,
//     this.borderRadius = BorderRadius.zero,
//     this.backgroundColor = Colors.white,
//     this.color,
//     this.onError,
//     this.padding,
//   }) : super(key: key);
//   String path;
//   double height;
//   double width;
//   BoxFit fit;
//   BorderRadius borderRadius;
//   Color? backgroundColor;
//   Color? color;
//   Widget? onError;
//   EdgeInsets? padding;

//   // final String load1 = 'assets/icons/Spinner-1s-200px.gif';
//   final String load2 = 'assets/lotties/load1.gif';
//   //final String load3 = 'assets/svg/logo.svg';
//   //final String load4 = 'assets/lotties/loading.gif';

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: borderRadius,
//       child: isSvgPath(path: path)
//           ? Container(
//               color: backgroundColor,
//               height: height,
//               width: width,
//               padding: padding ?? const EdgeInsets.all(10.0),
//               child: !isLocalPath(path)
//                   ? SvgPicture.network(
//                       "${getPath(path)}",
//                       height: height,
//                       width: width,
//                       fit: fit,
//                       color: color,
//                       placeholderBuilder: (BuildContext context) {
//                         return Container(
//                           alignment: Alignment.center,
//                           color: CustomColors.accentLight,
//                          //child: CircularProgressIndicator()

//                           child: SvgPicture.asset(
//                             "assets/svg/splash.svg",
//                             width: 50,
//                             height: 50,
//                           ),
//                         );
//                       },
//                       /*      AdvancedNetworkSvg(
//                           "${getPath(path)}",
//                           useDiskCache: true,
//                           (theme) => (bytes, colorFilter, key) {
//                                 print('colorFilter:: ${colorFilter}');
//                                 return svg.svgPictureDecoder(
//                                   bytes ?? Uint8List.fromList(const []),
//                                   false,
//                                   colorFilter,
//                                   key,
//                                 );
//                               }, loadFailedCallback: () {
//                         return SvgPicture.asset(
//                           "assets/svg/about_us.svg",
//                           fit: BoxFit.scaleDown,
//                           width: 24,
//                           height: 24,
//                         );
//                       }),*/
//                     )
//                   : SvgPicture.asset(path,
//                       height: height,
//                       width: width,
//                       fit: fit, placeholderBuilder: (BuildContext context) {
//                       return SvgPicture.asset("assets/svg/splash.svg");
//                     }),
//             )
//           : !isLocalPath(path)
//               ? FadeInImage(
//                   height: height,
//                   width: width,
//                   // for loading
//                   placeholderFit: BoxFit.scaleDown,
//                   placeholder: AssetImage(load2),
//                   image: NetworkImage(
//                     "${getPath(path)}",
//                     scale: 0.5,
//                     headers: {
//                       HttpHeaders.authorizationHeader: "Bearer test_token"
//                     },
//                   ),
//                   fit: fit,
//                   imageErrorBuilder: (context, error, st) {
//                     return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 10),
//                         child:
//                             onError ?? SvgPicture.asset("assets/svg/splash.svg"));
//                   },
//                 )
//               : Container(
//                   height: height,
//                   width: width,
//                   decoration: BoxDecoration(
//                     color: CustomColors.accentLight,
//                     borderRadius: borderRadius,
//                     image: DecorationImage(
//                       image: AssetImage(
//                         path,
//                       ),
//                       fit: fit,
//                     ),
//                   ),
//                 ),
//     );
//   }

//   getPath(String? path) {
//     if (path.toString().contains('http')) {
//       return path;
//     } else {
//       return imageDomain() + path.toString();
//     }
//   }

//   bool isSvgPath({String? path = ""}) {
//     bool isSVG = path?.contains('.svg') ?? false;
//    // sPrint.warning('isSVG:: $isSVG');
//     return isSVG;
//   }


// // bool isSvgPath(String? path) {
// //   final isSVG = (path ?? "").toLowerCase().endsWith('.svg');
// //   sPrint.warning('isSVG:: $isSVG');
// //   return isSVG;
// // }

//   bool isLocalPath(String path) {
//     return path.startsWith("assets");
//   }
// }


import 'dart:io';
import 'package:ecommerce_app/data/const/export.dart';
import '../../../data/remote_data/core.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork({
    super.key,
    required this.path,
    this.height = 100,
    this.width = 100,
    this.fit = BoxFit.fill,
    this.borderRadius = BorderRadius.zero,
    this.backgroundColor = Colors.white,
    this.color,
    this.onError,
    this.padding,
    this.changeColor,
  });

  final String path;
  final double height;
  final double width;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color? color;
  final Widget? onError;
  final EdgeInsets? padding;
  final BlendMode? changeColor;

  static const String _loadingGif = 'assets/lotties/load1.gif';

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: _isSvg(path)
          ? _buildSvg()
          : _buildImage(),
    );
  }

  // ================= SVG =================
  Widget _buildSvg() {
    if (_isLocal(path)) {
      return SvgPicture.asset(
        key: ValueKey(path),
        path,
        height: height,
        width: width,
        fit: fit,
        colorBlendMode: changeColor ?? BlendMode.modulate,
      );
    }

    return Container(
      color: backgroundColor,
      height: height,
      width: width,
      padding: padding ?? const EdgeInsets.all(10),
      child: SvgPicture.network(
        _getPath(path),
        key: ValueKey(path),
        height: height,
        width: width,
        fit: fit,
        colorBlendMode: changeColor ?? BlendMode.modulate,
        color: color,
        placeholderBuilder: (_) => _loadingWidget(),
      ),
    );
  }

  // ================= IMAGE =================
  Widget _buildImage() {
    if (_isLocal(path)) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          image: DecorationImage(
            image: AssetImage(path ),
           
            fit: fit,
          ),
        ),
      );
    }

    return Image.network(
  _getPath(path),
  gaplessPlayback: true,
   color: color,
 colorBlendMode: changeColor ?? BlendMode.modulate,
      height: height,
      width: width,
      fit: fit,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer test_token',
      },
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _loadingWidget();
      },
      errorBuilder: (context, error, stackTrace) {
        return onError ??
            Container(
              width: width,
              height: height,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SvgPicture.asset('assets/svg/splash.svg',
               width: 100 , height: 100 , colorBlendMode: changeColor ?? BlendMode.clear ,),
            );
      },
    );
  }

  // ================= Helpers =================
  Widget _loadingWidget() {
    return Center(
      child: Image.asset(
        _loadingGif,
        width: 40,
        height: 40,
        colorBlendMode: changeColor ?? BlendMode.modulate,
      ),
    );
  }

  String _getPath(String path) {
  if (path.isEmpty) return '';
  if (path.startsWith('http')) return path;
  return imageDomain() + path;
}


  bool _isSvg(String path) => path.toLowerCase().endsWith('.svg');

  bool _isLocal(String path) => path.startsWith('assets');
}
