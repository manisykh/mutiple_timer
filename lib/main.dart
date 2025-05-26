// // // // // // // // import 'package:flutter/material.dart';
// // // // // // // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // // // // // // import 'package:flutter/cupertino.dart';
// // // // // // // // import 'dart:async';
// // // // // // // // import 'dart:convert';
// // // // // // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // // // // // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // // // // // // // void main() async {
// // // // // // // //   WidgetsFlutterBinding.ensureInitialized();
// // // // // // // //   final prefs = await SharedPreferences.getInstance();
// // // // // // // //   final lastUsed = prefs.getString('last_used_preset');
// // // // // // // //   runApp(MyApp(lastUsedPreset: lastUsed));
// // // // // // // // }

// // // // // // // // class MyApp extends StatelessWidget {
// // // // // // // //   final String? lastUsedPreset;
// // // // // // // //   const MyApp({super.key, this.lastUsedPreset});

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return ScreenUtilInit(
// // // // // // // //       designSize: const Size(390, 844),
// // // // // // // //       builder:
// // // // // // // //           (context, child) => MaterialApp(
// // // // // // // //             debugShowCheckedModeBanner: false,
// // // // // // // //             title: 'Multi Player Timer',
// // // // // // // //             theme: ThemeData(
// // // // // // // //               scaffoldBackgroundColor: Colors.white,
// // // // // // // //               fontFamily: 'Roboto',
// // // // // // // //               textTheme: TextTheme(
// // // // // // // //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// // // // // // // //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// // // // // // // //                 bodyLarge: TextStyle(fontSize: 16.sp),
// // // // // // // //               ),
// // // // // // // //               elevatedButtonTheme: ElevatedButtonThemeData(
// // // // // // // //                 style: ElevatedButton.styleFrom(
// // // // // // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// // // // // // // //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// // // // // // // //           ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // // class Player {
// // // // // // // //   String name;
// // // // // // // //   int seconds;
// // // // // // // //   int originalSeconds;
// // // // // // // //   Color color;
// // // // // // // //   bool isCompleted;
// // // // // // // //   int elapsedSeconds = 0;

// // // // // // // //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// // // // // // // //     : originalSeconds = seconds;

// // // // // // // //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// // // // // // // //   static Player fromJson(Map<String, dynamic> json) =>
// // // // // // // //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // // // // // // // }

// // // // // // // // class PlayerSetupScreen extends StatefulWidget {
// // // // // // // //   final String? lastUsedPreset;
// // // // // // // //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// // // // // // // //   @override
// // // // // // // //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // // // // // // // }

// // // // // // // // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// // // // // // // //   final List<Player> players = [];
// // // // // // // //   final List<TextEditingController> nameControllers = [];
// // // // // // // //   String? currentPresetName;

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     if (widget.lastUsedPreset != null) {
// // // // // // // //       currentPresetName = widget.lastUsedPreset;
// // // // // // // //       loadPreset(widget.lastUsedPreset!, autoLoad: true);
// // // // // // // //     } else {
// // // // // // // //       initializePlayers(2);
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   void initializePlayers(int count) {
// // // // // // // //     players.clear();
// // // // // // // //     nameControllers.clear();
// // // // // // // //     for (int i = 0; i < count; i++) {
// // // // // // // //       players.add(Player(name: 'Player ${i + 1}', seconds: 600, color: Colors.blue));
// // // // // // // //       nameControllers.add(TextEditingController(text: 'Player ${i + 1}'));
// // // // // // // //     }
// // // // // // // //     setState(() {});
// // // // // // // //   }

// // // // // // // //   void addPlayer() {
// // // // // // // //     final newIndex = players.length;
// // // // // // // //     players.add(Player(name: 'Player ${newIndex + 1}', seconds: 600, color: Colors.blue));
// // // // // // // //     nameControllers.add(TextEditingController(text: 'Player ${newIndex + 1}'));
// // // // // // // //     setState(() {});
// // // // // // // //   }

// // // // // // // //   void removePlayer(int index) {
// // // // // // // //     players.removeAt(index);
// // // // // // // //     nameControllers.removeAt(index);
// // // // // // // //     setState(() {});
// // // // // // // //   }

// // // // // // // //   Future<void> saveCurrentSettings(String presetName) async {
// // // // // // // //     if (presetName.isEmpty) return;
// // // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // // //     final encoded = players.map((p) => p.toJson()).toList();
// // // // // // // //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// // // // // // // //     await prefs.setString('last_used_preset', presetName);
// // // // // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // // // // //     if (!names.contains(presetName)) {
// // // // // // // //       names.add(presetName);
// // // // // // // //       await prefs.setStringList('preset_names', names);
// // // // // // // //     }
// // // // // // // //     setState(() {
// // // // // // // //       currentPresetName = presetName;
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   Future<void> deletePreset(String presetName) async {
// // // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // // //     await prefs.remove('preset_$presetName');
// // // // // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // // // // //     names.remove(presetName);
// // // // // // // //     await prefs.setStringList('preset_names', names);
// // // // // // // //     final lastUsed = prefs.getString('last_used_preset');
// // // // // // // //     if (lastUsed == presetName) {
// // // // // // // //       await prefs.remove('last_used_preset');
// // // // // // // //       setState(() {
// // // // // // // //         currentPresetName = null;
// // // // // // // //       });
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// // // // // // // //     try {
// // // // // // // //       final prefs = await SharedPreferences.getInstance();
// // // // // // // //       final jsonString = prefs.getString('preset_$presetName');
// // // // // // // //       if (jsonString == null) return;
// // // // // // // //       final List decoded = jsonDecode(jsonString);
// // // // // // // //       players.clear();
// // // // // // // //       nameControllers.clear();
// // // // // // // //       for (var p in decoded) {
// // // // // // // //         final player = Player.fromJson(p);
// // // // // // // //         players.add(player);
// // // // // // // //         nameControllers.add(TextEditingController(text: player.name));
// // // // // // // //       }
// // // // // // // //       setState(() {
// // // // // // // //         currentPresetName = presetName;
// // // // // // // //       });
// // // // // // // //       if (!autoLoad) {
// // // // // // // //         await prefs.setString('last_used_preset', presetName);
// // // // // // // //       }
// // // // // // // //     } catch (_) {
// // // // // // // //       ScaffoldMessenger.of(
// // // // // // // //         context,
// // // // // // // //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// // // // // // // //     }
// // // // // // // //   }

// // // // // // // //   void showSaveDialog() async {
// // // // // // // //     final controller = TextEditingController();
// // // // // // // //     await showDialog(
// // // // // // // //       context: context,
// // // // // // // //       builder:
// // // // // // // //           (ctx) => AlertDialog(
// // // // // // // //             title: const Text("설정 이름 저장"),
// // // // // // // //             content: TextField(
// // // // // // // //               controller: controller,
// // // // // // // //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// // // // // // // //             ),
// // // // // // // //             actions: [
// // // // // // // //               TextButton(
// // // // // // // //                 onPressed: () async {
// // // // // // // //                   await saveCurrentSettings(controller.text.trim());
// // // // // // // //                   Navigator.of(ctx).pop();
// // // // // // // //                 },
// // // // // // // //                 child: const Text("저장"),
// // // // // // // //               ),
// // // // // // // //             ],
// // // // // // // //           ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   void showLoadDialog() async {
// // // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // // //     final presetNames = prefs.getStringList('preset_names') ?? [];
// // // // // // // //     if (presetNames.isEmpty) {
// // // // // // // //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// // // // // // // //       return;
// // // // // // // //     }
// // // // // // // //     await showDialog(
// // // // // // // //       context: context,
// // // // // // // //       builder:
// // // // // // // //           (ctx) => AlertDialog(
// // // // // // // //             title: const Text("불러올 설정 선택"),
// // // // // // // //             content: SingleChildScrollView(
// // // // // // // //               child: Column(
// // // // // // // //                 mainAxisSize: MainAxisSize.min,
// // // // // // // //                 children:
// // // // // // // //                     presetNames.map((name) {
// // // // // // // //                       return ListTile(
// // // // // // // //                         title: Text(name),
// // // // // // // //                         trailing: IconButton(
// // // // // // // //                           icon: const Icon(Icons.delete, color: Colors.red),
// // // // // // // //                           onPressed: () async {
// // // // // // // //                             Navigator.of(ctx).pop();
// // // // // // // //                             await deletePreset(name);
// // // // // // // //                           },
// // // // // // // //                         ),
// // // // // // // //                         onTap: () async {
// // // // // // // //                           Navigator.of(ctx).pop();
// // // // // // // //                           await loadPreset(name);
// // // // // // // //                         },
// // // // // // // //                       );
// // // // // // // //                     }).toList(),
// // // // // // // //               ),
// // // // // // // //             ),
// // // // // // // //           ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   void clearAllSettings() async {
// // // // // // // //     initializePlayers(2);
// // // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // // //     await prefs.remove('last_used_preset');
// // // // // // // //     setState(() {
// // // // // // // //       currentPresetName = null;
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     return Scaffold(
// // // // // // // //       body: SafeArea(
// // // // // // // //         child: Padding(
// // // // // // // //           padding: EdgeInsets.all(24.w),
// // // // // // // //           child: Column(
// // // // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // //             children: [
// // // // // // // //               SizedBox(height: 40.h),
// // // // // // // //               Text(
// // // // // // // //                 'TimeSquad',
// // // // // // // //                 style: TextStyle(
// // // // // // // //                   fontSize: 36.sp,
// // // // // // // //                   fontWeight: FontWeight.w800,
// // // // // // // //                   letterSpacing: 1.2,
// // // // // // // //                   color: Colors.black87,
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //               SizedBox(height: 4.h),
// // // // // // // //               Row(
// // // // // // // //                 children: [
// // // // // // // //                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
// // // // // // // //                   const Spacer(),
// // // // // // // //                   Row(
// // // // // // // //                     mainAxisSize: MainAxisSize.min,
// // // // // // // //                     children: [
// // // // // // // //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// // // // // // // //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// // // // // // // //                       IconButton(
// // // // // // // //                         icon: const Icon(FeatherIcons.rotateCcw),
// // // // // // // //                         onPressed: clearAllSettings,
// // // // // // // //                       ),
// // // // // // // //                     ],
// // // // // // // //                   ),
// // // // // // // //                 ],
// // // // // // // //               ),
// // // // // // // //               SizedBox(height: 24.h),
// // // // // // // //               Expanded(
// // // // // // // //                 child: ReorderableListView.builder(
// // // // // // // //                   padding: EdgeInsets.only(bottom: 120.h),
// // // // // // // //                   buildDefaultDragHandles: false,
// // // // // // // //                   proxyDecorator: (child, index, animation) {
// // // // // // // //                     final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// // // // // // // //                     return ScaleTransition(
// // // // // // // //                       scale: scale,
// // // // // // // //                       child: Material(
// // // // // // // //                         elevation: 0,
// // // // // // // //                         shadowColor: Colors.transparent,
// // // // // // // //                         color: Colors.transparent,
// // // // // // // //                         child: child,
// // // // // // // //                       ),
// // // // // // // //                     );
// // // // // // // //                   },
// // // // // // // //                   itemCount: players.length,
// // // // // // // //                   onReorder: (oldIndex, newIndex) {
// // // // // // // //                     setState(() {
// // // // // // // //                       if (newIndex > oldIndex) newIndex--;
// // // // // // // //                       final player = players.removeAt(oldIndex);
// // // // // // // //                       final controller = nameControllers.removeAt(oldIndex);
// // // // // // // //                       players.insert(newIndex, player);
// // // // // // // //                       nameControllers.insert(newIndex, controller);
// // // // // // // //                     });
// // // // // // // //                   },
// // // // // // // //                   itemBuilder: (context, index) {
// // // // // // // //                     final player = players.elementAt(index);
// // // // // // // //                     const double borderRadius = 20.0;

// // // // // // // //                     return ReorderableDelayedDragStartListener(
// // // // // // // //                       key: ValueKey(player),
// // // // // // // //                       index: index,
// // // // // // // //                       child: Padding(
// // // // // // // //                         padding: EdgeInsets.only(bottom: 12.h),
// // // // // // // //                         child: Container(
// // // // // // // //                           margin: EdgeInsets.zero,
// // // // // // // //                           decoration: BoxDecoration(
// // // // // // // //                             color: Color.lerp(Colors.white, player.color, 0.2),
// // // // // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // // // //                           ),
// // // // // // // //                           clipBehavior: Clip.antiAlias, // Clip children to the border radius
// // // // // // // //                           child: Dismissible(
// // // // // // // //                             key: ValueKey(player),
// // // // // // // //                             direction: DismissDirection.horizontal,
// // // // // // // //                             // 왼쪽으로 스와이프할 때 배경 (왼쪽에서 나타남)
// // // // // // // //                             background: ClipRRect(
// // // // // // // //                               borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // // // //                               child: Container(
// // // // // // // //                                 alignment: Alignment.centerLeft,
// // // // // // // //                                 padding: EdgeInsets.only(left: 20.w),
// // // // // // // //                                 color: Colors.white, // 흰색 배경으로 변경
// // // // // // // //                                 child: Icon(
// // // // // // // //                                   Icons.delete,
// // // // // // // //                                   color: Colors.red,
// // // // // // // //                                   size: 30.sp,
// // // // // // // //                                 ), // 빨간색 삭제 아이콘
// // // // // // // //                               ),
// // // // // // // //                             ),
// // // // // // // //                             // 오른쪽으로 스와이프할 때 배경 (오른쪽에서 나타남)
// // // // // // // //                             secondaryBackground: ClipRRect(
// // // // // // // //                               borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // // // //                               child: Container(
// // // // // // // //                                 alignment: Alignment.centerRight,
// // // // // // // //                                 padding: EdgeInsets.only(right: 20.w),
// // // // // // // //                                 color: Colors.white, // 흰색 배경으로 변경
// // // // // // // //                                 child: Icon(
// // // // // // // //                                   Icons.delete,
// // // // // // // //                                   color: Colors.red,
// // // // // // // //                                   size: 30.sp,
// // // // // // // //                                 ), // 빨간색 삭제 아이콘
// // // // // // // //                               ),
// // // // // // // //                             ),
// // // // // // // //                             onDismissed: (_) {
// // // // // // // //                               setState(() {
// // // // // // // //                                 players.remove(player);
// // // // // // // //                                 nameControllers.removeAt(index);
// // // // // // // //                               });
// // // // // // // //                             },
// // // // // // // //                             child: Container(
// // // // // // // //                               padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// // // // // // // //                               child: Row(
// // // // // // // //                                 children: [
// // // // // // // //                                   Container(
// // // // // // // //                                     width: 40.w,
// // // // // // // //                                     height: 40.w,
// // // // // // // //                                     alignment: Alignment.center,
// // // // // // // //                                     decoration: BoxDecoration(
// // // // // // // //                                       color: Colors.white,
// // // // // // // //                                       borderRadius: BorderRadius.circular(12.r),
// // // // // // // //                                     ),
// // // // // // // //                                     child: Text(
// // // // // // // //                                       '${index + 1}',
// // // // // // // //                                       style: TextStyle(
// // // // // // // //                                         fontSize: 18.sp,
// // // // // // // //                                         fontWeight: FontWeight.bold,
// // // // // // // //                                       ),
// // // // // // // //                                     ),
// // // // // // // //                                   ),
// // // // // // // //                                   SizedBox(width: 12.w),
// // // // // // // //                                   Expanded(
// // // // // // // //                                     child: Column(
// // // // // // // //                                       crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // // //                                       children: [
// // // // // // // //                                         Container(
// // // // // // // //                                           decoration: BoxDecoration(
// // // // // // // //                                             color: Colors.white.withOpacity(0.6),
// // // // // // // //                                             borderRadius: BorderRadius.circular(8.r),
// // // // // // // //                                           ),
// // // // // // // //                                           padding: EdgeInsets.symmetric(
// // // // // // // //                                             horizontal: 8.w,
// // // // // // // //                                             vertical: 4.h,
// // // // // // // //                                           ),
// // // // // // // //                                           child: TextField(
// // // // // // // //                                             controller: nameControllers.elementAt(index),
// // // // // // // //                                             onChanged: (val) => players.elementAt(index).name = val,
// // // // // // // //                                             style: TextStyle(
// // // // // // // //                                               fontSize: 16.sp,
// // // // // // // //                                               fontWeight: FontWeight.w500,
// // // // // // // //                                             ),
// // // // // // // //                                             decoration: const InputDecoration.collapsed(
// // // // // // // //                                               hintText: 'Enter name',
// // // // // // // //                                             ),
// // // // // // // //                                           ),
// // // // // // // //                                         ),
// // // // // // // //                                         SizedBox(height: 8.h),
// // // // // // // //                                         GestureDetector(
// // // // // // // //                                           onTap: () async {
// // // // // // // //                                             Duration selectedDuration = Duration(
// // // // // // // //                                               seconds: players.elementAt(index).originalSeconds,
// // // // // // // //                                             );
// // // // // // // //                                             await showModalBottomSheet(
// // // // // // // //                                               context: context,
// // // // // // // //                                               builder:
// // // // // // // //                                                   (context) => SizedBox(
// // // // // // // //                                                     height: 200,
// // // // // // // //                                                     child: CupertinoTimerPicker(
// // // // // // // //                                                       mode: CupertinoTimerPickerMode.hms,
// // // // // // // //                                                       initialTimerDuration: selectedDuration,
// // // // // // // //                                                       onTimerDurationChanged: (
// // // // // // // //                                                         Duration newDuration,
// // // // // // // //                                                       ) {
// // // // // // // //                                                         setState(() {
// // // // // // // //                                                           players.elementAt(index).seconds =
// // // // // // // //                                                               newDuration.inSeconds;
// // // // // // // //                                                           players.elementAt(index).originalSeconds =
// // // // // // // //                                                               newDuration.inSeconds;
// // // // // // // //                                                         });
// // // // // // // //                                                       },
// // // // // // // //                                                     ),
// // // // // // // //                                                   ),
// // // // // // // //                                             );
// // // // // // // //                                           },
// // // // // // // //                                           child: Container(
// // // // // // // //                                             decoration: BoxDecoration(
// // // // // // // //                                               color: Colors.white.withOpacity(0.6),
// // // // // // // //                                               borderRadius: BorderRadius.circular(8.r),
// // // // // // // //                                             ),
// // // // // // // //                                             padding: EdgeInsets.symmetric(
// // // // // // // //                                               horizontal: 12.w,
// // // // // // // //                                               vertical: 10.h,
// // // // // // // //                                             ),
// // // // // // // //                                             child: Text(
// // // // // // // //                                               'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// // // // // // // //                                               style: TextStyle(
// // // // // // // //                                                 fontSize: 16.sp,
// // // // // // // //                                                 fontWeight: FontWeight.w500,
// // // // // // // //                                               ),
// // // // // // // //                                             ),
// // // // // // // //                                           ),
// // // // // // // //                                         ),
// // // // // // // //                                       ],
// // // // // // // //                                     ),
// // // // // // // //                                   ),
// // // // // // // //                                   SizedBox(width: 8.w),
// // // // // // // //                                   ElevatedButton(
// // // // // // // //                                     onPressed: () async {
// // // // // // // //                                       FocusScope.of(context).unfocus();
// // // // // // // //                                       final color = await showDialog<Color>(
// // // // // // // //                                         context: context,
// // // // // // // //                                         builder:
// // // // // // // //                                             (context) => AlertDialog(
// // // // // // // //                                               title: const Text('Select Color'),
// // // // // // // //                                               content: Wrap(
// // // // // // // //                                                 spacing: 8.w,
// // // // // // // //                                                 children:
// // // // // // // //                                                     Colors.primaries.map((c) {
// // // // // // // //                                                       return GestureDetector(
// // // // // // // //                                                         onTap: () => Navigator.pop(context, c),
// // // // // // // //                                                         child: Container(
// // // // // // // //                                                           width: 30.w,
// // // // // // // //                                                           height: 30.w,
// // // // // // // //                                                           decoration: BoxDecoration(
// // // // // // // //                                                             color: c,
// // // // // // // //                                                             borderRadius: BorderRadius.circular(
// // // // // // // //                                                               15.r,
// // // // // // // //                                                             ),
// // // // // // // //                                                           ),
// // // // // // // //                                                         ),
// // // // // // // //                                                       );
// // // // // // // //                                                     }).toList(),
// // // // // // // //                                               ),
// // // // // // // //                                             ),
// // // // // // // //                                       );
// // // // // // // //                                       if (color != null) {
// // // // // // // //                                         setState(() => players.elementAt(index).color = color);
// // // // // // // //                                       }
// // // // // // // //                                     },
// // // // // // // //                                     style: ElevatedButton.styleFrom(
// // // // // // // //                                       backgroundColor: player.color,
// // // // // // // //                                       foregroundColor: Colors.white,
// // // // // // // //                                       shape: RoundedRectangleBorder(
// // // // // // // //                                         borderRadius: BorderRadius.circular(12.r),
// // // // // // // //                                       ),
// // // // // // // //                                     ),
// // // // // // // //                                     child: const Text('Color'),
// // // // // // // //                                   ),
// // // // // // // //                                 ],
// // // // // // // //                               ),
// // // // // // // //                             ),
// // // // // // // //                           ),
// // // // // // // //                         ),
// // // // // // // //                       ),
// // // // // // // //                     );
// // // // // // // //                   },
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //             ],
// // // // // // // //           ),
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// // // // // // // //       floatingActionButton: Padding(
// // // // // // // //         padding: EdgeInsets.only(bottom: 16.h),
// // // // // // // //         child: Row(
// // // // // // // //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // // // //           children: [
// // // // // // // //             FloatingActionButton.extended(
// // // // // // // //               heroTag: 'addPlayerBtn',
// // // // // // // //               onPressed: addPlayer,
// // // // // // // //               icon: const Icon(Icons.person_add, color: Colors.white),
// // // // // // // //               label: const Text('추가', style: TextStyle(color: Colors.white)),
// // // // // // // //               backgroundColor: Colors.indigo,
// // // // // // // //             ),
// // // // // // // //             FloatingActionButton.extended(
// // // // // // // //               heroTag: 'startBtn',
// // // // // // // //               onPressed: () {
// // // // // // // //                 if (players.every((p) => p.name.isNotEmpty)) {
// // // // // // // //                   Navigator.push(
// // // // // // // //                     context,
// // // // // // // //                     MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// // // // // // // //                   );
// // // // // // // //                 } else {
// // // // // // // //                   ScaffoldMessenger.of(
// // // // // // // //                     context,
// // // // // // // //                   ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름을 입력해주세요.")));
// // // // // // // //                 }
// // // // // // // //               },
// // // // // // // //               icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// // // // // // // //               label: const Text('시작', style: TextStyle(color: Colors.white)),
// // // // // // // //               backgroundColor: Colors.teal,
// // // // // // // //             ),
// // // // // // // //           ],
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // // class TimerScreen extends StatefulWidget {
// // // // // // // //   final List<Player> players;
// // // // // // // //   const TimerScreen({super.key, required this.players});

// // // // // // // //   @override
// // // // // // // //   State<TimerScreen> createState() => _TimerScreenState();
// // // // // // // // }

// // // // // // // // class _TimerScreenState extends State<TimerScreen> {
// // // // // // // //   Timer? _timer;
// // // // // // // //   int currentIndex = 0;

// // // // // // // //   @override
// // // // // // // //   void initState() {
// // // // // // // //     super.initState();
// // // // // // // //     startTimer();
// // // // // // // //   }

// // // // // // // //   void startTimer() {
// // // // // // // //     _timer?.cancel();
// // // // // // // //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// // // // // // // //       setState(() {
// // // // // // // //         final player = widget.players.elementAt(currentIndex);
// // // // // // // //         if (player.seconds > 0) {
// // // // // // // //           player.seconds--;
// // // // // // // //           player.elapsedSeconds++;
// // // // // // // //         } else {
// // // // // // // //           player.isCompleted = true;
// // // // // // // //           switchToNextPlayer();
// // // // // // // //         }
// // // // // // // //       });
// // // // // // // //     });
// // // // // // // //   }

// // // // // // // //   void pauseTimer() {
// // // // // // // //     _timer?.cancel();
// // // // // // // //   }

// // // // // // // //   void switchToNextPlayer() {
// // // // // // // //     pauseTimer();
// // // // // // // //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// // // // // // // //       showSummaryDialog();
// // // // // // // //       return;
// // // // // // // //     }
// // // // // // // //     do {
// // // // // // // //       currentIndex = (currentIndex + 1) % widget.players.length;
// // // // // // // //     } while (widget.players.elementAt(currentIndex).isCompleted);
// // // // // // // //     startTimer();
// // // // // // // //   }

// // // // // // // //   void resetAll() {
// // // // // // // //     for (var p in widget.players) {
// // // // // // // //       p.seconds = p.originalSeconds;
// // // // // // // //       p.elapsedSeconds = 0;
// // // // // // // //       p.isCompleted = false;
// // // // // // // //     }
// // // // // // // //     setState(() {
// // // // // // // //       currentIndex = 0;
// // // // // // // //     });
// // // // // // // //     startTimer();
// // // // // // // //   }

// // // // // // // //   String formatDuration(int seconds) {
// // // // // // // //     final d = Duration(seconds: seconds);
// // // // // // // //     final hours = d.inHours.toString().padLeft(2, '0');
// // // // // // // //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// // // // // // // //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// // // // // // // //     return '$hours:$minutes:$secs';
// // // // // // // //   }

// // // // // // // //   void showSummaryDialog() {
// // // // // // // //     _timer?.cancel();
// // // // // // // //     showDialog(
// // // // // // // //       context: context,
// // // // // // // //       builder:
// // // // // // // //           (_) => AlertDialog(
// // // // // // // //             title: const Text('Round Complete'),
// // // // // // // //             content: Column(
// // // // // // // //               mainAxisSize: MainAxisSize.min,
// // // // // // // //               children:
// // // // // // // //                   widget.players.map((p) {
// // // // // // // //                     final formatted = formatDuration(p.elapsedSeconds);
// // // // // // // //                     return Text('${p.name} ⏱ $formatted');
// // // // // // // //                   }).toList(),
// // // // // // // //             ),
// // // // // // // //             actions: [
// // // // // // // //               TextButton(
// // // // // // // //                 onPressed: () {
// // // // // // // //                   Navigator.of(context).pop();
// // // // // // // //                   resetAll();
// // // // // // // //                 },
// // // // // // // //                 child: const Text('Next Round'),
// // // // // // // //               ),
// // // // // // // //               TextButton(
// // // // // // // //                 onPressed: () {
// // // // // // // //                   resetAll();
// // // // // // // //                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // // // //                 },
// // // // // // // //                 child: const Text('Home'),
// // // // // // // //               ),
// // // // // // // //             ],
// // // // // // // //           ),
// // // // // // // //     );
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   void dispose() {
// // // // // // // //     _timer?.cancel();
// // // // // // // //     super.dispose();
// // // // // // // //   }

// // // // // // // //   @override
// // // // // // // //   Widget build(BuildContext context) {
// // // // // // // //     final player = widget.players.elementAt(currentIndex);
// // // // // // // //     return Scaffold(
// // // // // // // //       backgroundColor: player.color,
// // // // // // // //       body: SafeArea(
// // // // // // // //         child: GestureDetector(
// // // // // // // //           behavior: HitTestBehavior.opaque,
// // // // // // // //           onTap: () {
// // // // // // // //             setState(() {
// // // // // // // //               pauseTimer();
// // // // // // // //               switchToNextPlayer();
// // // // // // // //             });
// // // // // // // //           },
// // // // // // // //           child: Stack(
// // // // // // // //             children: [
// // // // // // // //               Center(
// // // // // // // //                 child: Column(
// // // // // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // // // //                   children: [
// // // // // // // //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// // // // // // // //                     SizedBox(height: 16.h),
// // // // // // // //                     Text(
// // // // // // // //                       formatDuration(player.seconds),
// // // // // // // //                       style: TextStyle(
// // // // // // // //                         fontSize: 64.sp,
// // // // // // // //                         fontWeight: FontWeight.bold,
// // // // // // // //                         color: Colors.white,
// // // // // // // //                       ),
// // // // // // // //                     ),
// // // // // // // //                     SizedBox(height: 24.h),
// // // // // // // //                     ElevatedButton(
// // // // // // // //                       onPressed: () {
// // // // // // // //                         setState(() {
// // // // // // // //                           widget.players.elementAt(currentIndex).isCompleted = true;
// // // // // // // //                           pauseTimer();
// // // // // // // //                           switchToNextPlayer();
// // // // // // // //                         });
// // // // // // // //                       },
// // // // // // // //                       child: const Text('Complete'),
// // // // // // // //                     ),
// // // // // // // //                     SizedBox(height: 12.h),
// // // // // // // //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// // // // // // // //                   ],
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //               Positioned(
// // // // // // // //                 top: 20.h,
// // // // // // // //                 right: 20.w,
// // // // // // // //                 child: IconButton(
// // // // // // // //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// // // // // // // //                   onPressed: () {
// // // // // // // //                     pauseTimer();
// // // // // // // //                     showDialog(
// // // // // // // //                       context: context,
// // // // // // // //                       builder:
// // // // // // // //                           (context) => AlertDialog(
// // // // // // // //                             title: const Text('홈으로 이동'),
// // // // // // // //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// // // // // // // //                             actions: [
// // // // // // // //                               TextButton(
// // // // // // // //                                 onPressed: () {
// // // // // // // //                                   Navigator.of(context).pop();
// // // // // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // // // //                                 },
// // // // // // // //                                 child: const Text('설정 유지'),
// // // // // // // //                               ),
// // // // // // // //                               TextButton(
// // // // // // // //                                 onPressed: () {
// // // // // // // //                                   resetAll();
// // // // // // // //                                   Navigator.of(context).pop();
// // // // // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // // // //                                 },
// // // // // // // //                                 child: const Text('초기화 후 이동'),
// // // // // // // //                               ),
// // // // // // // //                             ],
// // // // // // // //                           ),
// // // // // // // //                     );
// // // // // // // //                   },
// // // // // // // //                 ),
// // // // // // // //               ),
// // // // // // // //             ],
// // // // // // // //           ),
// // // // // // // //         ),
// // // // // // // //       ),
// // // // // // // //     );
// // // // // // // //   }
// // // // // // // // }

// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // // // // // import 'package:flutter/cupertino.dart';
// // // // // // // import 'dart:async';
// // // // // // // import 'dart:convert';
// // // // // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // // // // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // // // // // // void main() async {
// // // // // // //   WidgetsFlutterBinding.ensureInitialized();
// // // // // // //   final prefs = await SharedPreferences.getInstance();
// // // // // // //   final lastUsed = prefs.getString('last_used_preset');
// // // // // // //   runApp(MyApp(lastUsedPreset: lastUsed));
// // // // // // // }

// // // // // // // class MyApp extends StatelessWidget {
// // // // // // //   final String? lastUsedPreset;
// // // // // // //   const MyApp({super.key, this.lastUsedPreset});

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return ScreenUtilInit(
// // // // // // //       designSize: const Size(390, 844),
// // // // // // //       builder:
// // // // // // //           (context, child) => MaterialApp(
// // // // // // //             debugShowCheckedModeBanner: false,
// // // // // // //             title: 'Multi Player Timer',
// // // // // // //             theme: ThemeData(
// // // // // // //               scaffoldBackgroundColor: Colors.white,
// // // // // // //               fontFamily: 'Roboto',
// // // // // // //               textTheme: TextTheme(
// // // // // // //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// // // // // // //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// // // // // // //                 bodyLarge: TextStyle(fontSize: 16.sp),
// // // // // // //               ),
// // // // // // //               elevatedButtonTheme: ElevatedButtonThemeData(
// // // // // // //                 style: ElevatedButton.styleFrom(
// // // // // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// // // // // // //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// // // // // // //           ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // class Player {
// // // // // // //   String name;
// // // // // // //   int seconds;
// // // // // // //   int originalSeconds;
// // // // // // //   Color color;
// // // // // // //   bool isCompleted;
// // // // // // //   int elapsedSeconds = 0;

// // // // // // //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// // // // // // //     : originalSeconds = seconds;

// // // // // // //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// // // // // // //   static Player fromJson(Map<String, dynamic> json) =>
// // // // // // //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // // // // // // }

// // // // // // // class PlayerSetupScreen extends StatefulWidget {
// // // // // // //   final String? lastUsedPreset;
// // // // // // //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// // // // // // //   @override
// // // // // // //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // // // // // // }

// // // // // // // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// // // // // // //   final List<Player> players = [];
// // // // // // //   final List<TextEditingController> nameControllers = [];
// // // // // // //   String? currentPresetName;

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     if (widget.lastUsedPreset != null) {
// // // // // // //       currentPresetName = widget.lastUsedPreset;
// // // // // // //       loadPreset(widget.lastUsedPreset!, autoLoad: true);
// // // // // // //     } else {
// // // // // // //       initializePlayers(2);
// // // // // // //     }
// // // // // // //   }

// // // // // // //   void initializePlayers(int count) {
// // // // // // //     players.clear();
// // // // // // //     nameControllers.clear();
// // // // // // //     for (int i = 0; i < count; i++) {
// // // // // // //       players.add(Player(name: 'Player ${i + 1}', seconds: 600, color: Colors.blue));
// // // // // // //       nameControllers.add(TextEditingController(text: 'Player ${i + 1}'));
// // // // // // //     }
// // // // // // //     setState(() {});
// // // // // // //   }

// // // // // // //   void addPlayer() {
// // // // // // //     final newIndex = players.length;
// // // // // // //     players.add(Player(name: 'Player ${newIndex + 1}', seconds: 600, color: Colors.blue));
// // // // // // //     nameControllers.add(TextEditingController(text: 'Player ${newIndex + 1}'));
// // // // // // //     setState(() {});
// // // // // // //   }

// // // // // // //   void removePlayer(int index) {
// // // // // // //     players.removeAt(index);
// // // // // // //     nameControllers.removeAt(index);
// // // // // // //     setState(() {});
// // // // // // //   }

// // // // // // //   Future<void> saveCurrentSettings(String presetName) async {
// // // // // // //     if (presetName.isEmpty) return;
// // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // //     final encoded = players.map((p) => p.toJson()).toList();
// // // // // // //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// // // // // // //     await prefs.setString('last_used_preset', presetName);
// // // // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // // // //     if (!names.contains(presetName)) {
// // // // // // //       names.add(presetName);
// // // // // // //       await prefs.setStringList('preset_names', names);
// // // // // // //     }
// // // // // // //     setState(() {
// // // // // // //       currentPresetName = presetName;
// // // // // // //     });
// // // // // // //   }

// // // // // // //   Future<void> deletePreset(String presetName) async {
// // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // //     await prefs.remove('preset_$presetName');
// // // // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // // // //     names.remove(presetName);
// // // // // // //     await prefs.setStringList('preset_names', names);
// // // // // // //     final lastUsed = prefs.getString('last_used_preset');
// // // // // // //     if (lastUsed == presetName) {
// // // // // // //       await prefs.remove('last_used_preset');
// // // // // // //       setState(() {
// // // // // // //         currentPresetName = null;
// // // // // // //       });
// // // // // // //     }
// // // // // // //   }

// // // // // // //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// // // // // // //     try {
// // // // // // //       final prefs = await SharedPreferences.getInstance();
// // // // // // //       final jsonString = prefs.getString('preset_$presetName');
// // // // // // //       if (jsonString == null) return;
// // // // // // //       final List decoded = jsonDecode(jsonString);
// // // // // // //       players.clear();
// // // // // // //       nameControllers.clear();
// // // // // // //       for (var p in decoded) {
// // // // // // //         final player = Player.fromJson(p);
// // // // // // //         players.add(player);
// // // // // // //         nameControllers.add(TextEditingController(text: player.name));
// // // // // // //       }
// // // // // // //       setState(() {
// // // // // // //         currentPresetName = presetName;
// // // // // // //       });
// // // // // // //       if (!autoLoad) {
// // // // // // //         await prefs.setString('last_used_preset', presetName);
// // // // // // //       }
// // // // // // //     } catch (_) {
// // // // // // //       ScaffoldMessenger.of(
// // // // // // //         context,
// // // // // // //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// // // // // // //     }
// // // // // // //   }

// // // // // // //   void showSaveDialog() async {
// // // // // // //     final controller = TextEditingController();
// // // // // // //     await showDialog(
// // // // // // //       context: context,
// // // // // // //       builder:
// // // // // // //           (ctx) => AlertDialog(
// // // // // // //             title: const Text("설정 이름 저장"),
// // // // // // //             content: TextField(
// // // // // // //               controller: controller,
// // // // // // //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// // // // // // //             ),
// // // // // // //             actions: [
// // // // // // //               TextButton(
// // // // // // //                 onPressed: () async {
// // // // // // //                   await saveCurrentSettings(controller.text.trim());
// // // // // // //                   Navigator.of(ctx).pop();
// // // // // // //                 },
// // // // // // //                 child: const Text("저장"),
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   void showLoadDialog() async {
// // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // //     final presetNames = prefs.getStringList('preset_names') ?? [];
// // // // // // //     if (presetNames.isEmpty) {
// // // // // // //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// // // // // // //       return;
// // // // // // //     }
// // // // // // //     await showDialog(
// // // // // // //       context: context,
// // // // // // //       builder:
// // // // // // //           (ctx) => AlertDialog(
// // // // // // //             title: const Text("불러올 설정 선택"),
// // // // // // //             content: SingleChildScrollView(
// // // // // // //               child: Column(
// // // // // // //                 mainAxisSize: MainAxisSize.min,
// // // // // // //                 children:
// // // // // // //                     presetNames.map((name) {
// // // // // // //                       return ListTile(
// // // // // // //                         title: Text(name),
// // // // // // //                         trailing: IconButton(
// // // // // // //                           icon: const Icon(Icons.delete, color: Colors.red),
// // // // // // //                           onPressed: () async {
// // // // // // //                             Navigator.of(ctx).pop();
// // // // // // //                             await deletePreset(name);
// // // // // // //                           },
// // // // // // //                         ),
// // // // // // //                         onTap: () async {
// // // // // // //                           Navigator.of(ctx).pop();
// // // // // // //                           await loadPreset(name);
// // // // // // //                         },
// // // // // // //                       );
// // // // // // //                     }).toList(),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   void clearAllSettings() async {
// // // // // // //     initializePlayers(2);
// // // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // // //     await prefs.remove('last_used_preset');
// // // // // // //     setState(() {
// // // // // // //       currentPresetName = null;
// // // // // // //     });
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return Scaffold(
// // // // // // //       appBar: AppBar(
// // // // // // //         title: Text(
// // // // // // //           'TimeSquad',
// // // // // // //           style: TextStyle(
// // // // // // //             fontSize: 22.sp, // 폰트 크기 조정
// // // // // // //             fontWeight: FontWeight.w600, // 세미 볼드
// // // // // // //             letterSpacing: 0.8, // 자간 조정
// // // // // // //             color: Colors.black87,
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //         backgroundColor: Colors.white, // AppBar 배경색 흰색으로 통일
// // // // // // //         elevation: 0, // AppBar 아래 그림자 제거
// // // // // // //         scrolledUnderElevation: 0.0, // 스크롤 시에도 그림자 제거 (배경색 변경 방지)
// // // // // // //         toolbarHeight: 60.h, // AppBar 높이 조정
// // // // // // //       ),
// // // // // // //       body: SafeArea(
// // // // // // //         child: SingleChildScrollView(
// // // // // // //           padding: EdgeInsets.all(24.w),
// // // // // // //           child: Column(
// // // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //             children: [
// // // // // // //               Row(
// // // // // // //                 children: [
// // // // // // //                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
// // // // // // //                   const Spacer(),
// // // // // // //                   Row(
// // // // // // //                     mainAxisSize: MainAxisSize.min,
// // // // // // //                     children: [
// // // // // // //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// // // // // // //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// // // // // // //                       IconButton(
// // // // // // //                         icon: const Icon(FeatherIcons.rotateCcw),
// // // // // // //                         onPressed: clearAllSettings,
// // // // // // //                       ),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                 ],
// // // // // // //               ),
// // // // // // //               SizedBox(height: 24.h),
// // // // // // //               ReorderableListView.builder(
// // // // // // //                 shrinkWrap: true,
// // // // // // //                 physics: const NeverScrollableScrollPhysics(),
// // // // // // //                 padding: EdgeInsets.only(bottom: 120.h),
// // // // // // //                 buildDefaultDragHandles: false,
// // // // // // //                 proxyDecorator: (child, index, animation) {
// // // // // // //                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// // // // // // //                   return ScaleTransition(
// // // // // // //                     scale: scale,
// // // // // // //                     child: Material(
// // // // // // //                       elevation: 0,
// // // // // // //                       shadowColor: Colors.transparent,
// // // // // // //                       color: Colors.transparent,
// // // // // // //                       child: child,
// // // // // // //                     ),
// // // // // // //                   );
// // // // // // //                 },
// // // // // // //                 itemCount: players.length,
// // // // // // //                 onReorder: (oldIndex, newIndex) {
// // // // // // //                   setState(() {
// // // // // // //                     if (newIndex > oldIndex) newIndex--;
// // // // // // //                     final player = players.removeAt(oldIndex);
// // // // // // //                     final controller = nameControllers.removeAt(oldIndex);
// // // // // // //                     players.insert(newIndex, player);
// // // // // // //                     nameControllers.insert(newIndex, controller);
// // // // // // //                   });
// // // // // // //                 },
// // // // // // //                 itemBuilder: (context, index) {
// // // // // // //                   final player = players.elementAt(index);
// // // // // // //                   const double borderRadius = 20.0;

// // // // // // //                   return ReorderableDelayedDragStartListener(
// // // // // // //                     key: ValueKey(player),
// // // // // // //                     index: index,
// // // // // // //                     child: Padding(
// // // // // // //                       padding: EdgeInsets.only(bottom: 12.h),
// // // // // // //                       child: Container(
// // // // // // //                         margin: EdgeInsets.zero,
// // // // // // //                         decoration: BoxDecoration(
// // // // // // //                           color: Color.lerp(Colors.white, player.color, 0.2),
// // // // // // //                           borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // // //                         ),
// // // // // // //                         clipBehavior: Clip.antiAlias,
// // // // // // //                         child: Dismissible(
// // // // // // //                           key: ValueKey(player),
// // // // // // //                           direction: DismissDirection.horizontal,
// // // // // // //                           background: ClipRRect(
// // // // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // // //                             child: Container(
// // // // // // //                               alignment: Alignment.centerLeft,
// // // // // // //                               padding: EdgeInsets.only(left: 20.w),
// // // // // // //                               color: Colors.white,
// // // // // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // // // // //                             ),
// // // // // // //                           ),
// // // // // // //                           secondaryBackground: ClipRRect(
// // // // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // // //                             child: Container(
// // // // // // //                               alignment: Alignment.centerRight,
// // // // // // //                               padding: EdgeInsets.only(right: 20.w),
// // // // // // //                               color: Colors.white,
// // // // // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // // // // //                             ),
// // // // // // //                           ),
// // // // // // //                           onDismissed: (_) {
// // // // // // //                             setState(() {
// // // // // // //                               players.remove(player);
// // // // // // //                               nameControllers.removeAt(index);
// // // // // // //                             });
// // // // // // //                           },
// // // // // // //                           child: Container(
// // // // // // //                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// // // // // // //                             child: Row(
// // // // // // //                               children: [
// // // // // // //                                 Container(
// // // // // // //                                   width: 40.w,
// // // // // // //                                   height: 40.w,
// // // // // // //                                   alignment: Alignment.center,
// // // // // // //                                   decoration: BoxDecoration(
// // // // // // //                                     color: Colors.white,
// // // // // // //                                     borderRadius: BorderRadius.circular(12.r),
// // // // // // //                                   ),
// // // // // // //                                   child: Text(
// // // // // // //                                     '${index + 1}',
// // // // // // //                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// // // // // // //                                   ),
// // // // // // //                                 ),
// // // // // // //                                 SizedBox(width: 12.w),
// // // // // // //                                 Expanded(
// // // // // // //                                   child: Column(
// // // // // // //                                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // // //                                     children: [
// // // // // // //                                       Container(
// // // // // // //                                         decoration: BoxDecoration(
// // // // // // //                                           color: Colors.white.withOpacity(0.6),
// // // // // // //                                           borderRadius: BorderRadius.circular(8.r),
// // // // // // //                                         ),
// // // // // // //                                         padding: EdgeInsets.symmetric(
// // // // // // //                                           horizontal: 8.w,
// // // // // // //                                           vertical: 4.h,
// // // // // // //                                         ),
// // // // // // //                                         child: TextField(
// // // // // // //                                           controller: nameControllers.elementAt(index),
// // // // // // //                                           onChanged: (val) => players.elementAt(index).name = val,
// // // // // // //                                           style: TextStyle(
// // // // // // //                                             fontSize: 16.sp,
// // // // // // //                                             fontWeight: FontWeight.w500,
// // // // // // //                                           ),
// // // // // // //                                           decoration: const InputDecoration.collapsed(
// // // // // // //                                             hintText: 'Enter name',
// // // // // // //                                           ),
// // // // // // //                                         ),
// // // // // // //                                       ),
// // // // // // //                                       SizedBox(height: 8.h),
// // // // // // //                                       GestureDetector(
// // // // // // //                                         onTap: () async {
// // // // // // //                                           Duration selectedDuration = Duration(
// // // // // // //                                             seconds: players.elementAt(index).originalSeconds,
// // // // // // //                                           );
// // // // // // //                                           await showModalBottomSheet(
// // // // // // //                                             context: context,
// // // // // // //                                             builder:
// // // // // // //                                                 (context) => SizedBox(
// // // // // // //                                                   height: 200,
// // // // // // //                                                   child: CupertinoTimerPicker(
// // // // // // //                                                     mode: CupertinoTimerPickerMode.hms,
// // // // // // //                                                     initialTimerDuration: selectedDuration,
// // // // // // //                                                     onTimerDurationChanged: (Duration newDuration) {
// // // // // // //                                                       setState(() {
// // // // // // //                                                         players.elementAt(index).seconds =
// // // // // // //                                                             newDuration.inSeconds;
// // // // // // //                                                         players.elementAt(index).originalSeconds =
// // // // // // //                                                             newDuration.inSeconds;
// // // // // // //                                                       });
// // // // // // //                                                     },
// // // // // // //                                                   ),
// // // // // // //                                                 ),
// // // // // // //                                           );
// // // // // // //                                         },
// // // // // // //                                         child: Container(
// // // // // // //                                           decoration: BoxDecoration(
// // // // // // //                                             color: Colors.white.withOpacity(0.6),
// // // // // // //                                             borderRadius: BorderRadius.circular(8.r),
// // // // // // //                                           ),
// // // // // // //                                           padding: EdgeInsets.symmetric(
// // // // // // //                                             horizontal: 12.w,
// // // // // // //                                             vertical: 10.h,
// // // // // // //                                           ),
// // // // // // //                                           child: Text(
// // // // // // //                                             'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// // // // // // //                                             style: TextStyle(
// // // // // // //                                               fontSize: 16.sp,
// // // // // // //                                               fontWeight: FontWeight.w500,
// // // // // // //                                             ),
// // // // // // //                                           ),
// // // // // // //                                         ),
// // // // // // //                                       ),
// // // // // // //                                     ],
// // // // // // //                                   ),
// // // // // // //                                 ),
// // // // // // //                                 SizedBox(width: 8.w),
// // // // // // //                                 ElevatedButton(
// // // // // // //                                   onPressed: () async {
// // // // // // //                                     FocusScope.of(context).unfocus();
// // // // // // //                                     final color = await showDialog<Color>(
// // // // // // //                                       context: context,
// // // // // // //                                       builder:
// // // // // // //                                           (context) => AlertDialog(
// // // // // // //                                             title: const Text('Select Color'),
// // // // // // //                                             content: Wrap(
// // // // // // //                                               spacing: 8.w,
// // // // // // //                                               children:
// // // // // // //                                                   Colors.primaries.map((c) {
// // // // // // //                                                     return GestureDetector(
// // // // // // //                                                       onTap: () => Navigator.pop(context, c),
// // // // // // //                                                       child: Container(
// // // // // // //                                                         width: 30.w,
// // // // // // //                                                         height: 30.w,
// // // // // // //                                                         decoration: BoxDecoration(
// // // // // // //                                                           color: c,
// // // // // // //                                                           borderRadius: BorderRadius.circular(15.r),
// // // // // // //                                                         ),
// // // // // // //                                                       ),
// // // // // // //                                                     );
// // // // // // //                                                   }).toList(),
// // // // // // //                                             ),
// // // // // // //                                           ),
// // // // // // //                                     );
// // // // // // //                                     if (color != null) {
// // // // // // //                                       setState(() => players.elementAt(index).color = color);
// // // // // // //                                     }
// // // // // // //                                   },
// // // // // // //                                   style: ElevatedButton.styleFrom(
// // // // // // //                                     backgroundColor: player.color,
// // // // // // //                                     foregroundColor: Colors.white,
// // // // // // //                                     shape: RoundedRectangleBorder(
// // // // // // //                                       borderRadius: BorderRadius.circular(12.r),
// // // // // // //                                     ),
// // // // // // //                                   ),
// // // // // // //                                   child: const Text('Color'),
// // // // // // //                                 ),
// // // // // // //                               ],
// // // // // // //                             ),
// // // // // // //                           ),
// // // // // // //                         ),
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                   );
// // // // // // //                 },
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// // // // // // //       floatingActionButton: Padding(
// // // // // // //         padding: EdgeInsets.only(bottom: 16.h),
// // // // // // //         child: Row(
// // // // // // //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // // //           children: [
// // // // // // //             FloatingActionButton.extended(
// // // // // // //               heroTag: 'addPlayerBtn',
// // // // // // //               onPressed: addPlayer,
// // // // // // //               icon: const Icon(Icons.person_add, color: Colors.white),
// // // // // // //               label: const Text('추가', style: TextStyle(color: Colors.white)),
// // // // // // //               backgroundColor: Colors.indigo,
// // // // // // //             ),
// // // // // // //             FloatingActionButton.extended(
// // // // // // //               heroTag: 'startBtn',
// // // // // // //               onPressed: () {
// // // // // // //                 if (players.every((p) => p.name.isNotEmpty)) {
// // // // // // //                   Navigator.push(
// // // // // // //                     context,
// // // // // // //                     MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// // // // // // //                   );
// // // // // // //                 } else {
// // // // // // //                   ScaffoldMessenger.of(
// // // // // // //                     context,
// // // // // // //                   ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름을 입력해주세요.")));
// // // // // // //                 }
// // // // // // //               },
// // // // // // //               icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// // // // // // //               label: const Text('시작', style: TextStyle(color: Colors.white)),
// // // // // // //               backgroundColor: Colors.teal,
// // // // // // //             ),
// // // // // // //           ],
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // class TimerScreen extends StatefulWidget {
// // // // // // //   final List<Player> players;
// // // // // // //   const TimerScreen({super.key, required this.players});

// // // // // // //   @override
// // // // // // //   State<TimerScreen> createState() => _TimerScreenState();
// // // // // // // }

// // // // // // // class _TimerScreenState extends State<TimerScreen> {
// // // // // // //   Timer? _timer;
// // // // // // //   int currentIndex = 0;

// // // // // // //   @override
// // // // // // //   void initState() {
// // // // // // //     super.initState();
// // // // // // //     startTimer();
// // // // // // //   }

// // // // // // //   void startTimer() {
// // // // // // //     _timer?.cancel();
// // // // // // //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// // // // // // //       setState(() {
// // // // // // //         final player = widget.players.elementAt(currentIndex);
// // // // // // //         if (player.seconds > 0) {
// // // // // // //           player.seconds--;
// // // // // // //           player.elapsedSeconds++;
// // // // // // //         } else {
// // // // // // //           player.isCompleted = true;
// // // // // // //           switchToNextPlayer();
// // // // // // //         }
// // // // // // //       });
// // // // // // //     });
// // // // // // //   }

// // // // // // //   void pauseTimer() {
// // // // // // //     _timer?.cancel();
// // // // // // //   }

// // // // // // //   void switchToNextPlayer() {
// // // // // // //     pauseTimer();
// // // // // // //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// // // // // // //       showSummaryDialog();
// // // // // // //       return;
// // // // // // //     }
// // // // // // //     do {
// // // // // // //       currentIndex = (currentIndex + 1) % widget.players.length;
// // // // // // //     } while (widget.players.elementAt(currentIndex).isCompleted);
// // // // // // //     startTimer();
// // // // // // //   }

// // // // // // //   void resetAll() {
// // // // // // //     for (var p in widget.players) {
// // // // // // //       p.seconds = p.originalSeconds;
// // // // // // //       p.elapsedSeconds = 0;
// // // // // // //       p.isCompleted = false;
// // // // // // //     }
// // // // // // //     setState(() {
// // // // // // //       currentIndex = 0;
// // // // // // //     });
// // // // // // //     startTimer();
// // // // // // //   }

// // // // // // //   String formatDuration(int seconds) {
// // // // // // //     final d = Duration(seconds: seconds);
// // // // // // //     final hours = d.inHours.toString().padLeft(2, '0');
// // // // // // //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// // // // // // //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// // // // // // //     return '$hours:$minutes:$secs';
// // // // // // //   }

// // // // // // //   void showSummaryDialog() {
// // // // // // //     _timer?.cancel();
// // // // // // //     showDialog(
// // // // // // //       context: context,
// // // // // // //       builder:
// // // // // // //           (_) => AlertDialog(
// // // // // // //             title: const Text('Round Complete'),
// // // // // // //             content: Column(
// // // // // // //               mainAxisSize: MainAxisSize.min,
// // // // // // //               children:
// // // // // // //                   widget.players.map((p) {
// // // // // // //                     final formatted = formatDuration(p.elapsedSeconds);
// // // // // // //                     return Text('${p.name} ⏱ $formatted');
// // // // // // //                   }).toList(),
// // // // // // //             ),
// // // // // // //             actions: [
// // // // // // //               TextButton(
// // // // // // //                 onPressed: () {
// // // // // // //                   Navigator.of(context).pop();
// // // // // // //                   resetAll();
// // // // // // //                 },
// // // // // // //                 child: const Text('Next Round'),
// // // // // // //               ),
// // // // // // //               TextButton(
// // // // // // //                 onPressed: () {
// // // // // // //                   resetAll();
// // // // // // //                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // // //                 },
// // // // // // //                 child: const Text('Home'),
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   void dispose() {
// // // // // // //     _timer?.cancel();
// // // // // // //     super.dispose();
// // // // // // //   }

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     final player = widget.players.elementAt(currentIndex);
// // // // // // //     return Scaffold(
// // // // // // //       backgroundColor: player.color,
// // // // // // //       body: SafeArea(
// // // // // // //         child: GestureDetector(
// // // // // // //           behavior: HitTestBehavior.opaque,
// // // // // // //           onTap: () {
// // // // // // //             setState(() {
// // // // // // //               pauseTimer();
// // // // // // //               switchToNextPlayer();
// // // // // // //             });
// // // // // // //           },
// // // // // // //           child: Stack(
// // // // // // //             children: [
// // // // // // //               Center(
// // // // // // //                 child: Column(
// // // // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //                   children: [
// // // // // // //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// // // // // // //                     SizedBox(height: 16.h),
// // // // // // //                     Text(
// // // // // // //                       formatDuration(player.seconds),
// // // // // // //                       style: TextStyle(
// // // // // // //                         fontSize: 64.sp,
// // // // // // //                         fontWeight: FontWeight.bold,
// // // // // // //                         color: Colors.white,
// // // // // // //                       ),
// // // // // // //                     ),
// // // // // // //                     SizedBox(height: 24.h),
// // // // // // //                     ElevatedButton(
// // // // // // //                       onPressed: () {
// // // // // // //                         setState(() {
// // // // // // //                           widget.players.elementAt(currentIndex).isCompleted = true;
// // // // // // //                           pauseTimer();
// // // // // // //                           switchToNextPlayer();
// // // // // // //                         });
// // // // // // //                       },
// // // // // // //                       child: const Text('Complete'),
// // // // // // //                     ),
// // // // // // //                     SizedBox(height: 12.h),
// // // // // // //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// // // // // // //                   ],
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //               Positioned(
// // // // // // //                 top: 20.h,
// // // // // // //                 right: 20.w,
// // // // // // //                 child: IconButton(
// // // // // // //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// // // // // // //                   onPressed: () {
// // // // // // //                     pauseTimer();
// // // // // // //                     showDialog(
// // // // // // //                       context: context,
// // // // // // //                       builder:
// // // // // // //                           (context) => AlertDialog(
// // // // // // //                             title: const Text('홈으로 이동'),
// // // // // // //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// // // // // // //                             actions: [
// // // // // // //                               TextButton(
// // // // // // //                                 onPressed: () {
// // // // // // //                                   Navigator.of(context).pop();
// // // // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // // //                                 },
// // // // // // //                                 child: const Text('설정 유지'),
// // // // // // //                               ),
// // // // // // //                               TextButton(
// // // // // // //                                 onPressed: () {
// // // // // // //                                   resetAll();
// // // // // // //                                   Navigator.of(context).pop();
// // // // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // // //                                 },
// // // // // // //                                 child: const Text('초기화 후 이동'),
// // // // // // //                               ),
// // // // // // //                             ],
// // // // // // //                           ),
// // // // // // //                     );
// // // // // // //                   },
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ],
// // // // // // //           ),
// // // // // // //         ),
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // // -Player 카드 수정
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // // // // import 'package:flutter/cupertino.dart';
// // // // // // import 'dart:async';
// // // // // // import 'dart:convert';
// // // // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // // // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // // // // // void main() async {
// // // // // //   WidgetsFlutterBinding.ensureInitialized();
// // // // // //   final prefs = await SharedPreferences.getInstance();
// // // // // //   final lastUsed = prefs.getString('last_used_preset');
// // // // // //   runApp(MyApp(lastUsedPreset: lastUsed));
// // // // // // }

// // // // // // class MyApp extends StatelessWidget {
// // // // // //   final String? lastUsedPreset;
// // // // // //   const MyApp({super.key, this.lastUsedPreset});

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return ScreenUtilInit(
// // // // // //       designSize: const Size(390, 844),
// // // // // //       builder:
// // // // // //           (context, child) => MaterialApp(
// // // // // //             debugShowCheckedModeBanner: false,
// // // // // //             title: 'Multi Player Timer',
// // // // // //             theme: ThemeData(
// // // // // //               scaffoldBackgroundColor: Colors.white,
// // // // // //               fontFamily: 'Roboto',
// // // // // //               textTheme: TextTheme(
// // // // // //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// // // // // //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// // // // // //                 bodyLarge: TextStyle(fontSize: 16.sp),
// // // // // //               ),
// // // // // //               elevatedButtonTheme: ElevatedButtonThemeData(
// // // // // //                 style: ElevatedButton.styleFrom(
// // // // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// // // // // //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// // // // // //           ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class Player {
// // // // // //   String name;
// // // // // //   int seconds;
// // // // // //   int originalSeconds;
// // // // // //   Color color;
// // // // // //   bool isCompleted;
// // // // // //   int elapsedSeconds = 0;

// // // // // //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// // // // // //     : originalSeconds = seconds;

// // // // // //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// // // // // //   static Player fromJson(Map<String, dynamic> json) =>
// // // // // //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // // // // // }

// // // // // // class PlayerSetupScreen extends StatefulWidget {
// // // // // //   final String? lastUsedPreset;
// // // // // //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// // // // // //   @override
// // // // // //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // // // // // }

// // // // // // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// // // // // //   final List<Player> players = [];
// // // // // //   final List<TextEditingController> nameControllers = [];
// // // // // //   String? currentPresetName;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     if (widget.lastUsedPreset != null) {
// // // // // //       currentPresetName = widget.lastUsedPreset;
// // // // // //       loadPreset(widget.lastUsedPreset!, autoLoad: true);
// // // // // //     } else {
// // // // // //       initializePlayers(2);
// // // // // //     }
// // // // // //   }

// // // // // //   void initializePlayers(int count) {
// // // // // //     players.clear();
// // // // // //     nameControllers.clear();
// // // // // //     for (int i = 0; i < count; i++) {
// // // // // //       players.add(Player(name: '', seconds: 0, color: Colors.blue)); // 초기값 변경
// // // // // //       nameControllers.add(TextEditingController(text: '')); // 초기값 변경
// // // // // //     }
// // // // // //     setState(() {});
// // // // // //   }

// // // // // //   void addPlayer() {
// // // // // //     final newIndex = players.length;
// // // // // //     players.add(Player(name: '', seconds: 0, color: Colors.blue));
// // // // // //     nameControllers.add(TextEditingController(text: ''));
// // // // // //     setState(() {});
// // // // // //   }

// // // // // //   void removePlayer(int index) {
// // // // // //     players.removeAt(index);
// // // // // //     nameControllers.removeAt(index);
// // // // // //     setState(() {});
// // // // // //   }

// // // // // //   Future<void> saveCurrentSettings(String presetName) async {
// // // // // //     if (presetName.isEmpty) return;
// // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // //     final encoded = players.map((p) => p.toJson()).toList();
// // // // // //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// // // // // //     await prefs.setString('last_used_preset', presetName);
// // // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // // //     if (!names.contains(presetName)) {
// // // // // //       names.add(presetName);
// // // // // //       await prefs.setStringList('preset_names', names);
// // // // // //     }
// // // // // //     setState(() {
// // // // // //       currentPresetName = presetName;
// // // // // //     });
// // // // // //   }

// // // // // //   Future<void> deletePreset(String presetName) async {
// // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // //     await prefs.remove('preset_$presetName');
// // // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // // //     names.remove(presetName);
// // // // // //     await prefs.setStringList('preset_names', names);
// // // // // //     final lastUsed = prefs.getString('last_used_preset');
// // // // // //     if (lastUsed == presetName) {
// // // // // //       await prefs.remove('last_used_preset');
// // // // // //       setState(() {
// // // // // //         currentPresetName = null;
// // // // // //       });
// // // // // //     }
// // // // // //   }

// // // // // //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// // // // // //     try {
// // // // // //       final prefs = await SharedPreferences.getInstance();
// // // // // //       final jsonString = prefs.getString('preset_$presetName');
// // // // // //       if (jsonString == null) return;
// // // // // //       final List decoded = jsonDecode(jsonString);
// // // // // //       players.clear();
// // // // // //       nameControllers.clear();
// // // // // //       for (var p in decoded) {
// // // // // //         final player = Player.fromJson(p);
// // // // // //         players.add(player);
// // // // // //         nameControllers.add(TextEditingController(text: player.name));
// // // // // //       }
// // // // // //       setState(() {
// // // // // //         currentPresetName = presetName;
// // // // // //       });
// // // // // //       if (!autoLoad) {
// // // // // //         await prefs.setString('last_used_preset', presetName);
// // // // // //       }
// // // // // //     } catch (_) {
// // // // // //       ScaffoldMessenger.of(
// // // // // //         context,
// // // // // //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// // // // // //     }
// // // // // //   }

// // // // // //   void showSaveDialog() async {
// // // // // //     final controller = TextEditingController();
// // // // // //     await showDialog(
// // // // // //       context: context,
// // // // // //       builder:
// // // // // //           (ctx) => AlertDialog(
// // // // // //             title: const Text("설정 이름 저장"),
// // // // // //             content: TextField(
// // // // // //               controller: controller,
// // // // // //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// // // // // //             ),
// // // // // //             actions: [
// // // // // //               TextButton(
// // // // // //                 onPressed: () async {
// // // // // //                   await saveCurrentSettings(controller.text.trim());
// // // // // //                   Navigator.of(ctx).pop();
// // // // // //                 },
// // // // // //                 child: const Text("저장"),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //     );
// // // // // //   }

// // // // // //   void showLoadDialog() async {
// // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // //     final presetNames = prefs.getStringList('preset_names') ?? [];
// // // // // //     if (presetNames.isEmpty) {
// // // // // //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// // // // // //       return;
// // // // // //     }
// // // // // //     await showDialog(
// // // // // //       context: context,
// // // // // //       builder:
// // // // // //           (ctx) => AlertDialog(
// // // // // //             title: const Text("불러올 설정 선택"),
// // // // // //             content: SingleChildScrollView(
// // // // // //               child: Column(
// // // // // //                 mainAxisSize: MainAxisSize.min,
// // // // // //                 children:
// // // // // //                     presetNames.map((name) {
// // // // // //                       return ListTile(
// // // // // //                         title: Text(name),
// // // // // //                         trailing: IconButton(
// // // // // //                           icon: const Icon(Icons.delete, color: Colors.red),
// // // // // //                           onPressed: () async {
// // // // // //                             Navigator.of(ctx).pop();
// // // // // //                             await deletePreset(name);
// // // // // //                           },
// // // // // //                         ),
// // // // // //                         onTap: () async {
// // // // // //                           Navigator.of(ctx).pop();
// // // // // //                           await loadPreset(name);
// // // // // //                         },
// // // // // //                       );
// // // // // //                     }).toList(),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //     );
// // // // // //   }

// // // // // //   void clearAllSettings() async {
// // // // // //     initializePlayers(2);
// // // // // //     final prefs = await SharedPreferences.getInstance();
// // // // // //     await prefs.remove('last_used_preset');
// // // // // //     setState(() {
// // // // // //       currentPresetName = null;
// // // // // //     });
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return Scaffold(
// // // // // //       appBar: AppBar(
// // // // // //         title: Text(
// // // // // //           'TimeSquad',
// // // // // //           style: TextStyle(
// // // // // //             fontSize: 22.sp,
// // // // // //             fontWeight: FontWeight.w600,
// // // // // //             letterSpacing: 0.8,
// // // // // //             color: Colors.black87,
// // // // // //           ),
// // // // // //         ),
// // // // // //         backgroundColor: Colors.white,
// // // // // //         elevation: 0,
// // // // // //         scrolledUnderElevation: 0.0,
// // // // // //         toolbarHeight: 60.h,
// // // // // //       ),
// // // // // //       body: SafeArea(
// // // // // //         child: SingleChildScrollView(
// // // // // //           padding: EdgeInsets.all(24.w),
// // // // // //           child: Column(
// // // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //             children: [
// // // // // //               Row(
// // // // // //                 children: [
// // // // // //                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
// // // // // //                   const Spacer(),
// // // // // //                   Row(
// // // // // //                     mainAxisSize: MainAxisSize.min,
// // // // // //                     children: [
// // // // // //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// // // // // //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// // // // // //                       IconButton(
// // // // // //                         icon: const Icon(FeatherIcons.rotateCcw),
// // // // // //                         onPressed: clearAllSettings,
// // // // // //                       ),
// // // // // //                     ],
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               SizedBox(height: 24.h),
// // // // // //               ReorderableListView.builder(
// // // // // //                 shrinkWrap: true,
// // // // // //                 physics: const NeverScrollableScrollPhysics(),
// // // // // //                 padding: EdgeInsets.only(bottom: 120.h),
// // // // // //                 buildDefaultDragHandles: false,
// // // // // //                 proxyDecorator: (child, index, animation) {
// // // // // //                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// // // // // //                   return ScaleTransition(
// // // // // //                     scale: scale,
// // // // // //                     child: Material(
// // // // // //                       elevation: 0,
// // // // // //                       shadowColor: Colors.transparent,
// // // // // //                       color: Colors.transparent,
// // // // // //                       child: child,
// // // // // //                     ),
// // // // // //                   );
// // // // // //                 },
// // // // // //                 itemCount: players.length,
// // // // // //                 onReorder: (oldIndex, newIndex) {
// // // // // //                   setState(() {
// // // // // //                     if (newIndex > oldIndex) newIndex--;
// // // // // //                     final player = players.removeAt(oldIndex);
// // // // // //                     final controller = nameControllers.removeAt(oldIndex);
// // // // // //                     players.insert(newIndex, player);
// // // // // //                     nameControllers.insert(newIndex, controller);
// // // // // //                   });
// // // // // //                 },
// // // // // //                 itemBuilder: (context, index) {
// // // // // //                   final player = players.elementAt(index);
// // // // // //                   const double borderRadius = 20.0;
// // // // // //                   const double boxHeight = 48.0; // Name and Time box height

// // // // // //                   return ReorderableDelayedDragStartListener(
// // // // // //                     key: ValueKey(player),
// // // // // //                     index: index,
// // // // // //                     child: Padding(
// // // // // //                       padding: EdgeInsets.only(bottom: 12.h),
// // // // // //                       child: Container(
// // // // // //                         margin: EdgeInsets.zero,
// // // // // //                         decoration: BoxDecoration(
// // // // // //                           color: Color.lerp(Colors.white, player.color, 0.2),
// // // // // //                           borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // //                         ),
// // // // // //                         clipBehavior: Clip.antiAlias,
// // // // // //                         child: Dismissible(
// // // // // //                           key: ValueKey(player),
// // // // // //                           direction: DismissDirection.horizontal,
// // // // // //                           background: ClipRRect(
// // // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // //                             child: Container(
// // // // // //                               alignment: Alignment.centerLeft,
// // // // // //                               padding: EdgeInsets.only(left: 20.w),
// // // // // //                               color: Colors.white,
// // // // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                           secondaryBackground: ClipRRect(
// // // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // // //                             child: Container(
// // // // // //                               alignment: Alignment.centerRight,
// // // // // //                               padding: EdgeInsets.only(right: 20.w),
// // // // // //                               color: Colors.white,
// // // // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                           onDismissed: (_) {
// // // // // //                             setState(() {
// // // // // //                               players.remove(player);
// // // // // //                               nameControllers.removeAt(index);
// // // // // //                             });
// // // // // //                           },
// // // // // //                           child: Container(
// // // // // //                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// // // // // //                             child: Row(
// // // // // //                               children: [
// // // // // //                                 Container(
// // // // // //                                   width: 40.w,
// // // // // //                                   height: 40.w,
// // // // // //                                   alignment: Alignment.center,
// // // // // //                                   decoration: BoxDecoration(
// // // // // //                                     color: Colors.white,
// // // // // //                                     shape: BoxShape.circle, // 원형으로 변경
// // // // // //                                   ),
// // // // // //                                   child: Text(
// // // // // //                                     '${index + 1}',
// // // // // //                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                                 SizedBox(width: 12.w),
// // // // // //                                 Expanded(
// // // // // //                                   child: Column(
// // // // // //                                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // // //                                     children: [
// // // // // //                                       Container(
// // // // // //                                         height: boxHeight, // 높이 일치
// // // // // //                                         decoration: BoxDecoration(
// // // // // //                                           color: Colors.white.withOpacity(0.6),
// // // // // //                                           borderRadius: BorderRadius.circular(8.r),
// // // // // //                                         ),
// // // // // //                                         padding: EdgeInsets.symmetric(
// // // // // //                                           horizontal: 8.w,
// // // // // //                                           vertical: 4.h,
// // // // // //                                         ),
// // // // // //                                         alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // // // // //                                         child: TextField(
// // // // // //                                           controller: nameControllers.elementAt(index),
// // // // // //                                           onChanged: (val) => players.elementAt(index).name = val,
// // // // // //                                           style: TextStyle(
// // // // // //                                             fontSize: 16.sp,
// // // // // //                                             fontWeight: FontWeight.w500,
// // // // // //                                           ),
// // // // // //                                           decoration: InputDecoration.collapsed(
// // // // // //                                             hintText: 'Enter Name', // 힌트 텍스트 추가
// // // // // //                                             hintStyle: TextStyle(
// // // // // //                                               color: Colors.grey.shade500,
// // // // // //                                               fontSize: 16.sp,
// // // // // //                                             ),
// // // // // //                                           ),
// // // // // //                                         ),
// // // // // //                                       ),
// // // // // //                                       SizedBox(height: 8.h),
// // // // // //                                       GestureDetector(
// // // // // //                                         onTap: () async {
// // // // // //                                           Duration selectedDuration = Duration(
// // // // // //                                             seconds: players.elementAt(index).originalSeconds,
// // // // // //                                           );
// // // // // //                                           await showModalBottomSheet(
// // // // // //                                             context: context,
// // // // // //                                             builder:
// // // // // //                                                 (context) => SizedBox(
// // // // // //                                                   height: 200,
// // // // // //                                                   child: CupertinoTimerPicker(
// // // // // //                                                     mode: CupertinoTimerPickerMode.hms,
// // // // // //                                                     initialTimerDuration:
// // // // // //                                                         selectedDuration.inSeconds == 0
// // // // // //                                                             ? const Duration(minutes: 10) // 기본값 10분
// // // // // //                                                             : selectedDuration,
// // // // // //                                                     onTimerDurationChanged: (Duration newDuration) {
// // // // // //                                                       setState(() {
// // // // // //                                                         players.elementAt(index).seconds =
// // // // // //                                                             newDuration.inSeconds;
// // // // // //                                                         players.elementAt(index).originalSeconds =
// // // // // //                                                             newDuration.inSeconds;
// // // // // //                                                       });
// // // // // //                                                     },
// // // // // //                                                   ),
// // // // // //                                                 ),
// // // // // //                                           );
// // // // // //                                         },
// // // // // //                                         child: Container(
// // // // // //                                           height: boxHeight, // 높이 일치
// // // // // //                                           decoration: BoxDecoration(
// // // // // //                                             color: Colors.white.withOpacity(0.6),
// // // // // //                                             borderRadius: BorderRadius.circular(8.r),
// // // // // //                                           ),
// // // // // //                                           padding: EdgeInsets.symmetric(
// // // // // //                                             horizontal: 12.w,
// // // // // //                                             vertical: 10.h,
// // // // // //                                           ),
// // // // // //                                           alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // // // // //                                           child: Text(
// // // // // //                                             players.elementAt(index).originalSeconds == 0
// // // // // //                                                 ? 'Set Time' // 초기값이 0일 경우 "Set Time" 표시
// // // // // //                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// // // // // //                                             style: TextStyle(
// // // // // //                                               fontSize: 16.sp,
// // // // // //                                               fontWeight: FontWeight.w500,
// // // // // //                                               color:
// // // // // //                                                   players.elementAt(index).originalSeconds == 0
// // // // // //                                                       ? Colors
// // // // // //                                                           .grey
// // // // // //                                                           .shade500 // 힌트 색상
// // // // // //                                                       : Colors.black,
// // // // // //                                             ),
// // // // // //                                           ),
// // // // // //                                         ),
// // // // // //                                       ),
// // // // // //                                     ],
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                                 SizedBox(width: 8.w),
// // // // // //                                 ElevatedButton(
// // // // // //                                   onPressed: () async {
// // // // // //                                     FocusScope.of(context).unfocus();
// // // // // //                                     final color = await showDialog<Color>(
// // // // // //                                       context: context,
// // // // // //                                       builder:
// // // // // //                                           (context) => AlertDialog(
// // // // // //                                             title: const Text('Select Color'),
// // // // // //                                             content: Wrap(
// // // // // //                                               spacing: 8.w,
// // // // // //                                               children:
// // // // // //                                                   Colors.primaries.map((c) {
// // // // // //                                                     return GestureDetector(
// // // // // //                                                       onTap: () => Navigator.pop(context, c),
// // // // // //                                                       child: Container(
// // // // // //                                                         width: 30.w,
// // // // // //                                                         height: 30.w,
// // // // // //                                                         decoration: BoxDecoration(
// // // // // //                                                           color: c,
// // // // // //                                                           borderRadius: BorderRadius.circular(15.r),
// // // // // //                                                         ),
// // // // // //                                                       ),
// // // // // //                                                     );
// // // // // //                                                   }).toList(),
// // // // // //                                             ),
// // // // // //                                           ),
// // // // // //                                     );
// // // // // //                                     if (color != null) {
// // // // // //                                       setState(() => players.elementAt(index).color = color);
// // // // // //                                     }
// // // // // //                                   },
// // // // // //                                   style: ElevatedButton.styleFrom(
// // // // // //                                     backgroundColor: player.color,
// // // // // //                                     foregroundColor: Colors.white,
// // // // // //                                     shape: RoundedRectangleBorder(
// // // // // //                                       borderRadius: BorderRadius.circular(12.r),
// // // // // //                                     ),
// // // // // //                                   ),
// // // // // //                                   child: const Text('Color'),
// // // // // //                                 ),
// // // // // //                               ],
// // // // // //                             ),
// // // // // //                           ),
// // // // // //                         ),
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                   );
// // // // // //                 },
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// // // // // //       floatingActionButton: Padding(
// // // // // //         padding: EdgeInsets.only(bottom: 16.h),
// // // // // //         child: Row(
// // // // // //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // // //           children: [
// // // // // //             FloatingActionButton.extended(
// // // // // //               heroTag: 'addPlayerBtn',
// // // // // //               onPressed: addPlayer,
// // // // // //               icon: const Icon(Icons.person_add, color: Colors.white),
// // // // // //               label: const Text('추가', style: TextStyle(color: Colors.white)),
// // // // // //               backgroundColor: Colors.indigo,
// // // // // //             ),
// // // // // //             FloatingActionButton.extended(
// // // // // //               heroTag: 'startBtn',
// // // // // //               onPressed: () {
// // // // // //                 // 플레이어 이름과 시간이 설정되었는지 확인
// // // // // //                 bool allPlayersValid = true;
// // // // // //                 for (int i = 0; i < players.length; i++) {
// // // // // //                   if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
// // // // // //                     allPlayersValid = false;
// // // // // //                     break;
// // // // // //                   }
// // // // // //                 }

// // // // // //                 if (allPlayersValid) {
// // // // // //                   Navigator.push(
// // // // // //                     context,
// // // // // //                     MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// // // // // //                   );
// // // // // //                 } else {
// // // // // //                   ScaffoldMessenger.of(
// // // // // //                     context,
// // // // // //                   ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
// // // // // //                 }
// // // // // //               },
// // // // // //               icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// // // // // //               label: const Text('시작', style: TextStyle(color: Colors.white)),
// // // // // //               backgroundColor: Colors.teal,
// // // // // //             ),
// // // // // //           ],
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // // class TimerScreen extends StatefulWidget {
// // // // // //   final List<Player> players;
// // // // // //   const TimerScreen({super.key, required this.players});

// // // // // //   @override
// // // // // //   State<TimerScreen> createState() => _TimerScreenState();
// // // // // // }

// // // // // // class _TimerScreenState extends State<TimerScreen> {
// // // // // //   Timer? _timer;
// // // // // //   int currentIndex = 0;

// // // // // //   @override
// // // // // //   void initState() {
// // // // // //     super.initState();
// // // // // //     startTimer();
// // // // // //   }

// // // // // //   void startTimer() {
// // // // // //     _timer?.cancel();
// // // // // //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// // // // // //       setState(() {
// // // // // //         final player = widget.players.elementAt(currentIndex);
// // // // // //         if (player.seconds > 0) {
// // // // // //           player.seconds--;
// // // // // //           player.elapsedSeconds++;
// // // // // //         } else {
// // // // // //           player.isCompleted = true;
// // // // // //           switchToNextPlayer();
// // // // // //         }
// // // // // //       });
// // // // // //     });
// // // // // //   }

// // // // // //   void pauseTimer() {
// // // // // //     _timer?.cancel();
// // // // // //   }

// // // // // //   void switchToNextPlayer() {
// // // // // //     pauseTimer();
// // // // // //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// // // // // //       showSummaryDialog();
// // // // // //       return;
// // // // // //     }
// // // // // //     do {
// // // // // //       currentIndex = (currentIndex + 1) % widget.players.length;
// // // // // //     } while (widget.players.elementAt(currentIndex).isCompleted);
// // // // // //     startTimer();
// // // // // //   }

// // // // // //   void resetAll() {
// // // // // //     for (var p in widget.players) {
// // // // // //       p.seconds = p.originalSeconds;
// // // // // //       p.elapsedSeconds = 0;
// // // // // //       p.isCompleted = false;
// // // // // //     }
// // // // // //     setState(() {
// // // // // //       currentIndex = 0;
// // // // // //     });
// // // // // //     startTimer();
// // // // // //   }

// // // // // //   String formatDuration(int seconds) {
// // // // // //     final d = Duration(seconds: seconds);
// // // // // //     final hours = d.inHours.toString().padLeft(2, '0');
// // // // // //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// // // // // //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// // // // // //     return '$hours:$minutes:$secs';
// // // // // //   }

// // // // // //   void showSummaryDialog() {
// // // // // //     _timer?.cancel();
// // // // // //     showDialog(
// // // // // //       context: context,
// // // // // //       builder:
// // // // // //           (_) => AlertDialog(
// // // // // //             title: const Text('Round Complete'),
// // // // // //             content: Column(
// // // // // //               mainAxisSize: MainAxisSize.min,
// // // // // //               children:
// // // // // //                   widget.players.map((p) {
// // // // // //                     final formatted = formatDuration(p.elapsedSeconds);
// // // // // //                     return Text('${p.name} ⏱ $formatted');
// // // // // //                   }).toList(),
// // // // // //             ),
// // // // // //             actions: [
// // // // // //               TextButton(
// // // // // //                 onPressed: () {
// // // // // //                   Navigator.of(context).pop();
// // // // // //                   resetAll();
// // // // // //                 },
// // // // // //                 child: const Text('Next Round'),
// // // // // //               ),
// // // // // //               TextButton(
// // // // // //                 onPressed: () {
// // // // // //                   resetAll();
// // // // // //                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // //                 },
// // // // // //                 child: const Text('Home'),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //     );
// // // // // //   }

// // // // // //   @override
// // // // // //   void dispose() {
// // // // // //     _timer?.cancel();
// // // // // //     super.dispose();
// // // // // //   }

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     final player = widget.players.elementAt(currentIndex);
// // // // // //     return Scaffold(
// // // // // //       backgroundColor: player.color,
// // // // // //       body: SafeArea(
// // // // // //         child: GestureDetector(
// // // // // //           behavior: HitTestBehavior.opaque,
// // // // // //           onTap: () {
// // // // // //             setState(() {
// // // // // //               pauseTimer();
// // // // // //               switchToNextPlayer();
// // // // // //             });
// // // // // //           },
// // // // // //           child: Stack(
// // // // // //             children: [
// // // // // //               Center(
// // // // // //                 child: Column(
// // // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                   children: [
// // // // // //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// // // // // //                     SizedBox(height: 16.h),
// // // // // //                     Text(
// // // // // //                       formatDuration(player.seconds),
// // // // // //                       style: TextStyle(
// // // // // //                         fontSize: 64.sp,
// // // // // //                         fontWeight: FontWeight.bold,
// // // // // //                         color: Colors.white,
// // // // // //                       ),
// // // // // //                     ),
// // // // // //                     SizedBox(height: 24.h),
// // // // // //                     ElevatedButton(
// // // // // //                       onPressed: () {
// // // // // //                         setState(() {
// // // // // //                           widget.players.elementAt(currentIndex).isCompleted = true;
// // // // // //                           pauseTimer();
// // // // // //                           switchToNextPlayer();
// // // // // //                         });
// // // // // //                       },
// // // // // //                       child: const Text('Complete'),
// // // // // //                     ),
// // // // // //                     SizedBox(height: 12.h),
// // // // // //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// // // // // //                   ],
// // // // // //                 ),
// // // // // //               ),
// // // // // //               Positioned(
// // // // // //                 top: 20.h,
// // // // // //                 right: 20.w,
// // // // // //                 child: IconButton(
// // // // // //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// // // // // //                   onPressed: () {
// // // // // //                     pauseTimer();
// // // // // //                     showDialog(
// // // // // //                       context: context,
// // // // // //                       builder:
// // // // // //                           (context) => AlertDialog(
// // // // // //                             title: const Text('홈으로 이동'),
// // // // // //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// // // // // //                             actions: [
// // // // // //                               TextButton(
// // // // // //                                 onPressed: () {
// // // // // //                                   Navigator.of(context).pop();
// // // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // //                                 },
// // // // // //                                 child: const Text('설정 유지'),
// // // // // //                               ),
// // // // // //                               TextButton(
// // // // // //                                 onPressed: () {
// // // // // //                                   resetAll();
// // // // // //                                   Navigator.of(context).pop();
// // // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // // //                                 },
// // // // // //                                 child: const Text('초기화 후 이동'),
// // // // // //                               ),
// // // // // //                             ],
// // // // // //                           ),
// // // // // //                     );
// // // // // //                   },
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ],
// // // // // //           ),
// // // // // //         ),
// // // // // //       ),
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // // // import 'package:flutter/cupertino.dart';
// // // // // import 'dart:async';
// // // // // import 'dart:convert';
// // // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // // // // void main() async {
// // // // //   WidgetsFlutterBinding.ensureInitialized();
// // // // //   final prefs = await SharedPreferences.getInstance();
// // // // //   final lastUsed = prefs.getString('last_used_preset');
// // // // //   runApp(MyApp(lastUsedPreset: lastUsed));
// // // // // }

// // // // // class MyApp extends StatelessWidget {
// // // // //   final String? lastUsedPreset;
// // // // //   const MyApp({super.key, this.lastUsedPreset});

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return ScreenUtilInit(
// // // // //       designSize: const Size(390, 844),
// // // // //       builder:
// // // // //           (context, child) => MaterialApp(
// // // // //             debugShowCheckedModeBanner: false,
// // // // //             title: 'Multi Player Timer',
// // // // //             theme: ThemeData(
// // // // //               scaffoldBackgroundColor: Colors.white,
// // // // //               fontFamily: 'Roboto',
// // // // //               textTheme: TextTheme(
// // // // //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// // // // //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// // // // //                 bodyLarge: TextStyle(fontSize: 16.sp),
// // // // //               ),
// // // // //               elevatedButtonTheme: ElevatedButtonThemeData(
// // // // //                 style: ElevatedButton.styleFrom(
// // // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// // // // //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// // // // //           ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class Player {
// // // // //   String name;
// // // // //   int seconds;
// // // // //   int originalSeconds;
// // // // //   Color color;
// // // // //   bool isCompleted;
// // // // //   int elapsedSeconds = 0;

// // // // //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// // // // //     : originalSeconds = seconds;

// // // // //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// // // // //   static Player fromJson(Map<String, dynamic> json) =>
// // // // //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // // // // }

// // // // // class PlayerSetupScreen extends StatefulWidget {
// // // // //   final String? lastUsedPreset;
// // // // //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// // // // //   @override
// // // // //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // // // // }

// // // // // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// // // // //   final List<Player> players = [];
// // // // //   final List<TextEditingController> nameControllers = [];
// // // // //   String? currentPresetName;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     if (widget.lastUsedPreset != null) {
// // // // //       currentPresetName = widget.lastUsedPreset;
// // // // //       loadPreset(widget.lastUsedPreset!, autoLoad: true);
// // // // //     } else {
// // // // //       initializePlayers(2);
// // // // //     }
// // // // //   }

// // // // //   void initializePlayers(int count) {
// // // // //     players.clear();
// // // // //     nameControllers.clear();
// // // // //     for (int i = 0; i < count; i++) {
// // // // //       players.add(Player(name: '', seconds: 0, color: Colors.blue)); // 초기값 변경
// // // // //       nameControllers.add(TextEditingController(text: '')); // 초기값 변경
// // // // //     }
// // // // //     setState(() {});
// // // // //   }

// // // // //   void addPlayer() {
// // // // //     final newIndex = players.length;
// // // // //     players.add(Player(name: '', seconds: 0, color: Colors.blue));
// // // // //     nameControllers.add(TextEditingController(text: ''));
// // // // //     setState(() {});
// // // // //   }

// // // // //   void removePlayer(int index) {
// // // // //     players.removeAt(index);
// // // // //     nameControllers.removeAt(index);
// // // // //     setState(() {});
// // // // //   }

// // // // //   Future<void> saveCurrentSettings(String presetName) async {
// // // // //     if (presetName.isEmpty) return;
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     final encoded = players.map((p) => p.toJson()).toList();
// // // // //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// // // // //     await prefs.setString('last_used_preset', presetName);
// // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // //     if (!names.contains(presetName)) {
// // // // //       names.add(presetName);
// // // // //       await prefs.setStringList('preset_names', names);
// // // // //     }
// // // // //     setState(() {
// // // // //       currentPresetName = presetName;
// // // // //     });
// // // // //   }

// // // // //   Future<void> deletePreset(String presetName) async {
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     await prefs.remove('preset_$presetName');
// // // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // // //     names.remove(presetName);
// // // // //     await prefs.setStringList('preset_names', names);
// // // // //     final lastUsed = prefs.getString('last_used_preset');
// // // // //     if (lastUsed == presetName) {
// // // // //       await prefs.remove('last_used_preset');
// // // // //       setState(() {
// // // // //         currentPresetName = null;
// // // // //       });
// // // // //     }
// // // // //   }

// // // // //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// // // // //     try {
// // // // //       final prefs = await SharedPreferences.getInstance();
// // // // //       final jsonString = prefs.getString('preset_$presetName');
// // // // //       if (jsonString == null) return;
// // // // //       final List decoded = jsonDecode(jsonString);
// // // // //       players.clear();
// // // // //       nameControllers.clear();
// // // // //       for (var p in decoded) {
// // // // //         final player = Player.fromJson(p);
// // // // //         players.add(player);
// // // // //         nameControllers.add(TextEditingController(text: player.name));
// // // // //       }
// // // // //       setState(() {
// // // // //         currentPresetName = presetName;
// // // // //       });
// // // // //       if (!autoLoad) {
// // // // //         await prefs.setString('last_used_preset', presetName);
// // // // //       }
// // // // //     } catch (_) {
// // // // //       ScaffoldMessenger.of(
// // // // //         context,
// // // // //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// // // // //     }
// // // // //   }

// // // // //   void showSaveDialog() async {
// // // // //     final controller = TextEditingController();
// // // // //     await showDialog(
// // // // //       context: context,
// // // // //       builder:
// // // // //           (ctx) => AlertDialog(
// // // // //             title: const Text("설정 이름 저장"),
// // // // //             content: TextField(
// // // // //               controller: controller,
// // // // //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// // // // //             ),
// // // // //             actions: [
// // // // //               TextButton(
// // // // //                 onPressed: () async {
// // // // //                   await saveCurrentSettings(controller.text.trim());
// // // // //                   Navigator.of(ctx).pop();
// // // // //                 },
// // // // //                 child: const Text("저장"),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //     );
// // // // //   }

// // // // //   void showLoadDialog() async {
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     final presetNames = prefs.getStringList('preset_names') ?? [];
// // // // //     if (presetNames.isEmpty) {
// // // // //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// // // // //       return;
// // // // //     }
// // // // //     await showDialog(
// // // // //       context: context,
// // // // //       builder:
// // // // //           (ctx) => AlertDialog(
// // // // //             title: const Text("불러올 설정 선택"),
// // // // //             content: SingleChildScrollView(
// // // // //               child: Column(
// // // // //                 mainAxisSize: MainAxisSize.min,
// // // // //                 children:
// // // // //                     presetNames.map((name) {
// // // // //                       return ListTile(
// // // // //                         title: Text(name),
// // // // //                         trailing: IconButton(
// // // // //                           icon: const Icon(Icons.delete, color: Colors.red),
// // // // //                           onPressed: () async {
// // // // //                             Navigator.of(ctx).pop();
// // // // //                             await deletePreset(name);
// // // // //                           },
// // // // //                         ),
// // // // //                         onTap: () async {
// // // // //                           Navigator.of(ctx).pop();
// // // // //                           await loadPreset(name);
// // // // //                         },
// // // // //                       );
// // // // //                     }).toList(),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //     );
// // // // //   }

// // // // //   void clearAllSettings() async {
// // // // //     initializePlayers(2);
// // // // //     final prefs = await SharedPreferences.getInstance();
// // // // //     await prefs.remove('last_used_preset');
// // // // //     setState(() {
// // // // //       currentPresetName = null;
// // // // //     });
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return Scaffold(
// // // // //       appBar: AppBar(
// // // // //         title: Text(
// // // // //           'TimeSquad',
// // // // //           style: TextStyle(
// // // // //             fontSize: 22.sp,
// // // // //             fontWeight: FontWeight.w600,
// // // // //             letterSpacing: 0.8,
// // // // //             color: Colors.black87,
// // // // //           ),
// // // // //         ),
// // // // //         backgroundColor: Colors.white,
// // // // //         elevation: 0,
// // // // //         scrolledUnderElevation: 0.0,
// // // // //         toolbarHeight: 60.h,
// // // // //       ),
// // // // //       resizeToAvoidBottomInset: false, // 키보드 올라올 때 FAB가 밀려 올라가지 않도록 설정
// // // // //       body: SafeArea(
// // // // //         child: SingleChildScrollView(
// // // // //           padding: EdgeInsets.all(24.w),
// // // // //           child: Column(
// // // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // // //             children: [
// // // // //               Row(
// // // // //                 children: [
// // // // //                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
// // // // //                   const Spacer(),
// // // // //                   Row(
// // // // //                     mainAxisSize: MainAxisSize.min,
// // // // //                     children: [
// // // // //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// // // // //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// // // // //                       IconButton(
// // // // //                         icon: const Icon(FeatherIcons.rotateCcw),
// // // // //                         onPressed: clearAllSettings,
// // // // //                       ),
// // // // //                     ],
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               SizedBox(height: 24.h),
// // // // //               ReorderableListView.builder(
// // // // //                 shrinkWrap: true,
// // // // //                 physics: const NeverScrollableScrollPhysics(),
// // // // //                 padding: EdgeInsets.only(bottom: 120.h),
// // // // //                 buildDefaultDragHandles: false,
// // // // //                 proxyDecorator: (child, index, animation) {
// // // // //                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// // // // //                   return ScaleTransition(
// // // // //                     scale: scale,
// // // // //                     child: Material(
// // // // //                       elevation: 0,
// // // // //                       shadowColor: Colors.transparent,
// // // // //                       color: Colors.transparent,
// // // // //                       child: child,
// // // // //                     ),
// // // // //                   );
// // // // //                 },
// // // // //                 itemCount: players.length,
// // // // //                 onReorder: (oldIndex, newIndex) {
// // // // //                   setState(() {
// // // // //                     if (newIndex > oldIndex) newIndex--;
// // // // //                     final player = players.removeAt(oldIndex);
// // // // //                     final controller = nameControllers.removeAt(oldIndex);
// // // // //                     players.insert(newIndex, player);
// // // // //                     nameControllers.insert(newIndex, controller);
// // // // //                   });
// // // // //                 },
// // // // //                 itemBuilder: (context, index) {
// // // // //                   final player = players.elementAt(index);
// // // // //                   const double borderRadius = 20.0;
// // // // //                   const double boxHeight = 48.0; // Name and Time box height

// // // // //                   return ReorderableDelayedDragStartListener(
// // // // //                     key: ValueKey(player),
// // // // //                     index: index,
// // // // //                     child: Padding(
// // // // //                       padding: EdgeInsets.only(bottom: 12.h),
// // // // //                       child: Container(
// // // // //                         margin: EdgeInsets.zero,
// // // // //                         decoration: BoxDecoration(
// // // // //                           color: Color.lerp(Colors.white, player.color, 0.2),
// // // // //                           borderRadius: BorderRadius.circular(borderRadius.r),
// // // // //                         ),
// // // // //                         clipBehavior: Clip.antiAlias,
// // // // //                         child: Dismissible(
// // // // //                           key: ValueKey(player),
// // // // //                           direction: DismissDirection.horizontal,
// // // // //                           background: ClipRRect(
// // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // //                             child: Container(
// // // // //                               alignment: Alignment.centerLeft,
// // // // //                               padding: EdgeInsets.only(left: 20.w),
// // // // //                               color: Colors.white,
// // // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // // //                             ),
// // // // //                           ),
// // // // //                           secondaryBackground: ClipRRect(
// // // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // // //                             child: Container(
// // // // //                               alignment: Alignment.centerRight,
// // // // //                               padding: EdgeInsets.only(right: 20.w),
// // // // //                               color: Colors.white,
// // // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // // //                             ),
// // // // //                           ),
// // // // //                           onDismissed: (_) {
// // // // //                             setState(() {
// // // // //                               players.remove(player);
// // // // //                               nameControllers.removeAt(index);
// // // // //                             });
// // // // //                           },
// // // // //                           child: Container(
// // // // //                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// // // // //                             child: Row(
// // // // //                               children: [
// // // // //                                 Container(
// // // // //                                   width: 40.w,
// // // // //                                   height: 40.w,
// // // // //                                   alignment: Alignment.center,
// // // // //                                   decoration: BoxDecoration(
// // // // //                                     color: Colors.white,
// // // // //                                     shape: BoxShape.circle, // 원형으로 변경
// // // // //                                   ),
// // // // //                                   child: Text(
// // // // //                                     '${index + 1}',
// // // // //                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// // // // //                                   ),
// // // // //                                 ),
// // // // //                                 SizedBox(width: 12.w),
// // // // //                                 Expanded(
// // // // //                                   child: Column(
// // // // //                                     crossAxisAlignment: CrossAxisAlignment.start,
// // // // //                                     children: [
// // // // //                                       Container(
// // // // //                                         height: boxHeight, // 높이 일치
// // // // //                                         decoration: BoxDecoration(
// // // // //                                           color: Colors.white.withOpacity(0.6),
// // // // //                                           borderRadius: BorderRadius.circular(8.r),
// // // // //                                         ),
// // // // //                                         padding: EdgeInsets.symmetric(
// // // // //                                           horizontal: 8.w,
// // // // //                                           vertical: 4.h,
// // // // //                                         ),
// // // // //                                         alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // // // //                                         child: TextField(
// // // // //                                           controller: nameControllers.elementAt(index),
// // // // //                                           onChanged: (val) => players.elementAt(index).name = val,
// // // // //                                           style: TextStyle(
// // // // //                                             fontSize: 16.sp,
// // // // //                                             fontWeight: FontWeight.w500,
// // // // //                                           ),
// // // // //                                           decoration: InputDecoration.collapsed(
// // // // //                                             hintText: 'Enter Name', // 힌트 텍스트 추가
// // // // //                                             hintStyle: TextStyle(
// // // // //                                               color: Colors.grey.shade500,
// // // // //                                               fontSize: 16.sp,
// // // // //                                             ),
// // // // //                                           ),
// // // // //                                         ),
// // // // //                                       ),
// // // // //                                       SizedBox(height: 8.h),
// // // // //                                       GestureDetector(
// // // // //                                         onTap: () async {
// // // // //                                           Duration selectedDuration = Duration(
// // // // //                                             seconds: players.elementAt(index).originalSeconds,
// // // // //                                           );
// // // // //                                           await showModalBottomSheet(
// // // // //                                             context: context,
// // // // //                                             builder:
// // // // //                                                 (context) => SizedBox(
// // // // //                                                   height: 200,
// // // // //                                                   child: CupertinoTimerPicker(
// // // // //                                                     mode: CupertinoTimerPickerMode.hms,
// // // // //                                                     initialTimerDuration:
// // // // //                                                         selectedDuration.inSeconds == 0
// // // // //                                                             ? const Duration(minutes: 10) // 기본값 10분
// // // // //                                                             : selectedDuration,
// // // // //                                                     onTimerDurationChanged: (Duration newDuration) {
// // // // //                                                       setState(() {
// // // // //                                                         players.elementAt(index).seconds =
// // // // //                                                             newDuration.inSeconds;
// // // // //                                                         players.elementAt(index).originalSeconds =
// // // // //                                                             newDuration.inSeconds;
// // // // //                                                       });
// // // // //                                                     },
// // // // //                                                   ),
// // // // //                                                 ),
// // // // //                                           );
// // // // //                                         },
// // // // //                                         child: Container(
// // // // //                                           height: boxHeight, // 높이 일치
// // // // //                                           decoration: BoxDecoration(
// // // // //                                             color: Colors.white.withOpacity(0.6),
// // // // //                                             borderRadius: BorderRadius.circular(8.r),
// // // // //                                           ),
// // // // //                                           padding: EdgeInsets.symmetric(
// // // // //                                             horizontal: 12.w,
// // // // //                                             vertical: 10.h,
// // // // //                                           ),
// // // // //                                           alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // // // //                                           child: Text(
// // // // //                                             players.elementAt(index).originalSeconds == 0
// // // // //                                                 ? 'Set Time' // 초기값이 0일 경우 "Set Time" 표시
// // // // //                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// // // // //                                             style: TextStyle(
// // // // //                                               fontSize: 16.sp,
// // // // //                                               fontWeight: FontWeight.w500,
// // // // //                                               color:
// // // // //                                                   players.elementAt(index).originalSeconds == 0
// // // // //                                                       ? Colors
// // // // //                                                           .grey
// // // // //                                                           .shade500 // 힌트 색상
// // // // //                                                       : Colors.black,
// // // // //                                             ),
// // // // //                                           ),
// // // // //                                         ),
// // // // //                                       ),
// // // // //                                     ],
// // // // //                                   ),
// // // // //                                 ),
// // // // //                                 SizedBox(width: 8.w),
// // // // //                                 ElevatedButton(
// // // // //                                   onPressed: () async {
// // // // //                                     FocusScope.of(context).unfocus();
// // // // //                                     final color = await showDialog<Color>(
// // // // //                                       context: context,
// // // // //                                       builder:
// // // // //                                           (context) => AlertDialog(
// // // // //                                             title: const Text('Select Color'),
// // // // //                                             content: Wrap(
// // // // //                                               spacing: 8.w,
// // // // //                                               children:
// // // // //                                                   Colors.primaries.map((c) {
// // // // //                                                     return GestureDetector(
// // // // //                                                       onTap: () => Navigator.pop(context, c),
// // // // //                                                       child: Container(
// // // // //                                                         width: 30.w,
// // // // //                                                         height: 30.w,
// // // // //                                                         decoration: BoxDecoration(
// // // // //                                                           color: c,
// // // // //                                                           borderRadius: BorderRadius.circular(15.r),
// // // // //                                                         ),
// // // // //                                                       ),
// // // // //                                                     );
// // // // //                                                   }).toList(),
// // // // //                                             ),
// // // // //                                           ),
// // // // //                                     );
// // // // //                                     if (color != null) {
// // // // //                                       setState(() => players.elementAt(index).color = color);
// // // // //                                     }
// // // // //                                   },
// // // // //                                   style: ElevatedButton.styleFrom(
// // // // //                                     backgroundColor: player.color,
// // // // //                                     foregroundColor: Colors.white,
// // // // //                                     shape: RoundedRectangleBorder(
// // // // //                                       borderRadius: BorderRadius.circular(12.r),
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                   child: const Text('Color'),
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),
// // // // //                       ),
// // // // //                     ),
// // // // //                   );
// // // // //                 },
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// // // // //       floatingActionButton: Padding(
// // // // //         padding: EdgeInsets.only(bottom: 16.h),
// // // // //         child: Row(
// // // // //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // // //           children: [
// // // // //             FloatingActionButton.extended(
// // // // //               heroTag: 'addPlayerBtn',
// // // // //               onPressed: addPlayer,
// // // // //               icon: const Icon(Icons.person_add, color: Colors.white),
// // // // //               label: const Text('추가', style: TextStyle(color: Colors.white)),
// // // // //               backgroundColor: Colors.indigo,
// // // // //             ),
// // // // //             FloatingActionButton.extended(
// // // // //               heroTag: 'startBtn',
// // // // //               onPressed: () {
// // // // //                 // 플레이어 이름과 시간이 설정되었는지 확인
// // // // //                 bool allPlayersValid = true;
// // // // //                 for (int i = 0; i < players.length; i++) {
// // // // //                   if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
// // // // //                     allPlayersValid = false;
// // // // //                     break;
// // // // //                   }
// // // // //                 }

// // // // //                 if (allPlayersValid) {
// // // // //                   Navigator.push(
// // // // //                     context,
// // // // //                     MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// // // // //                   );
// // // // //                 } else {
// // // // //                   ScaffoldMessenger.of(
// // // // //                     context,
// // // // //                   ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
// // // // //                 }
// // // // //               },
// // // // //               icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// // // // //               label: const Text('시작', style: TextStyle(color: Colors.white)),
// // // // //               backgroundColor: Colors.teal,
// // // // //             ),
// // // // //           ],
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // // class TimerScreen extends StatefulWidget {
// // // // //   final List<Player> players;
// // // // //   const TimerScreen({super.key, required this.players});

// // // // //   @override
// // // // //   State<TimerScreen> createState() => _TimerScreenState();
// // // // // }

// // // // // class _TimerScreenState extends State<TimerScreen> {
// // // // //   Timer? _timer;
// // // // //   int currentIndex = 0;

// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     startTimer();
// // // // //   }

// // // // //   void startTimer() {
// // // // //     _timer?.cancel();
// // // // //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// // // // //       setState(() {
// // // // //         final player = widget.players.elementAt(currentIndex);
// // // // //         if (player.seconds > 0) {
// // // // //           player.seconds--;
// // // // //           player.elapsedSeconds++;
// // // // //         } else {
// // // // //           player.isCompleted = true;
// // // // //           switchToNextPlayer();
// // // // //         }
// // // // //       });
// // // // //     });
// // // // //   }

// // // // //   void pauseTimer() {
// // // // //     _timer?.cancel();
// // // // //   }

// // // // //   void switchToNextPlayer() {
// // // // //     pauseTimer();
// // // // //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// // // // //       showSummaryDialog();
// // // // //       return;
// // // // //     }
// // // // //     do {
// // // // //       currentIndex = (currentIndex + 1) % widget.players.length;
// // // // //     } while (widget.players.elementAt(currentIndex).isCompleted);
// // // // //     startTimer();
// // // // //   }

// // // // //   void resetAll() {
// // // // //     for (var p in widget.players) {
// // // // //       p.seconds = p.originalSeconds;
// // // // //       p.elapsedSeconds = 0;
// // // // //       p.isCompleted = false;
// // // // //     }
// // // // //     setState(() {
// // // // //       currentIndex = 0;
// // // // //     });
// // // // //     startTimer();
// // // // //   }

// // // // //   String formatDuration(int seconds) {
// // // // //     final d = Duration(seconds: seconds);
// // // // //     final hours = d.inHours.toString().padLeft(2, '0');
// // // // //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// // // // //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// // // // //     return '$hours:$minutes:$secs';
// // // // //   }

// // // // //   void showSummaryDialog() {
// // // // //     _timer?.cancel();
// // // // //     showDialog(
// // // // //       context: context,
// // // // //       builder:
// // // // //           (_) => AlertDialog(
// // // // //             title: const Text('Round Complete'),
// // // // //             content: Column(
// // // // //               mainAxisSize: MainAxisSize.min,
// // // // //               children:
// // // // //                   widget.players.map((p) {
// // // // //                     final formatted = formatDuration(p.elapsedSeconds);
// // // // //                     return Text('${p.name} ⏱ $formatted');
// // // // //                   }).toList(),
// // // // //             ),
// // // // //             actions: [
// // // // //               TextButton(
// // // // //                 onPressed: () {
// // // // //                   Navigator.of(context).pop();
// // // // //                   resetAll();
// // // // //                 },
// // // // //                 child: const Text('Next Round'),
// // // // //               ),
// // // // //               TextButton(
// // // // //                 onPressed: () {
// // // // //                   resetAll();
// // // // //                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // //                 },
// // // // //                 child: const Text('Home'),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //     );
// // // // //   }

// // // // //   @override
// // // // //   void dispose() {
// // // // //     _timer?.cancel();
// // // // //     super.dispose();
// // // // //   }

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     final player = widget.players.elementAt(currentIndex);
// // // // //     return Scaffold(
// // // // //       backgroundColor: player.color,
// // // // //       body: SafeArea(
// // // // //         child: GestureDetector(
// // // // //           behavior: HitTestBehavior.opaque,
// // // // //           onTap: () {
// // // // //             setState(() {
// // // // //               pauseTimer();
// // // // //               switchToNextPlayer();
// // // // //             });
// // // // //           },
// // // // //           child: Stack(
// // // // //             children: [
// // // // //               Center(
// // // // //                 child: Column(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// // // // //                     SizedBox(height: 16.h),
// // // // //                     Text(
// // // // //                       formatDuration(player.seconds),
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 64.sp,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                         color: Colors.white,
// // // // //                       ),
// // // // //                     ),
// // // // //                     SizedBox(height: 24.h),
// // // // //                     ElevatedButton(
// // // // //                       onPressed: () {
// // // // //                         setState(() {
// // // // //                           widget.players.elementAt(currentIndex).isCompleted = true;
// // // // //                           pauseTimer();
// // // // //                           switchToNextPlayer();
// // // // //                         });
// // // // //                       },
// // // // //                       child: const Text('Complete'),
// // // // //                     ),
// // // // //                     SizedBox(height: 12.h),
// // // // //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //               Positioned(
// // // // //                 top: 20.h,
// // // // //                 right: 20.w,
// // // // //                 child: IconButton(
// // // // //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// // // // //                   onPressed: () {
// // // // //                     pauseTimer();
// // // // //                     showDialog(
// // // // //                       context: context,
// // // // //                       builder:
// // // // //                           (context) => AlertDialog(
// // // // //                             title: const Text('홈으로 이동'),
// // // // //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// // // // //                             actions: [
// // // // //                               TextButton(
// // // // //                                 onPressed: () {
// // // // //                                   Navigator.of(context).pop();
// // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // //                                 },
// // // // //                                 child: const Text('설정 유지'),
// // // // //                               ),
// // // // //                               TextButton(
// // // // //                                 onPressed: () {
// // // // //                                   resetAll();
// // // // //                                   Navigator.of(context).pop();
// // // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // // //                                 },
// // // // //                                 child: const Text('초기화 후 이동'),
// // // // //                               ),
// // // // //                             ],
// // // // //                           ),
// // // // //                     );
// // // // //                   },
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         ),
// // // // //       ),
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // // import 'package:flutter/cupertino.dart';
// // // // import 'dart:async';
// // // // import 'dart:convert';
// // // // import 'package:shared_preferences/shared_preferences.dart';
// // // // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // // // void main() async {
// // // //   WidgetsFlutterBinding.ensureInitialized();
// // // //   final prefs = await SharedPreferences.getInstance();
// // // //   final lastUsed = prefs.getString('last_used_preset');
// // // //   runApp(MyApp(lastUsedPreset: lastUsed));
// // // // }

// // // // class MyApp extends StatelessWidget {
// // // //   final String? lastUsedPreset;
// // // //   const MyApp({super.key, this.lastUsedPreset});

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return ScreenUtilInit(
// // // //       designSize: const Size(390, 844),
// // // //       builder:
// // // //           (context, child) => MaterialApp(
// // // //             debugShowCheckedModeBanner: false,
// // // //             title: 'Multi Player Timer',
// // // //             theme: ThemeData(
// // // //               scaffoldBackgroundColor: Colors.white,
// // // //               fontFamily: 'Roboto',
// // // //               textTheme: TextTheme(
// // // //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// // // //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// // // //                 bodyLarge: TextStyle(fontSize: 16.sp),
// // // //               ),
// // // //               elevatedButtonTheme: ElevatedButtonThemeData(
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// // // //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// // // //           ),
// // // //     );
// // // //   }
// // // // }

// // // // class Player {
// // // //   String name;
// // // //   int seconds;
// // // //   int originalSeconds;
// // // //   Color color;
// // // //   bool isCompleted;
// // // //   int elapsedSeconds = 0;

// // // //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// // // //     : originalSeconds = seconds;

// // // //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// // // //   static Player fromJson(Map<String, dynamic> json) =>
// // // //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // // // }

// // // // class PlayerSetupScreen extends StatefulWidget {
// // // //   final String? lastUsedPreset;
// // // //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// // // //   @override
// // // //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // // // }

// // // // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// // // //   final List<Player> players = [];
// // // //   final List<TextEditingController> nameControllers = [];
// // // //   String? currentPresetName;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     if (widget.lastUsedPreset != null) {
// // // //       currentPresetName = widget.lastUsedPreset;
// // // //       loadPreset(widget.lastUsedPreset!, autoLoad: true);
// // // //     } else {
// // // //       initializePlayers(2);
// // // //     }
// // // //   }

// // // //   void initializePlayers(int count) {
// // // //     players.clear();
// // // //     nameControllers.clear();
// // // //     for (int i = 0; i < count; i++) {
// // // //       players.add(Player(name: '', seconds: 0, color: Colors.blue)); // 초기값 변경
// // // //       nameControllers.add(TextEditingController(text: '')); // 초기값 변경
// // // //     }
// // // //     setState(() {});
// // // //   }

// // // //   void addPlayer() {
// // // //     final newIndex = players.length;
// // // //     players.add(Player(name: '', seconds: 0, color: Colors.blue));
// // // //     nameControllers.add(TextEditingController(text: ''));
// // // //     setState(() {});
// // // //   }

// // // //   void removePlayer(int index) {
// // // //     players.removeAt(index);
// // // //     nameControllers.removeAt(index);
// // // //     setState(() {});
// // // //   }

// // // //   Future<void> saveCurrentSettings(String presetName) async {
// // // //     if (presetName.isEmpty) return;
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     final encoded = players.map((p) => p.toJson()).toList();
// // // //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// // // //     await prefs.setString('last_used_preset', presetName);
// // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // //     if (!names.contains(presetName)) {
// // // //       names.add(presetName);
// // // //       await prefs.setStringList('preset_names', names);
// // // //     }
// // // //     setState(() {
// // // //       currentPresetName = presetName;
// // // //     });
// // // //   }

// // // //   Future<void> deletePreset(String presetName) async {
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     await prefs.remove('preset_$presetName');
// // // //     final names = prefs.getStringList('preset_names') ?? [];
// // // //     names.remove(presetName);
// // // //     await prefs.setStringList('preset_names', names);
// // // //     final lastUsed = prefs.getString('last_used_preset');
// // // //     if (lastUsed == presetName) {
// // // //       await prefs.remove('last_used_preset');
// // // //       setState(() {
// // // //         currentPresetName = null;
// // // //       });
// // // //     }
// // // //   }

// // // //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// // // //     try {
// // // //       final prefs = await SharedPreferences.getInstance();
// // // //       final jsonString = prefs.getString('preset_$presetName');
// // // //       if (jsonString == null) return;
// // // //       final List decoded = jsonDecode(jsonString);
// // // //       players.clear();
// // // //       nameControllers.clear();
// // // //       for (var p in decoded) {
// // // //         final player = Player.fromJson(p);
// // // //         players.add(player);
// // // //         nameControllers.add(TextEditingController(text: player.name));
// // // //       }
// // // //       setState(() {
// // // //         currentPresetName = presetName;
// // // //       });
// // // //       if (!autoLoad) {
// // // //         await prefs.setString('last_used_preset', presetName);
// // // //       }
// // // //     } catch (_) {
// // // //       ScaffoldMessenger.of(
// // // //         context,
// // // //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// // // //     }
// // // //   }

// // // //   void showSaveDialog() async {
// // // //     final controller = TextEditingController();
// // // //     await showDialog(
// // // //       context: context,
// // // //       builder:
// // // //           (ctx) => AlertDialog(
// // // //             title: const Text("설정 이름 저장"),
// // // //             content: TextField(
// // // //               controller: controller,
// // // //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// // // //             ),
// // // //             actions: [
// // // //               TextButton(
// // // //                 onPressed: () async {
// // // //                   await saveCurrentSettings(controller.text.trim());
// // // //                   Navigator.of(ctx).pop();
// // // //                 },
// // // //                 child: const Text("저장"),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //     );
// // // //   }

// // // //   void showLoadDialog() async {
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     final presetNames = prefs.getStringList('preset_names') ?? [];
// // // //     if (presetNames.isEmpty) {
// // // //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// // // //       return;
// // // //     }
// // // //     await showDialog(
// // // //       context: context,
// // // //       builder:
// // // //           (ctx) => AlertDialog(
// // // //             title: const Text("불러올 설정 선택"),
// // // //             content: SingleChildScrollView(
// // // //               child: Column(
// // // //                 mainAxisSize: MainAxisSize.min,
// // // //                 children:
// // // //                     presetNames.map((name) {
// // // //                       return ListTile(
// // // //                         title: Text(name),
// // // //                         trailing: IconButton(
// // // //                           icon: const Icon(Icons.delete, color: Colors.red),
// // // //                           onPressed: () async {
// // // //                             Navigator.of(ctx).pop();
// // // //                             await deletePreset(name);
// // // //                           },
// // // //                         ),
// // // //                         onTap: () async {
// // // //                           Navigator.of(ctx).pop();
// // // //                           await loadPreset(name);
// // // //                         },
// // // //                       );
// // // //                     }).toList(),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //     );
// // // //   }

// // // //   void clearAllSettings() async {
// // // //     initializePlayers(2);
// // // //     final prefs = await SharedPreferences.getInstance();
// // // //     await prefs.remove('last_used_preset');
// // // //     setState(() {
// // // //       currentPresetName = null;
// // // //     });
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     // 키보드 가시성 확인
// // // //     final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         title: Text(
// // // //           'TimeSquad',
// // // //           style: TextStyle(
// // // //             fontSize: 22.sp,
// // // //             fontWeight: FontWeight.w900,
// // // //             letterSpacing: 0.8,
// // // //             color: Colors.black87,
// // // //           ),
// // // //         ),
// // // //         backgroundColor: Colors.white,
// // // //         elevation: 0,
// // // //         scrolledUnderElevation: 0.0,
// // // //         toolbarHeight: 40.h,
// // // //       ),
// // // //       resizeToAvoidBottomInset: false, // 키보드 올라올 때 FAB가 밀려 올라가지 않도록 설정
// // // //       body: SafeArea(
// // // //         child: SingleChildScrollView(
// // // //           // 상단 패딩을 16.h로 줄여서 AppBar와의 간격 최적화
// // // //           padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 10.h, bottom: 10.h),
// // // //           child: Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Row(
// // // //                 children: [
// // // //                   Text('Settings', style: TextStyle(fontSize: 19.sp, color: Colors.grey.shade700)),
// // // //                   const Spacer(),
// // // //                   Row(
// // // //                     mainAxisSize: MainAxisSize.min,
// // // //                     children: [
// // // //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// // // //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// // // //                       IconButton(
// // // //                         icon: const Icon(FeatherIcons.rotateCcw),
// // // //                         onPressed: clearAllSettings,
// // // //                       ),
// // // //                     ],
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               SizedBox(height: 16.h), // Settings 라인 아래 간격
// // // //               ReorderableListView.builder(
// // // //                 shrinkWrap: true,
// // // //                 physics: const NeverScrollableScrollPhysics(),
// // // //                 padding: EdgeInsets.only(bottom: 120.h),
// // // //                 buildDefaultDragHandles: false,
// // // //                 proxyDecorator: (child, index, animation) {
// // // //                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// // // //                   return ScaleTransition(
// // // //                     scale: scale,
// // // //                     child: Material(
// // // //                       elevation: 0,
// // // //                       shadowColor: Colors.transparent,
// // // //                       color: Colors.transparent,
// // // //                       child: child,
// // // //                     ),
// // // //                   );
// // // //                 },
// // // //                 itemCount: players.length,
// // // //                 onReorder: (oldIndex, newIndex) {
// // // //                   setState(() {
// // // //                     if (newIndex > oldIndex) newIndex--;
// // // //                     final player = players.removeAt(oldIndex);
// // // //                     final controller = nameControllers.removeAt(oldIndex);
// // // //                     players.insert(newIndex, player);
// // // //                     nameControllers.insert(newIndex, controller);
// // // //                   });
// // // //                 },
// // // //                 itemBuilder: (context, index) {
// // // //                   final player = players.elementAt(index);
// // // //                   const double borderRadius = 20.0;
// // // //                   const double boxHeight = 48.0; // Name and Time box height

// // // //                   return ReorderableDelayedDragStartListener(
// // // //                     key: ValueKey(player),
// // // //                     index: index,
// // // //                     child: Padding(
// // // //                       padding: EdgeInsets.only(bottom: 12.h),
// // // //                       child: Container(
// // // //                         margin: EdgeInsets.zero,
// // // //                         decoration: BoxDecoration(
// // // //                           color: Color.lerp(Colors.white, player.color, 0.2),
// // // //                           borderRadius: BorderRadius.circular(borderRadius.r),
// // // //                           boxShadow: [
// // // //                             // 입체감 추가
// // // //                             BoxShadow(
// // // //                               color: Colors.grey.withOpacity(0.2),
// // // //                               spreadRadius: 1,
// // // //                               blurRadius: 5,
// // // //                               offset: const Offset(0, 3), // changes position of shadow
// // // //                             ),
// // // //                           ],
// // // //                         ),
// // // //                         clipBehavior: Clip.antiAlias,
// // // //                         child: Dismissible(
// // // //                           key: ValueKey(player),
// // // //                           direction: DismissDirection.horizontal,
// // // //                           background: ClipRRect(
// // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // //                             child: Container(
// // // //                               alignment: Alignment.centerLeft,
// // // //                               padding: EdgeInsets.only(left: 20.w),
// // // //                               color: Colors.white,
// // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // //                             ),
// // // //                           ),
// // // //                           secondaryBackground: ClipRRect(
// // // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // // //                             child: Container(
// // // //                               alignment: Alignment.centerRight,
// // // //                               padding: EdgeInsets.only(right: 20.w),
// // // //                               color: Colors.white,
// // // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // // //                             ),
// // // //                           ),
// // // //                           onDismissed: (_) {
// // // //                             setState(() {
// // // //                               players.remove(player);
// // // //                               nameControllers.removeAt(index);
// // // //                             });
// // // //                           },
// // // //                           child: Container(
// // // //                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// // // //                             child: Row(
// // // //                               children: [
// // // //                                 Container(
// // // //                                   width: 40.w,
// // // //                                   height: 40.w,
// // // //                                   alignment: Alignment.center,
// // // //                                   decoration: BoxDecoration(
// // // //                                     color: Colors.white,
// // // //                                     shape: BoxShape.circle, // 원형으로 변경
// // // //                                   ),
// // // //                                   child: Text(
// // // //                                     '${index + 1}',
// // // //                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// // // //                                   ),
// // // //                                 ),
// // // //                                 SizedBox(width: 12.w),
// // // //                                 Expanded(
// // // //                                   child: Column(
// // // //                                     crossAxisAlignment: CrossAxisAlignment.start,
// // // //                                     children: [
// // // //                                       Container(
// // // //                                         height: boxHeight, // 높이 일치
// // // //                                         decoration: BoxDecoration(
// // // //                                           color: Colors.white.withOpacity(0.6),
// // // //                                           borderRadius: BorderRadius.circular(8.r),
// // // //                                         ),
// // // //                                         padding: EdgeInsets.symmetric(
// // // //                                           horizontal: 8.w,
// // // //                                           vertical: 4.h,
// // // //                                         ),
// // // //                                         alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // // //                                         child: TextField(
// // // //                                           controller: nameControllers.elementAt(index),
// // // //                                           onChanged: (val) => players.elementAt(index).name = val,
// // // //                                           style: TextStyle(
// // // //                                             fontSize: 16.sp,
// // // //                                             fontWeight: FontWeight.w500,
// // // //                                           ),
// // // //                                           decoration: InputDecoration.collapsed(
// // // //                                             hintText: 'Enter Name', // 힌트 텍스트 추가
// // // //                                             hintStyle: TextStyle(
// // // //                                               color: Colors.grey.shade500,
// // // //                                               fontSize: 16.sp,
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                       ),
// // // //                                       SizedBox(height: 8.h),
// // // //                                       GestureDetector(
// // // //                                         onTap: () async {
// // // //                                           Duration selectedDuration = Duration(
// // // //                                             seconds: players.elementAt(index).originalSeconds,
// // // //                                           );
// // // //                                           await showModalBottomSheet(
// // // //                                             context: context,
// // // //                                             builder:
// // // //                                                 (context) => SizedBox(
// // // //                                                   height: 200,
// // // //                                                   child: CupertinoTimerPicker(
// // // //                                                     mode: CupertinoTimerPickerMode.hms,
// // // //                                                     initialTimerDuration:
// // // //                                                         selectedDuration.inSeconds == 0
// // // //                                                             ? const Duration(minutes: 10) // 기본값 10분
// // // //                                                             : selectedDuration,
// // // //                                                     onTimerDurationChanged: (Duration newDuration) {
// // // //                                                       setState(() {
// // // //                                                         players.elementAt(index).seconds =
// // // //                                                             newDuration.inSeconds;
// // // //                                                         players.elementAt(index).originalSeconds =
// // // //                                                             newDuration.inSeconds;
// // // //                                                       });
// // // //                                                     },
// // // //                                                   ),
// // // //                                                 ),
// // // //                                           );
// // // //                                         },
// // // //                                         child: Container(
// // // //                                           height: boxHeight, // 높이 일치
// // // //                                           decoration: BoxDecoration(
// // // //                                             color: Colors.white.withOpacity(0.6),
// // // //                                             borderRadius: BorderRadius.circular(8.r),
// // // //                                           ),
// // // //                                           padding: EdgeInsets.symmetric(
// // // //                                             horizontal: 12.w,
// // // //                                             vertical: 10.h,
// // // //                                           ),
// // // //                                           alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // // //                                           child: Text(
// // // //                                             players.elementAt(index).originalSeconds == 0
// // // //                                                 ? 'Set Time' // 초기값이 0일 경우 "Set Time" 표시
// // // //                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// // // //                                             style: TextStyle(
// // // //                                               fontSize: 16.sp,
// // // //                                               fontWeight: FontWeight.w500,
// // // //                                               color:
// // // //                                                   players.elementAt(index).originalSeconds == 0
// // // //                                                       ? Colors
// // // //                                                           .grey
// // // //                                                           .shade500 // 힌트 색상
// // // //                                                       : Colors.black,
// // // //                                             ),
// // // //                                           ),
// // // //                                         ),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                                 SizedBox(width: 8.w),
// // // //                                 ElevatedButton(
// // // //                                   onPressed: () async {
// // // //                                     FocusScope.of(context).unfocus();
// // // //                                     final color = await showDialog<Color>(
// // // //                                       context: context,
// // // //                                       builder:
// // // //                                           (context) => AlertDialog(
// // // //                                             title: const Text('Select Color'),
// // // //                                             content: Wrap(
// // // //                                               spacing: 8.w,
// // // //                                               children:
// // // //                                                   Colors.primaries.map((c) {
// // // //                                                     return GestureDetector(
// // // //                                                       onTap: () => Navigator.pop(context, c),
// // // //                                                       child: Container(
// // // //                                                         width: 30.w,
// // // //                                                         height: 30.w,
// // // //                                                         decoration: BoxDecoration(
// // // //                                                           color: c,
// // // //                                                           borderRadius: BorderRadius.circular(15.r),
// // // //                                                         ),
// // // //                                                       ),
// // // //                                                     );
// // // //                                                   }).toList(),
// // // //                                             ),
// // // //                                           ),
// // // //                                     );
// // // //                                     if (color != null) {
// // // //                                       setState(() => players.elementAt(index).color = color);
// // // //                                     }
// // // //                                   },
// // // //                                   style: ElevatedButton.styleFrom(
// // // //                                     backgroundColor: player.color,
// // // //                                     foregroundColor: Colors.white,
// // // //                                     shape: RoundedRectangleBorder(
// // // //                                       borderRadius: BorderRadius.circular(12.r),
// // // //                                     ),
// // // //                                   ),
// // // //                                   child: const Text('Color'),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //                   );
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// // // //       floatingActionButton: Offstage(
// // // //         // isKeyboardVisible 값에 따라 FAB 숨김
// // // //         offstage: isKeyboardVisible,
// // // //         child: Padding(
// // // //           padding: EdgeInsets.only(bottom: 16.h),
// // // //           child: Row(
// // // //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // // //             children: [
// // // //               FloatingActionButton.extended(
// // // //                 heroTag: 'addPlayerBtn',
// // // //                 onPressed: addPlayer,
// // // //                 icon: const Icon(Icons.person_add, color: Colors.white),
// // // //                 label: const Text('추가', style: TextStyle(color: Colors.white)),
// // // //                 backgroundColor: Colors.indigo,
// // // //               ),
// // // //               FloatingActionButton.extended(
// // // //                 heroTag: 'startBtn',
// // // //                 onPressed: () {
// // // //                   // 플레이어 이름과 시간이 설정되었는지 확인
// // // //                   bool allPlayersValid = true;
// // // //                   for (int i = 0; i < players.length; i++) {
// // // //                     if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
// // // //                       allPlayersValid = false;
// // // //                       break;
// // // //                     }
// // // //                   }

// // // //                   if (allPlayersValid) {
// // // //                     Navigator.push(
// // // //                       context,
// // // //                       MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// // // //                     );
// // // //                   } else {
// // // //                     ScaffoldMessenger.of(
// // // //                       context,
// // // //                     ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
// // // //                   }
// // // //                 },
// // // //                 icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// // // //                 label: const Text('시작', style: TextStyle(color: Colors.white)),
// // // //                 backgroundColor: Colors.teal,
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // class TimerScreen extends StatefulWidget {
// // // //   final List<Player> players;
// // // //   const TimerScreen({super.key, required this.players});

// // // //   @override
// // // //   State<TimerScreen> createState() => _TimerScreenState();
// // // // }

// // // // class _TimerScreenState extends State<TimerScreen> {
// // // //   Timer? _timer;
// // // //   int currentIndex = 0;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     startTimer();
// // // //   }

// // // //   void startTimer() {
// // // //     _timer?.cancel();
// // // //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// // // //       setState(() {
// // // //         final player = widget.players.elementAt(currentIndex);
// // // //         if (player.seconds > 0) {
// // // //           player.seconds--;
// // // //           player.elapsedSeconds++;
// // // //         } else {
// // // //           player.isCompleted = true;
// // // //           switchToNextPlayer();
// // // //         }
// // // //       });
// // // //     });
// // // //   }

// // // //   void pauseTimer() {
// // // //     _timer?.cancel();
// // // //   }

// // // //   void switchToNextPlayer() {
// // // //     pauseTimer();
// // // //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// // // //       showSummaryDialog();
// // // //       return;
// // // //     }
// // // //     do {
// // // //       currentIndex = (currentIndex + 1) % widget.players.length;
// // // //     } while (widget.players.elementAt(currentIndex).isCompleted);
// // // //     startTimer();
// // // //   }

// // // //   void resetAll() {
// // // //     for (var p in widget.players) {
// // // //       p.seconds = p.originalSeconds;
// // // //       p.elapsedSeconds = 0;
// // // //       p.isCompleted = false;
// // // //     }
// // // //     setState(() {
// // // //       currentIndex = 0;
// // // //     });
// // // //     startTimer();
// // // //   }

// // // //   String formatDuration(int seconds) {
// // // //     final d = Duration(seconds: seconds);
// // // //     final hours = d.inHours.toString().padLeft(2, '0');
// // // //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// // // //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// // // //     return '$hours:$minutes:$secs';
// // // //   }

// // // //   void showSummaryDialog() {
// // // //     _timer?.cancel();
// // // //     showDialog(
// // // //       context: context,
// // // //       builder:
// // // //           (_) => AlertDialog(
// // // //             title: const Text('Round Complete'),
// // // //             content: Column(
// // // //               mainAxisSize: MainAxisSize.min,
// // // //               children:
// // // //                   widget.players.map((p) {
// // // //                     final formatted = formatDuration(p.elapsedSeconds);
// // // //                     return Text('${p.name} ⏱ $formatted');
// // // //                   }).toList(),
// // // //             ),
// // // //             actions: [
// // // //               TextButton(
// // // //                 onPressed: () {
// // // //                   Navigator.of(context).pop();
// // // //                   resetAll();
// // // //                 },
// // // //                 child: const Text('Next Round'),
// // // //               ),
// // // //               TextButton(
// // // //                 onPressed: () {
// // // //                   resetAll();
// // // //                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // //                 },
// // // //                 child: const Text('Home'),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //     );
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _timer?.cancel();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final player = widget.players.elementAt(currentIndex);
// // // //     return Scaffold(
// // // //       backgroundColor: player.color,
// // // //       body: SafeArea(
// // // //         child: GestureDetector(
// // // //           behavior: HitTestBehavior.opaque,
// // // //           onTap: () {
// // // //             setState(() {
// // // //               pauseTimer();
// // // //               switchToNextPlayer();
// // // //             });
// // // //           },
// // // //           child: Stack(
// // // //             children: [
// // // //               Center(
// // // //                 child: Column(
// // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                   children: [
// // // //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// // // //                     SizedBox(height: 16.h),
// // // //                     Text(
// // // //                       formatDuration(player.seconds),
// // // //                       style: TextStyle(
// // // //                         fontSize: 64.sp,
// // // //                         fontWeight: FontWeight.bold,
// // // //                         color: Colors.white,
// // // //                       ),
// // // //                     ),
// // // //                     SizedBox(height: 24.h),
// // // //                     ElevatedButton(
// // // //                       onPressed: () {
// // // //                         setState(() {
// // // //                           widget.players.elementAt(currentIndex).isCompleted = true;
// // // //                           pauseTimer();
// // // //                           switchToNextPlayer();
// // // //                         });
// // // //                       },
// // // //                       child: const Text('Complete'),
// // // //                     ),
// // // //                     SizedBox(height: 12.h),
// // // //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Positioned(
// // // //                 top: 20.h,
// // // //                 right: 20.w,
// // // //                 child: IconButton(
// // // //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// // // //                   onPressed: () {
// // // //                     pauseTimer();
// // // //                     showDialog(
// // // //                       context: context,
// // // //                       builder:
// // // //                           (context) => AlertDialog(
// // // //                             title: const Text('홈으로 이동'),
// // // //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// // // //                             actions: [
// // // //                               TextButton(
// // // //                                 onPressed: () {
// // // //                                   Navigator.of(context).pop();
// // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // //                                 },
// // // //                                 child: const Text('설정 유지'),
// // // //                               ),
// // // //                               TextButton(
// // // //                                 onPressed: () {
// // // //                                   resetAll();
// // // //                                   Navigator.of(context).pop();
// // // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // // //                                 },
// // // //                                 child: const Text('초기화 후 이동'),
// // // //                               ),
// // // //                             ],
// // // //                           ),
// // // //                     );
// // // //                   },
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // // import 'package:flutter/cupertino.dart';
// // // import 'dart:async';
// // // import 'dart:convert';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // // void main() async {
// // //   WidgetsFlutterBinding.ensureInitialized();
// // //   final prefs = await SharedPreferences.getInstance();
// // //   final lastUsed = prefs.getString('last_used_preset'); // 마지막 사용된 프리셋 이름 불러오기
// // //   runApp(MyApp(lastUsedPreset: lastUsed));
// // // }

// // // class MyApp extends StatelessWidget {
// // //   final String? lastUsedPreset;
// // //   const MyApp({super.key, this.lastUsedPreset});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return ScreenUtilInit(
// // //       designSize: const Size(390, 844),
// // //       builder:
// // //           (context, child) => MaterialApp(
// // //             debugShowCheckedModeBanner: false,
// // //             title: 'Multi Player Timer',
// // //             theme: ThemeData(
// // //               scaffoldBackgroundColor: Colors.white,
// // //               fontFamily: 'Roboto',
// // //               textTheme: TextTheme(
// // //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// // //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// // //                 bodyLarge: TextStyle(fontSize: 16.sp),
// // //               ),
// // //               elevatedButtonTheme: ElevatedButtonThemeData(
// // //                 style: ElevatedButton.styleFrom(
// // //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// // //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// // //                 ),
// // //               ),
// // //             ),
// // //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// // //           ),
// // //     );
// // //   }
// // // }

// // // class Player {
// // //   String name;
// // //   int seconds;
// // //   int originalSeconds;
// // //   Color color;
// // //   bool isCompleted;
// // //   int elapsedSeconds = 0;

// // //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// // //     : originalSeconds = seconds;

// // //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// // //   static Player fromJson(Map<String, dynamic> json) =>
// // //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // // }

// // // class PlayerSetupScreen extends StatefulWidget {
// // //   final String? lastUsedPreset;
// // //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// // //   @override
// // //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // // }

// // // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// // //   final List<Player> players = [];
// // //   final List<TextEditingController> nameControllers = [];
// // //   String? currentPresetName;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     // 앱 시작 시 lastUsedPreset이 있다면 해당 프리셋을 자동으로 로드합니다.
// // //     if (widget.lastUsedPreset != null) {
// // //       currentPresetName = widget.lastUsedPreset;
// // //       loadPreset(
// // //         widget.lastUsedPreset!,
// // //         autoLoad: true,
// // //       ); // autoLoad: true로 설정하여 last_used_preset을 다시 저장하지 않도록 함
// // //     } else {
// // //       initializePlayers(2); // lastUsedPreset이 없으면 기본 플레이어 2명 초기화
// // //     }
// // //   }

// // //   void initializePlayers(int count) {
// // //     players.clear();
// // //     nameControllers.clear();
// // //     for (int i = 0; i < count; i++) {
// // //       players.add(Player(name: '', seconds: 0, color: Colors.blue)); // 초기값 변경
// // //       nameControllers.add(TextEditingController(text: '')); // 초기값 변경
// // //     }
// // //     setState(() {});
// // //   }

// // //   void addPlayer() {
// // //     final newIndex = players.length;
// // //     players.add(Player(name: '', seconds: 0, color: Colors.blue));
// // //     nameControllers.add(TextEditingController(text: ''));
// // //     setState(() {});
// // //   }

// // //   void removePlayer(int index) {
// // //     players.removeAt(index);
// // //     nameControllers.removeAt(index);
// // //     setState(() {});
// // //   }

// // //   Future<void> saveCurrentSettings(String presetName) async {
// // //     if (presetName.isEmpty) return;
// // //     final prefs = await SharedPreferences.getInstance();
// // //     final encoded = players.map((p) => p.toJson()).toList();
// // //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// // //     await prefs.setString('last_used_preset', presetName); // 마지막 사용된 프리셋으로 저장
// // //     final names = prefs.getStringList('preset_names') ?? [];
// // //     if (!names.contains(presetName)) {
// // //       names.add(presetName);
// // //       await prefs.setStringList('preset_names', names);
// // //     }
// // //     setState(() {
// // //       currentPresetName = presetName;
// // //     });
// // //   }

// // //   Future<void> deletePreset(String presetName) async {
// // //     final prefs = await SharedPreferences.getInstance();
// // //     await prefs.remove('preset_$presetName');
// // //     final names = prefs.getStringList('preset_names') ?? [];
// // //     names.remove(presetName);
// // //     await prefs.setStringList('preset_names', names);
// // //     final lastUsed = prefs.getString('last_used_preset');
// // //     if (lastUsed == presetName) {
// // //       await prefs.remove('last_used_preset'); // 삭제된 프리셋이 마지막 사용된 프리셋이면 초기화
// // //       setState(() {
// // //         currentPresetName = null;
// // //       });
// // //     }
// // //   }

// // //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// // //     try {
// // //       final prefs = await SharedPreferences.getInstance();
// // //       final jsonString = prefs.getString('preset_$presetName');
// // //       if (jsonString == null) {
// // //         if (!autoLoad) {
// // //           // 자동 로드가 아닌 경우에만 스낵바 표시
// // //           ScaffoldMessenger.of(
// // //             context,
// // //           ).showSnackBar(const SnackBar(content: Text("선택한 설정이 존재하지 않습니다.")));
// // //         }
// // //         return;
// // //       }
// // //       final List decoded = jsonDecode(jsonString);
// // //       players.clear();
// // //       nameControllers.clear();
// // //       for (var p in decoded) {
// // //         final player = Player.fromJson(p);
// // //         players.add(player);
// // //         nameControllers.add(TextEditingController(text: player.name));
// // //       }
// // //       setState(() {
// // //         currentPresetName = presetName;
// // //       });
// // //       if (!autoLoad) {
// // //         // 자동 로드가 아닌 경우에만 last_used_preset을 업데이트
// // //         await prefs.setString('last_used_preset', presetName);
// // //       }
// // //     } catch (_) {
// // //       ScaffoldMessenger.of(
// // //         context,
// // //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// // //     }
// // //   }

// // //   void showSaveDialog() async {
// // //     final controller = TextEditingController();
// // //     await showDialog(
// // //       context: context,
// // //       builder:
// // //           (ctx) => AlertDialog(
// // //             title: const Text("설정 이름 저장"),
// // //             content: TextField(
// // //               controller: controller,
// // //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// // //             ),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () async {
// // //                   await saveCurrentSettings(controller.text.trim());
// // //                   Navigator.of(ctx).pop();
// // //                 },
// // //                 child: const Text("저장"),
// // //               ),
// // //             ],
// // //           ),
// // //     );
// // //   }

// // //   void showLoadDialog() async {
// // //     final prefs = await SharedPreferences.getInstance();
// // //     final presetNames = prefs.getStringList('preset_names') ?? [];
// // //     if (presetNames.isEmpty) {
// // //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// // //       return;
// // //     }
// // //     await showDialog(
// // //       context: context,
// // //       builder:
// // //           (ctx) => AlertDialog(
// // //             title: const Text("불러올 설정 선택"),
// // //             content: SingleChildScrollView(
// // //               child: Column(
// // //                 mainAxisSize: MainAxisSize.min,
// // //                 children:
// // //                     presetNames.map((name) {
// // //                       return ListTile(
// // //                         title: Text(name),
// // //                         trailing: IconButton(
// // //                           icon: const Icon(Icons.delete, color: Colors.red),
// // //                           onPressed: () async {
// // //                             Navigator.of(ctx).pop();
// // //                             await deletePreset(name);
// // //                           },
// // //                         ),
// // //                         onTap: () async {
// // //                           Navigator.of(ctx).pop();
// // //                           await loadPreset(name);
// // //                         },
// // //                       );
// // //                     }).toList(),
// // //               ),
// // //             ),
// // //           ),
// // //     );
// // //   }

// // //   void clearAllSettings() async {
// // //     initializePlayers(2);
// // //     final prefs = await SharedPreferences.getInstance();
// // //     await prefs.remove('last_used_preset');
// // //     setState(() {
// // //       currentPresetName = null;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     // 키보드 가시성 확인 및 높이 가져오기
// // //     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
// // //     final bool isKeyboardVisible = keyboardHeight != 0;

// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         title: Text(
// // //           'TimeSquad',
// // //           style: TextStyle(
// // //             fontSize: 22.sp,
// // //             fontWeight: FontWeight.w600,
// // //             letterSpacing: 0.8,
// // //             color: Colors.black87,
// // //           ),
// // //         ),
// // //         backgroundColor: Colors.white,
// // //         elevation: 0,
// // //         scrolledUnderElevation: 0.0,
// // //         toolbarHeight: 60.h,
// // //       ),
// // //       resizeToAvoidBottomInset: true, // 키보드에 따라 body가 리사이즈되도록 허용
// // //       body: SafeArea(
// // //         child: SingleChildScrollView(
// // //           // 상단 패딩을 줄여서 AppBar와의 간격 최적화
// // //           // 키보드 높이만큼 하단 패딩을 동적으로 추가하여 스크롤 가능하게 함
// // //           padding: EdgeInsets.only(
// // //             left: 24.w,
// // //             right: 24.w,
// // //             top: 16.h,
// // //             bottom: 24.h + keyboardHeight, // 키보드 높이만큼 하단 패딩 추가
// // //           ),
// // //           child: Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Row(
// // //                 children: [
// // //                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
// // //                   const Spacer(),
// // //                   Row(
// // //                     mainAxisSize: MainAxisSize.min,
// // //                     children: [
// // //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// // //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// // //                       IconButton(
// // //                         icon: const Icon(FeatherIcons.rotateCcw),
// // //                         onPressed: clearAllSettings,
// // //                       ),
// // //                     ],
// // //                   ),
// // //                 ],
// // //               ),
// // //               SizedBox(height: 16.h), // Settings 라인 아래 간격
// // //               ReorderableListView.builder(
// // //                 shrinkWrap: true,
// // //                 physics: const NeverScrollableScrollPhysics(),
// // //                 // ReorderableListView의 bottom padding을 줄여서 SingleChildScrollView의 역할에 맡김
// // //                 padding: EdgeInsets.only(bottom: 16.h), // FAB가 없을 때의 기본적인 여유 공간
// // //                 buildDefaultDragHandles: false,
// // //                 proxyDecorator: (child, index, animation) {
// // //                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// // //                   return ScaleTransition(
// // //                     scale: scale,
// // //                     child: Material(
// // //                       elevation: 0,
// // //                       shadowColor: Colors.transparent,
// // //                       color: Colors.transparent,
// // //                       child: child,
// // //                     ),
// // //                   );
// // //                 },
// // //                 itemCount: players.length,
// // //                 onReorder: (oldIndex, newIndex) {
// // //                   setState(() {
// // //                     if (newIndex > oldIndex) newIndex--;
// // //                     final player = players.removeAt(oldIndex);
// // //                     final controller = nameControllers.removeAt(oldIndex);
// // //                     players.insert(newIndex, player);
// // //                     nameControllers.insert(newIndex, controller);
// // //                   });
// // //                 },
// // //                 itemBuilder: (context, index) {
// // //                   final player = players.elementAt(index);
// // //                   const double borderRadius = 20.0;
// // //                   const double boxHeight = 48.0; // Name and Time box height

// // //                   return ReorderableDelayedDragStartListener(
// // //                     key: ValueKey(player),
// // //                     index: index,
// // //                     child: Padding(
// // //                       padding: EdgeInsets.only(bottom: 12.h),
// // //                       child: Container(
// // //                         margin: EdgeInsets.zero,
// // //                         decoration: BoxDecoration(
// // //                           color: Color.lerp(Colors.white, player.color, 0.2),
// // //                           borderRadius: BorderRadius.circular(borderRadius.r),
// // //                           boxShadow: [
// // //                             // 입체감 추가
// // //                             BoxShadow(
// // //                               color: Colors.grey.withOpacity(0.2),
// // //                               spreadRadius: 1,
// // //                               blurRadius: 5,
// // //                               offset: const Offset(0, 3), // changes position of shadow
// // //                             ),
// // //                           ],
// // //                         ),
// // //                         clipBehavior: Clip.antiAlias,
// // //                         child: Dismissible(
// // //                           key: ValueKey(player),
// // //                           direction: DismissDirection.horizontal,
// // //                           background: ClipRRect(
// // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // //                             child: Container(
// // //                               alignment: Alignment.centerLeft,
// // //                               padding: EdgeInsets.only(left: 20.w),
// // //                               color: Colors.white,
// // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // //                             ),
// // //                           ),
// // //                           secondaryBackground: ClipRRect(
// // //                             borderRadius: BorderRadius.circular(borderRadius.r),
// // //                             child: Container(
// // //                               alignment: Alignment.centerRight,
// // //                               padding: EdgeInsets.only(right: 20.w),
// // //                               color: Colors.white,
// // //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// // //                             ),
// // //                           ),
// // //                           onDismissed: (_) {
// // //                             setState(() {
// // //                               players.remove(player);
// // //                               nameControllers.removeAt(index);
// // //                             });
// // //                           },
// // //                           child: Container(
// // //                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// // //                             child: Row(
// // //                               children: [
// // //                                 Container(
// // //                                   width: 40.w,
// // //                                   height: 40.w,
// // //                                   alignment: Alignment.center,
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.white,
// // //                                     shape: BoxShape.circle, // 원형으로 변경
// // //                                   ),
// // //                                   child: Text(
// // //                                     '${index + 1}',
// // //                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// // //                                   ),
// // //                                 ),
// // //                                 SizedBox(width: 12.w),
// // //                                 Expanded(
// // //                                   child: Column(
// // //                                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                                     children: [
// // //                                       Container(
// // //                                         height: boxHeight, // 높이 일치
// // //                                         decoration: BoxDecoration(
// // //                                           color: Colors.white.withOpacity(0.6),
// // //                                           borderRadius: BorderRadius.circular(8.r),
// // //                                         ),
// // //                                         padding: EdgeInsets.symmetric(
// // //                                           horizontal: 8.w,
// // //                                           vertical: 4.h,
// // //                                         ),
// // //                                         alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // //                                         child: TextField(
// // //                                           controller: nameControllers.elementAt(index),
// // //                                           onChanged: (val) => players.elementAt(index).name = val,
// // //                                           style: TextStyle(
// // //                                             fontSize: 16.sp,
// // //                                             fontWeight: FontWeight.w500,
// // //                                           ),
// // //                                           decoration: InputDecoration.collapsed(
// // //                                             hintText: 'Enter Name', // 힌트 텍스트 추가
// // //                                             hintStyle: TextStyle(
// // //                                               color: Colors.grey.shade500,
// // //                                               fontSize: 16.sp,
// // //                                             ),
// // //                                           ),
// // //                                         ),
// // //                                       ),
// // //                                       SizedBox(height: 8.h),
// // //                                       GestureDetector(
// // //                                         onTap: () async {
// // //                                           FocusScope.of(context).unfocus(); // 키보드 닫기
// // //                                           Duration selectedDuration = Duration(
// // //                                             seconds: players.elementAt(index).originalSeconds,
// // //                                           );
// // //                                           await showModalBottomSheet(
// // //                                             context: context,
// // //                                             builder:
// // //                                                 (context) => SizedBox(
// // //                                                   height: 200,
// // //                                                   child: CupertinoTimerPicker(
// // //                                                     mode: CupertinoTimerPickerMode.hms,
// // //                                                     initialTimerDuration:
// // //                                                         selectedDuration.inSeconds == 0
// // //                                                             ? const Duration(minutes: 10) // 기본값 10분
// // //                                                             : selectedDuration,
// // //                                                     onTimerDurationChanged: (Duration newDuration) {
// // //                                                       setState(() {
// // //                                                         players.elementAt(index).seconds =
// // //                                                             newDuration.inSeconds;
// // //                                                         players.elementAt(index).originalSeconds =
// // //                                                             newDuration.inSeconds;
// // //                                                       });
// // //                                                     },
// // //                                                   ),
// // //                                                 ),
// // //                                           );
// // //                                         },
// // //                                         child: Container(
// // //                                           height: boxHeight, // 높이 일치
// // //                                           decoration: BoxDecoration(
// // //                                             color: Colors.white.withOpacity(0.6),
// // //                                             borderRadius: BorderRadius.circular(8.r),
// // //                                           ),
// // //                                           padding: EdgeInsets.symmetric(
// // //                                             horizontal: 12.w,
// // //                                             vertical: 10.h,
// // //                                           ),
// // //                                           alignment: Alignment.centerLeft, // 텍스트 중앙 정렬
// // //                                           child: Text(
// // //                                             players.elementAt(index).originalSeconds == 0
// // //                                                 ? 'Set Time' // 초기값이 0일 경우 "Set Time" 표시
// // //                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// // //                                             style: TextStyle(
// // //                                               fontSize: 16.sp,
// // //                                               fontWeight: FontWeight.w500,
// // //                                               color:
// // //                                                   players.elementAt(index).originalSeconds == 0
// // //                                                       ? Colors
// // //                                                           .grey
// // //                                                           .shade500 // 힌트 색상
// // //                                                       : Colors.black,
// // //                                             ),
// // //                                           ),
// // //                                         ),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                                 SizedBox(width: 8.w),
// // //                                 ElevatedButton(
// // //                                   onPressed: () async {
// // //                                     FocusScope.of(context).unfocus(); // 키보드 닫기
// // //                                     final color = await showDialog<Color>(
// // //                                       context: context,
// // //                                       builder:
// // //                                           (context) => AlertDialog(
// // //                                             title: const Text('Select Color'),
// // //                                             content: Wrap(
// // //                                               spacing: 8.w,
// // //                                               children:
// // //                                                   Colors.primaries.map((c) {
// // //                                                     return GestureDetector(
// // //                                                       onTap: () => Navigator.pop(context, c),
// // //                                                       child: Container(
// // //                                                         width: 30.w,
// // //                                                         height: 30.w,
// // //                                                         decoration: BoxDecoration(
// // //                                                           color: c,
// // //                                                           borderRadius: BorderRadius.circular(15.r),
// // //                                                         ),
// // //                                                       ),
// // //                                                     );
// // //                                                   }).toList(),
// // //                                             ),
// // //                                           ),
// // //                                     );
// // //                                     if (color != null) {
// // //                                       setState(() => players.elementAt(index).color = color);
// // //                                     }
// // //                                   },
// // //                                   style: ElevatedButton.styleFrom(
// // //                                     backgroundColor: player.color,
// // //                                     foregroundColor: Colors.white,
// // //                                     shape: RoundedRectangleBorder(
// // //                                       borderRadius: BorderRadius.circular(12.r),
// // //                                     ),
// // //                                   ),
// // //                                   child: const Text('Color'),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),
// // //                       ),
// // //                     ),
// // //                   );
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// // //       floatingActionButton: Offstage(
// // //         // isKeyboardVisible 값에 따라 FAB 숨김
// // //         offstage: isKeyboardVisible,
// // //         child: Padding(
// // //           padding: EdgeInsets.only(bottom: 16.h),
// // //           child: Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //             children: [
// // //               FloatingActionButton.extended(
// // //                 heroTag: 'addPlayerBtn',
// // //                 onPressed: addPlayer,
// // //                 icon: const Icon(Icons.person_add, color: Colors.white),
// // //                 label: const Text('추가', style: TextStyle(color: Colors.white)),
// // //                 backgroundColor: Colors.indigo,
// // //               ),
// // //               FloatingActionButton.extended(
// // //                 heroTag: 'startBtn',
// // //                 onPressed: () {
// // //                   // 플레이어 이름과 시간이 설정되었는지 확인
// // //                   bool allPlayersValid = true;
// // //                   for (int i = 0; i < players.length; i++) {
// // //                     if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
// // //                       allPlayersValid = false;
// // //                       break;
// // //                     }
// // //                   }

// // //                   if (allPlayersValid) {
// // //                     Navigator.push(
// // //                       context,
// // //                       MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// // //                     );
// // //                   } else {
// // //                     ScaffoldMessenger.of(
// // //                       context,
// // //                     ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
// // //                   }
// // //                 },
// // //                 icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// // //                 label: const Text('시작', style: TextStyle(color: Colors.white)),
// // //                 backgroundColor: Colors.teal,
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // // class TimerScreen extends StatefulWidget {
// // //   final List<Player> players;
// // //   const TimerScreen({super.key, required this.players});

// // //   @override
// // //   State<TimerScreen> createState() => _TimerScreenState();
// // // }

// // // class _TimerScreenState extends State<TimerScreen> {
// // //   Timer? _timer;
// // //   int currentIndex = 0;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     startTimer();
// // //   }

// // //   void startTimer() {
// // //     _timer?.cancel();
// // //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// // //       setState(() {
// // //         final player = widget.players.elementAt(currentIndex);
// // //         if (player.seconds > 0) {
// // //           player.seconds--;
// // //           player.elapsedSeconds++;
// // //         } else {
// // //           player.isCompleted = true;
// // //           switchToNextPlayer();
// // //         }
// // //       });
// // //     });
// // //   }

// // //   void pauseTimer() {
// // //     _timer?.cancel();
// // //   }

// // //   void switchToNextPlayer() {
// // //     pauseTimer();
// // //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// // //       showSummaryDialog();
// // //       return;
// // //     }
// // //     do {
// // //       currentIndex = (currentIndex + 1) % widget.players.length;
// // //     } while (widget.players.elementAt(currentIndex).isCompleted);
// // //     startTimer();
// // //   }

// // //   void resetAll() {
// // //     for (var p in widget.players) {
// // //       p.seconds = p.originalSeconds;
// // //       p.elapsedSeconds = 0;
// // //       p.isCompleted = false;
// // //     }
// // //     setState(() {
// // //       currentIndex = 0;
// // //     });
// // //     startTimer();
// // //   }

// // //   String formatDuration(int seconds) {
// // //     final d = Duration(seconds: seconds);
// // //     final hours = d.inHours.toString().padLeft(2, '0');
// // //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// // //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// // //     return '$hours:$minutes:$secs';
// // //   }

// // //   void showSummaryDialog() {
// // //     _timer?.cancel();
// // //     showDialog(
// // //       context: context,
// // //       builder:
// // //           (_) => AlertDialog(
// // //             title: const Text('Round Complete'),
// // //             content: Column(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children:
// // //                   widget.players.map((p) {
// // //                     final formatted = formatDuration(p.elapsedSeconds);
// // //                     return Text('${p.name} ⏱ $formatted');
// // //                   }).toList(),
// // //             ),
// // //             actions: [
// // //               TextButton(
// // //                 onPressed: () {
// // //                   Navigator.of(context).pop();
// // //                   resetAll();
// // //                 },
// // //                 child: const Text('Next Round'),
// // //               ),
// // //               TextButton(
// // //                 onPressed: () {
// // //                   resetAll();
// // //                   Navigator.of(context).popUntil((r) => r.isFirst);
// // //                 },
// // //                 child: const Text('Home'),
// // //               ),
// // //             ],
// // //           ),
// // //     );
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _timer?.cancel();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final player = widget.players.elementAt(currentIndex);
// // //     return Scaffold(
// // //       backgroundColor: player.color,
// // //       body: SafeArea(
// // //         child: GestureDetector(
// // //           behavior: HitTestBehavior.opaque,
// // //           onTap: () {
// // //             setState(() {
// // //               pauseTimer();
// // //               switchToNextPlayer();
// // //             });
// // //           },
// // //           child: Stack(
// // //             children: [
// // //               Center(
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// // //                     SizedBox(height: 16.h),
// // //                     Text(
// // //                       formatDuration(player.seconds),
// // //                       style: TextStyle(
// // //                         fontSize: 64.sp,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.white,
// // //                       ),
// // //                     ),
// // //                     SizedBox(height: 24.h),
// // //                     ElevatedButton(
// // //                       onPressed: () {
// // //                         setState(() {
// // //                           widget.players.elementAt(currentIndex).isCompleted = true;
// // //                           pauseTimer();
// // //                           switchToNextPlayer();
// // //                         });
// // //                       },
// // //                       child: const Text('Complete'),
// // //                     ),
// // //                     SizedBox(height: 12.h),
// // //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Positioned(
// // //                 top: 20.h,
// // //                 right: 20.w,
// // //                 child: IconButton(
// // //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// // //                   onPressed: () {
// // //                     pauseTimer();
// // //                     showDialog(
// // //                       context: context,
// // //                       builder:
// // //                           (context) => AlertDialog(
// // //                             title: const Text('홈으로 이동'),
// // //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// // //                             actions: [
// // //                               TextButton(
// // //                                 onPressed: () {
// // //                                   Navigator.of(context).pop();
// // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // //                                 },
// // //                                 child: const Text('설정 유지'),
// // //                               ),
// // //                               TextButton(
// // //                                 onPressed: () {
// // //                                   resetAll();
// // //                                   Navigator.of(context).pop();
// // //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// // //                                 },
// // //                                 child: const Text('초기화 후 이동'),
// // //                               ),
// // //                             ],
// // //                           ),
// // //                     );
// // //                   },
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'dart:async';
// // import 'dart:convert';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   final prefs = await SharedPreferences.getInstance();
// //   final lastUsed = prefs.getString('last_used_preset'); // 마지막 사용된 프리셋 이름 불러오기
// //   runApp(MyApp(lastUsedPreset: lastUsed));
// // }

// // class MyApp extends StatelessWidget {
// //   final String? lastUsedPreset;
// //   const MyApp({super.key, this.lastUsedPreset});

// //   @override
// //   Widget build(BuildContext context) {
// //     return ScreenUtilInit(
// //       designSize: const Size(390, 844),
// //       builder:
// //           (context, child) => MaterialApp(
// //             debugShowCheckedModeBanner: false,
// //             title: 'Multi Player Timer',
// //             theme: ThemeData(
// //               scaffoldBackgroundColor: Colors.white,
// //               fontFamily: 'Roboto',
// //               textTheme: TextTheme(
// //                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
// //                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
// //                 bodyLarge: TextStyle(fontSize: 16.sp),
// //               ),
// //               elevatedButtonTheme: ElevatedButtonThemeData(
// //                 style: ElevatedButton.styleFrom(
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
// //                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
// //                 ),
// //               ),
// //             ),
// //             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
// //           ),
// //     );
// //   }
// // }

// // class Player {
// //   String name;
// //   int seconds;
// //   int originalSeconds;
// //   Color color;
// //   bool isCompleted;
// //   int elapsedSeconds = 0;

// //   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
// //     : originalSeconds = seconds;

// //   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

// //   static Player fromJson(Map<String, dynamic> json) =>
// //       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// // }

// // class PlayerSetupScreen extends StatefulWidget {
// //   final String? lastUsedPreset;
// //   const PlayerSetupScreen({super.key, this.lastUsedPreset});

// //   @override
// //   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// // }

// // class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
// //   final List<Player> players = [];
// //   final List<TextEditingController> nameControllers = [];
// //   final List<FocusNode> focusNodes = [];
// //   final List<GlobalKey> itemKeys = [];

// //   final ScrollController _scrollController = ScrollController(); // ScrollController 추가

// //   String? currentPresetName;

// //   @override
// //   void initState() {
// //     super.initState();
// //     if (widget.lastUsedPreset != null) {
// //       currentPresetName = widget.lastUsedPreset;
// //       loadPreset(widget.lastUsedPreset!, autoLoad: true);
// //     } else {
// //       initializePlayers(2);
// //     }
// //   }

// //   void initializePlayers(int count) {
// //     players.clear();
// //     nameControllers.clear();
// //     for (var node in focusNodes) node.dispose();
// //     focusNodes.clear();
// //     itemKeys.clear();

// //     for (int i = 0; i < count; i++) {
// //       players.add(Player(name: '', seconds: 0, color: Colors.blue));
// //       nameControllers.add(TextEditingController(text: ''));
// //       final focusNode = FocusNode();
// //       final itemKey = GlobalKey();
// //       focusNode.addListener(() {
// //         if (focusNode.hasFocus) {
// //           _scrollToItem(itemKey);
// //         }
// //       });
// //       focusNodes.add(focusNode);
// //       itemKeys.add(itemKey);
// //     }
// //     setState(() {});
// //   }

// //   void addPlayer() {
// //     final newIndex = players.length;
// //     players.add(Player(name: '', seconds: 0, color: Colors.blue));
// //     nameControllers.add(TextEditingController(text: ''));
// //     final focusNode = FocusNode();
// //     final itemKey = GlobalKey();
// //     focusNode.addListener(() {
// //       if (focusNode.hasFocus) {
// //         _scrollToItem(itemKey);
// //       }
// //     });
// //     focusNodes.add(focusNode);
// //     itemKeys.add(itemKey);
// //     setState(() {
// //       WidgetsBinding.instance.addPostFrameCallback((_) {
// //         _scrollToItem(itemKey);
// //       });
// //     });
// //   }

// //   void removePlayer(int index) {
// //     players.removeAt(index);
// //     nameControllers.removeAt(index);
// //     focusNodes.removeAt(index).dispose();
// //     itemKeys.removeAt(index);
// //     setState(() {});
// //   }

// //   void _scrollToItem(GlobalKey key) {
// //     final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
// //     if (renderBox == null || !_scrollController.hasClients) return;

// //     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
// //     if (keyboardHeight == 0) return;

// //     // 플레이어 카드 위젯의 전역 위치와 크기를 가져옵니다.
// //     final Rect itemRect =
// //         renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject()) & renderBox.size;

// //     // 앱바 높이
// //     final double appBarHeight = AppBar().preferredSize.height;
// //     // SafeArea와 Settings 섹션의 상단 패딩
// //     final double safeAreaTopPadding = MediaQuery.of(context).padding.top;
// //     final double settingsTopPadding = 16.h;
// //     // 'Settings' 텍스트와 아이콘이 있는 Row의 높이 (대략적인 값)
// //     final double settingsRowHeight = 30.h;

// //     // 스크롤 가능한 뷰의 보이는 영역 (키보드를 제외한 부분)
// //     final double visibleHeight = MediaQuery.of(context).size.height - keyboardHeight;

// //     // 스크롤 상한선 (앱 바와 설정 섹션 아래)
// //     final double maxScrollableTop =
// //         appBarHeight + safeAreaTopPadding + settingsTopPadding + settingsRowHeight;

// //     // 아이템의 상단이 maxScrollableTop보다 위에 있다면 (즉, 가려져 있다면)
// //     if (itemRect.top < maxScrollableTop) {
// //       // 아이템의 상단이 maxScrollableTop에 오도록 스크롤합니다.
// //       _scrollController.animateTo(
// //         _scrollController.offset + (itemRect.top - maxScrollableTop),
// //         duration: const Duration(milliseconds: 200),
// //         curve: Curves.easeOut,
// //       );
// //     } else if (itemRect.bottom > visibleHeight) {
// //       // 아이템의 하단이 키보드 위에 오도록 스크롤합니다.
// //       _scrollController.animateTo(
// //         _scrollController.offset + (itemRect.bottom - visibleHeight),
// //         duration: const Duration(milliseconds: 200),
// //         curve: Curves.easeOut,
// //       );
// //     }
// //   }

// //   Future<void> saveCurrentSettings(String presetName) async {
// //     if (presetName.isEmpty) return;
// //     final prefs = await SharedPreferences.getInstance();
// //     final encoded = players.map((p) => p.toJson()).toList();
// //     await prefs.setString('preset_$presetName', jsonEncode(encoded));
// //     await prefs.setString('last_used_preset', presetName);
// //     final names = prefs.getStringList('preset_names') ?? [];
// //     if (!names.contains(presetName)) {
// //       names.add(presetName);
// //       await prefs.setStringList('preset_names', names);
// //     }
// //     setState(() {
// //       currentPresetName = presetName;
// //     });
// //   }

// //   Future<void> deletePreset(String presetName) async {
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.remove('preset_$presetName');
// //     final names = prefs.getStringList('preset_names') ?? [];
// //     names.remove(presetName);
// //     await prefs.setStringList('preset_names', names);
// //     final lastUsed = prefs.getString('last_used_preset');
// //     if (lastUsed == presetName) {
// //       await prefs.remove('last_used_preset');
// //       setState(() {
// //         currentPresetName = null;
// //       });
// //     }
// //   }

// //   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
// //     try {
// //       final prefs = await SharedPreferences.getInstance();
// //       final jsonString = prefs.getString('preset_$presetName');
// //       if (jsonString == null) {
// //         if (!autoLoad) {
// //           ScaffoldMessenger.of(
// //             context,
// //           ).showSnackBar(const SnackBar(content: Text("선택한 설정이 존재하지 않습니다.")));
// //         }
// //         return;
// //       }
// //       for (var node in focusNodes) node.dispose();
// //       players.clear();
// //       nameControllers.clear();
// //       focusNodes.clear();
// //       itemKeys.clear();

// //       final List decoded = jsonDecode(jsonString);
// //       for (var p in decoded) {
// //         final player = Player.fromJson(p);
// //         players.add(player);
// //         nameControllers.add(TextEditingController(text: player.name));
// //         final focusNode = FocusNode();
// //         final itemKey = GlobalKey();
// //         focusNode.addListener(() {
// //           if (focusNode.hasFocus) {
// //             _scrollToItem(itemKey);
// //           }
// //         });
// //         focusNodes.add(focusNode);
// //         itemKeys.add(itemKey);
// //       }
// //       setState(() {
// //         currentPresetName = presetName;
// //       });
// //       if (!autoLoad) {
// //         await prefs.setString('last_used_preset', presetName);
// //       }
// //     } catch (_) {
// //       ScaffoldMessenger.of(
// //         context,
// //       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
// //     }
// //   }

// //   void showSaveDialog() async {
// //     final controller = TextEditingController();
// //     await showDialog(
// //       context: context,
// //       builder:
// //           (ctx) => AlertDialog(
// //             title: const Text("설정 이름 저장"),
// //             content: TextField(
// //               controller: controller,
// //               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () async {
// //                   await saveCurrentSettings(controller.text.trim());
// //                   Navigator.of(ctx).pop();
// //                 },
// //                 child: const Text("저장"),
// //               ),
// //             ],
// //           ),
// //     );
// //   }

// //   void showLoadDialog() async {
// //     final prefs = await SharedPreferences.getInstance();
// //     final presetNames = prefs.getStringList('preset_names') ?? [];
// //     if (presetNames.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
// //       return;
// //     }
// //     await showDialog(
// //       context: context,
// //       builder:
// //           (ctx) => AlertDialog(
// //             title: const Text("불러올 설정 선택"),
// //             content: SingleChildScrollView(
// //               child: Column(
// //                 mainAxisSize: MainAxisSize.min,
// //                 children:
// //                     presetNames.map((name) {
// //                       return ListTile(
// //                         title: Text(name),
// //                         trailing: IconButton(
// //                           icon: const Icon(Icons.delete, color: Colors.red),
// //                           onPressed: () async {
// //                             Navigator.of(ctx).pop();
// //                             await deletePreset(name);
// //                           },
// //                         ),
// //                         onTap: () async {
// //                           Navigator.of(ctx).pop();
// //                           await loadPreset(name);
// //                         },
// //                       );
// //                     }).toList(),
// //               ),
// //             ),
// //           ),
// //     );
// //   }

// //   void clearAllSettings() async {
// //     initializePlayers(2);
// //     final prefs = await SharedPreferences.getInstance();
// //     await prefs.remove('last_used_preset');
// //     setState(() {
// //       currentPresetName = null;
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     for (var node in focusNodes) {
// //       node.dispose();
// //     }
// //     for (var controller in nameControllers) {
// //       controller.dispose();
// //     }
// //     _scrollController.dispose(); // ScrollController dispose
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
// //     final bool isKeyboardVisible = keyboardHeight != 0;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'TimeSquad',
// //           style: TextStyle(
// //             fontSize: 22.sp,
// //             fontWeight: FontWeight.w600,
// //             letterSpacing: 0.8,
// //             color: Colors.black87,
// //           ),
// //         ),
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         scrolledUnderElevation: 0.0,
// //         toolbarHeight: 60.h,
// //       ),
// //       resizeToAvoidBottomInset: true,
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           controller: _scrollController, // ScrollController 연결
// //           padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h, bottom: keyboardHeight),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Row(
// //                 children: [
// //                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
// //                   const Spacer(),
// //                   Row(
// //                     mainAxisSize: MainAxisSize.min,
// //                     children: [
// //                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
// //                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
// //                       IconButton(
// //                         icon: const Icon(FeatherIcons.rotateCcw),
// //                         onPressed: clearAllSettings,
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               ),
// //               SizedBox(height: 16.h),
// //               ReorderableListView.builder(
// //                 shrinkWrap: true,
// //                 physics: const NeverScrollableScrollPhysics(),
// //                 padding: EdgeInsets.only(bottom: 16.h),
// //                 buildDefaultDragHandles: false,
// //                 proxyDecorator: (child, index, animation) {
// //                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
// //                   return ScaleTransition(
// //                     scale: scale,
// //                     child: Material(
// //                       elevation: 0,
// //                       shadowColor: Colors.transparent,
// //                       color: Colors.transparent,
// //                       child: child,
// //                     ),
// //                   );
// //                 },
// //                 itemCount: players.length,
// //                 onReorder: (oldIndex, newIndex) {
// //                   setState(() {
// //                     if (newIndex > oldIndex) newIndex--;
// //                     final player = players.removeAt(oldIndex);
// //                     final controller = nameControllers.removeAt(oldIndex);
// //                     final focusNode = focusNodes.removeAt(oldIndex);
// //                     final itemKey = itemKeys.removeAt(oldIndex);

// //                     players.insert(newIndex, player);
// //                     nameControllers.insert(newIndex, controller);
// //                     focusNodes.insert(newIndex, focusNode);
// //                     itemKeys.insert(newIndex, itemKey);
// //                   });
// //                 },
// //                 itemBuilder: (context, index) {
// //                   final player = players.elementAt(index);
// //                   const double borderRadius = 20.0;
// //                   const double boxHeight = 48.0;

// //                   return ReorderableDelayedDragStartListener(
// //                     key: itemKeys[index],
// //                     index: index,
// //                     child: Padding(
// //                       padding: EdgeInsets.only(bottom: 12.h),
// //                       child: Container(
// //                         margin: EdgeInsets.zero,
// //                         decoration: BoxDecoration(
// //                           color: Color.lerp(Colors.white, player.color, 0.2),
// //                           borderRadius: BorderRadius.circular(borderRadius.r),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.grey.withOpacity(0.2),
// //                               spreadRadius: 1,
// //                               blurRadius: 5,
// //                               offset: const Offset(0, 3),
// //                             ),
// //                           ],
// //                         ),
// //                         clipBehavior: Clip.antiAlias,
// //                         child: Dismissible(
// //                           key: ValueKey(player),
// //                           direction: DismissDirection.horizontal,
// //                           background: ClipRRect(
// //                             borderRadius: BorderRadius.circular(borderRadius.r),
// //                             child: Container(
// //                               alignment: Alignment.centerLeft,
// //                               padding: EdgeInsets.only(left: 20.w),
// //                               color: Colors.white,
// //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// //                             ),
// //                           ),
// //                           secondaryBackground: ClipRRect(
// //                             borderRadius: BorderRadius.circular(borderRadius.r),
// //                             child: Container(
// //                               alignment: Alignment.centerRight,
// //                               padding: EdgeInsets.only(right: 20.w),
// //                               color: Colors.white,
// //                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
// //                             ),
// //                           ),
// //                           onDismissed: (_) {
// //                             removePlayer(index);
// //                           },
// //                           child: Container(
// //                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// //                             child: Row(
// //                               children: [
// //                                 Container(
// //                                   width: 40.w,
// //                                   height: 40.w,
// //                                   alignment: Alignment.center,
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     shape: BoxShape.circle,
// //                                   ),
// //                                   child: Text(
// //                                     '${index + 1}',
// //                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 12.w),
// //                                 Expanded(
// //                                   child: Column(
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       Container(
// //                                         height: boxHeight,
// //                                         decoration: BoxDecoration(
// //                                           color: Colors.white.withOpacity(0.6),
// //                                           borderRadius: BorderRadius.circular(8.r),
// //                                         ),
// //                                         padding: EdgeInsets.symmetric(
// //                                           horizontal: 8.w,
// //                                           vertical: 4.h,
// //                                         ),
// //                                         alignment: Alignment.centerLeft,
// //                                         child: TextField(
// //                                           controller: nameControllers.elementAt(index),
// //                                           focusNode: focusNodes.elementAt(index),
// //                                           onChanged: (val) => players.elementAt(index).name = val,
// //                                           style: TextStyle(
// //                                             fontSize: 16.sp,
// //                                             fontWeight: FontWeight.w500,
// //                                           ),
// //                                           decoration: InputDecoration.collapsed(
// //                                             hintText: 'Enter Name',
// //                                             hintStyle: TextStyle(
// //                                               color: Colors.grey.shade500,
// //                                               fontSize: 16.sp,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       SizedBox(height: 8.h),
// //                                       GestureDetector(
// //                                         onTap: () async {
// //                                           FocusScope.of(context).unfocus();
// //                                           Duration selectedDuration = Duration(
// //                                             seconds: players.elementAt(index).originalSeconds,
// //                                           );
// //                                           await showModalBottomSheet(
// //                                             context: context,
// //                                             builder:
// //                                                 (context) => SizedBox(
// //                                                   height: 200,
// //                                                   child: CupertinoTimerPicker(
// //                                                     mode: CupertinoTimerPickerMode.hms,
// //                                                     initialTimerDuration:
// //                                                         selectedDuration.inSeconds == 0
// //                                                             ? const Duration(minutes: 10)
// //                                                             : selectedDuration,
// //                                                     onTimerDurationChanged: (Duration newDuration) {
// //                                                       setState(() {
// //                                                         players.elementAt(index).seconds =
// //                                                             newDuration.inSeconds;
// //                                                         players.elementAt(index).originalSeconds =
// //                                                             newDuration.inSeconds;
// //                                                       });
// //                                                     },
// //                                                   ),
// //                                                 ),
// //                                           );
// //                                         },
// //                                         child: Container(
// //                                           height: boxHeight,
// //                                           decoration: BoxDecoration(
// //                                             color: Colors.white.withOpacity(0.6),
// //                                             borderRadius: BorderRadius.circular(8.r),
// //                                           ),
// //                                           padding: EdgeInsets.symmetric(
// //                                             horizontal: 12.w,
// //                                             vertical: 10.h,
// //                                           ),
// //                                           alignment: Alignment.centerLeft,
// //                                           child: Text(
// //                                             players.elementAt(index).originalSeconds == 0
// //                                                 ? 'Set Time'
// //                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
// //                                             style: TextStyle(
// //                                               fontSize: 16.sp,
// //                                               fontWeight: FontWeight.w500,
// //                                               color:
// //                                                   players.elementAt(index).originalSeconds == 0
// //                                                       ? Colors.grey.shade500
// //                                                       : Colors.black,
// //                                             ),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 SizedBox(width: 8.w),
// //                                 ElevatedButton(
// //                                   onPressed: () async {
// //                                     FocusScope.of(context).unfocus();
// //                                     final color = await showDialog<Color>(
// //                                       context: context,
// //                                       builder:
// //                                           (context) => AlertDialog(
// //                                             title: const Text('Select Color'),
// //                                             content: Wrap(
// //                                               spacing: 8.w,
// //                                               children:
// //                                                   Colors.primaries.map((c) {
// //                                                     return GestureDetector(
// //                                                       onTap: () => Navigator.pop(context, c),
// //                                                       child: Container(
// //                                                         width: 30.w,
// //                                                         height: 30.w,
// //                                                         decoration: BoxDecoration(
// //                                                           color: c,
// //                                                           borderRadius: BorderRadius.circular(15.r),
// //                                                         ),
// //                                                       ),
// //                                                     );
// //                                                   }).toList(),
// //                                             ),
// //                                           ),
// //                                     );
// //                                     if (color != null) {
// //                                       setState(() => players.elementAt(index).color = color);
// //                                     }
// //                                   },
// //                                   style: ElevatedButton.styleFrom(
// //                                     backgroundColor: player.color,
// //                                     foregroundColor: Colors.white,
// //                                     shape: RoundedRectangleBorder(
// //                                       borderRadius: BorderRadius.circular(12.r),
// //                                     ),
// //                                   ),
// //                                   child: const Text('Color'),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //       floatingActionButton: Offstage(
// //         offstage: isKeyboardVisible,
// //         child: Padding(
// //           padding: EdgeInsets.only(bottom: 16.h),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               FloatingActionButton.extended(
// //                 heroTag: 'addPlayerBtn',
// //                 onPressed: addPlayer,
// //                 icon: const Icon(Icons.person_add, color: Colors.white),
// //                 label: const Text('추가', style: TextStyle(color: Colors.white)),
// //                 backgroundColor: Colors.indigo,
// //               ),
// //               FloatingActionButton.extended(
// //                 heroTag: 'startBtn',
// //                 onPressed: () {
// //                   bool allPlayersValid = true;
// //                   for (int i = 0; i < players.length; i++) {
// //                     if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
// //                       allPlayersValid = false;
// //                       break;
// //                     }
// //                   }

// //                   if (allPlayersValid) {
// //                     Navigator.push(
// //                       context,
// //                       MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
// //                     );
// //                   } else {
// //                     ScaffoldMessenger.of(
// //                       context,
// //                     ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
// //                   }
// //                 },
// //                 icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
// //                 label: const Text('시작', style: TextStyle(color: Colors.white)),
// //                 backgroundColor: Colors.teal,
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class TimerScreen extends StatefulWidget {
// //   final List<Player> players;
// //   const TimerScreen({super.key, required this.players});

// //   @override
// //   State<TimerScreen> createState() => _TimerScreenState();
// // }

// // class _TimerScreenState extends State<TimerScreen> {
// //   Timer? _timer;
// //   int currentIndex = 0;

// //   @override
// //   void initState() {
// //     super.initState();
// //     startTimer();
// //   }

// //   void startTimer() {
// //     _timer?.cancel();
// //     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
// //       setState(() {
// //         final player = widget.players.elementAt(currentIndex);
// //         if (player.seconds > 0) {
// //           player.seconds--;
// //           player.elapsedSeconds++;
// //         } else {
// //           player.isCompleted = true;
// //           switchToNextPlayer();
// //         }
// //       });
// //     });
// //   }

// //   void pauseTimer() {
// //     _timer?.cancel();
// //   }

// //   void switchToNextPlayer() {
// //     pauseTimer();
// //     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
// //       showSummaryDialog();
// //       return;
// //     }
// //     do {
// //       currentIndex = (currentIndex + 1) % widget.players.length;
// //     } while (widget.players.elementAt(currentIndex).isCompleted);
// //     startTimer();
// //   }

// //   void resetAll() {
// //     for (var p in widget.players) {
// //       p.seconds = p.originalSeconds;
// //       p.elapsedSeconds = 0;
// //       p.isCompleted = false;
// //     }
// //     setState(() {
// //       currentIndex = 0;
// //     });
// //     startTimer();
// //   }

// //   String formatDuration(int seconds) {
// //     final d = Duration(seconds: seconds);
// //     final hours = d.inHours.toString().padLeft(2, '0');
// //     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
// //     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
// //     return '$hours:$minutes:$secs';
// //   }

// //   void showSummaryDialog() {
// //     _timer?.cancel();
// //     showDialog(
// //       context: context,
// //       builder:
// //           (_) => AlertDialog(
// //             title: const Text('Round Complete'),
// //             content: Column(
// //               mainAxisSize: MainAxisSize.min,
// //               children:
// //                   widget.players.map((p) {
// //                     final formatted = formatDuration(p.elapsedSeconds);
// //                     return Text('${p.name} ⏱ $formatted');
// //                   }).toList(),
// //             ),
// //             actions: [
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.of(context).pop();
// //                   resetAll();
// //                 },
// //                 child: const Text('Next Round'),
// //               ),
// //               TextButton(
// //                 onPressed: () {
// //                   resetAll();
// //                   Navigator.of(context).popUntil((r) => r.isFirst);
// //                 },
// //                 child: const Text('Home'),
// //               ),
// //             ],
// //           ),
// //     );
// //   }

// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final player = widget.players.elementAt(currentIndex);
// //     return Scaffold(
// //       backgroundColor: player.color,
// //       body: SafeArea(
// //         child: GestureDetector(
// //           behavior: HitTestBehavior.opaque,
// //           onTap: () {
// //             setState(() {
// //               pauseTimer();
// //               switchToNextPlayer();
// //             });
// //           },
// //           child: Stack(
// //             children: [
// //               Center(
// //                 child: Column(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
// //                     SizedBox(height: 16.h),
// //                     Text(
// //                       formatDuration(player.seconds),
// //                       style: TextStyle(
// //                         fontSize: 64.sp,
// //                         fontWeight: FontWeight.bold,
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                     SizedBox(height: 24.h),
// //                     ElevatedButton(
// //                       onPressed: () {
// //                         setState(() {
// //                           widget.players.elementAt(currentIndex).isCompleted = true;
// //                           pauseTimer();
// //                           switchToNextPlayer();
// //                         });
// //                       },
// //                       child: const Text('Complete'),
// //                     ),
// //                     SizedBox(height: 12.h),
// //                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
// //                   ],
// //                 ),
// //               ),
// //               Positioned(
// //                 top: 20.h,
// //                 right: 20.w,
// //                 child: IconButton(
// //                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
// //                   onPressed: () {
// //                     pauseTimer();
// //                     showDialog(
// //                       context: context,
// //                       builder:
// //                           (context) => AlertDialog(
// //                             title: const Text('홈으로 이동'),
// //                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
// //                             actions: [
// //                               TextButton(
// //                                 onPressed: () {
// //                                   Navigator.of(context).pop();
// //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// //                                 },
// //                                 child: const Text('설정 유지'),
// //                               ),
// //                               TextButton(
// //                                 onPressed: () {
// //                                   resetAll();
// //                                   Navigator.of(context).pop();
// //                                   Navigator.of(context).popUntil((r) => r.isFirst);
// //                                 },
// //                                 child: const Text('초기화 후 이동'),
// //                               ),
// //                             ],
// //                           ),
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/cupertino.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final lastUsed = prefs.getString('last_used_preset'); // 마지막 사용된 프리셋 이름 불러오기
//   runApp(MyApp(lastUsedPreset: lastUsed));
// }

// class MyApp extends StatelessWidget {
//   final String? lastUsedPreset;
//   const MyApp({super.key, this.lastUsedPreset});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       builder:
//           (context, child) => MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Multi Player Timer',
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.white,
//               fontFamily: 'Roboto',
//               textTheme: TextTheme(
//                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
//                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
//                 bodyLarge: TextStyle(fontSize: 16.sp),
//               ),
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
//                 ),
//               ),
//             ),
//             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
//           ),
//     );
//   }
// }

// class Player {
//   String name;
//   int seconds;
//   int originalSeconds;
//   Color color;
//   bool isCompleted;
//   int elapsedSeconds = 0;

//   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
//     : originalSeconds = seconds;

//   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

//   static Player fromJson(Map<String, dynamic> json) =>
//       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// }

// class PlayerSetupScreen extends StatefulWidget {
//   final String? lastUsedPreset;
//   const PlayerSetupScreen({super.key, this.lastUsedPreset});

//   @override
//   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// }

// class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
//   final List<Player> players = [];
//   final List<TextEditingController> nameControllers = [];
//   final List<FocusNode> focusNodes = [];
//   final List<GlobalKey> itemKeys = [];

//   final ScrollController _scrollController = ScrollController(); // ScrollController 추가

//   String? currentPresetName;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.lastUsedPreset != null) {
//       currentPresetName = widget.lastUsedPreset;
//       loadPreset(widget.lastUsedPreset!, autoLoad: true);
//     } else {
//       initializePlayers(2);
//     }
//   }

//   void initializePlayers(int count) {
//     players.clear();
//     nameControllers.clear();
//     for (var node in focusNodes) node.dispose();
//     focusNodes.clear();
//     itemKeys.clear();

//     for (int i = 0; i < count; i++) {
//       players.add(Player(name: '', seconds: 0, color: Colors.blue));
//       nameControllers.add(TextEditingController(text: ''));
//       final focusNode = FocusNode();
//       final itemKey = GlobalKey();
//       focusNode.addListener(() {
//         if (focusNode.hasFocus) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _scrollToItem(itemKey);
//           });
//         }
//       });
//       focusNodes.add(focusNode);
//       itemKeys.add(itemKey);
//     }
//     setState(() {});
//   }

//   void addPlayer() {
//     final newIndex = players.length;
//     players.add(Player(name: '', seconds: 0, color: Colors.blue));
//     nameControllers.add(TextEditingController(text: ''));
//     final focusNode = FocusNode();
//     final itemKey = GlobalKey();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _scrollToItem(itemKey);
//         });
//       }
//     });
//     focusNodes.add(focusNode);
//     itemKeys.add(itemKey);
//     setState(() {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollToItem(itemKey);
//       });
//     });
//   }

//   void removePlayer(int index) {
//     players.removeAt(index);
//     nameControllers.removeAt(index);
//     focusNodes.removeAt(index).dispose();
//     itemKeys.removeAt(index);
//     setState(() {});
//   }

//   void _scrollToItem(GlobalKey key) {
//     final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null || !_scrollController.hasClients) return;

//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     if (keyboardHeight == 0) return; // 키보드가 없으면 스크롤할 필요 없음

//     // 현재 위젯의 화면 상에서의 위치와 크기
//     final Rect itemRect =
//         renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject()) & renderBox.size;

//     // 현재 스크롤 뷰의 보이는 영역 (키보드를 제외한 부분)
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double bottomPadding = MediaQuery.of(context).padding.bottom; // SafeArea bottom padding
//     final double viewportBottom = screenHeight - keyboardHeight; // 키보드 상단

//     // 앱바 높이
//     final double appBarHeight = AppBar().preferredSize.height;
//     // SafeArea 상단 패딩
//     final double safeAreaTopPadding = MediaQuery.of(context).padding.top;
//     // Settings 텍스트와 아이콘 Row의 높이 (대략적인 값, 실제 측정 필요 시 GlobalKey 사용)
//     final double settingsRowHeight = 30.h;
//     // SingleChildScrollView의 top 패딩
//     final double singleChildScrollViewTopPadding = 16.h;

//     // 상단 UI 요소들이 가려지지 않고 보존되어야 하는 최소 Y 좌표
//     // (앱바 하단 + SafeArea 상단 패딩 + SingleChildScrollView 상단 패딩 + Settings Row 높이)
//     final double minimumVisibleY =
//         appBarHeight + safeAreaTopPadding + singleChildScrollViewTopPadding + settingsRowHeight;

//     double targetOffset = _scrollController.offset;

//     // 플레이어 카드의 하단이 키보드 상단(viewportBottom)에 맞춰지도록 스크롤 오프셋 조정
//     // 현재 스크롤 오프셋 + (플레이어 카드의 하단 Y 좌표 - 뷰포트의 하단 Y 좌표)
//     final double requiredScrollForBottom = itemRect.bottom - viewportBottom;
//     if (requiredScrollForBottom > 0) {
//       // 위젯이 키보드에 가려진 경우
//       targetOffset = _scrollController.offset + requiredScrollForBottom;
//     } else if (itemRect.top < minimumVisibleY) {
//       // 위젯이 상단 UI에 가려진 경우 (하단을 맞추고 나니 상단이 가려진 경우)
//       // 이 경우, 상단이 minimumVisibleY에 맞춰지도록 스크롤 오프셋을 조정
//       targetOffset = _scrollController.offset - (minimumVisibleY - itemRect.top);
//     }

//     // 스크롤 가능한 최대 범위와 최소 범위로 클램프
//     targetOffset = targetOffset.clamp(
//       _scrollController.position.minScrollExtent,
//       _scrollController.position.maxScrollExtent,
//     );

//     // 스크롤 실행
//     _scrollController.animateTo(
//       targetOffset,
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeOut,
//     );
//   }

//   Future<void> saveCurrentSettings(String presetName) async {
//     if (presetName.isEmpty) return;
//     final prefs = await SharedPreferences.getInstance();
//     final encoded = players.map((p) => p.toJson()).toList();
//     await prefs.setString('preset_$presetName', jsonEncode(encoded));
//     await prefs.setString('last_used_preset', presetName);
//     final names = prefs.getStringList('preset_names') ?? [];
//     if (!names.contains(presetName)) {
//       names.add(presetName);
//       await prefs.setStringList('preset_names', names);
//     }
//     setState(() {
//       currentPresetName = presetName;
//     });
//   }

//   Future<void> deletePreset(String presetName) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('preset_$presetName');
//     final names = prefs.getStringList('preset_names') ?? [];
//     names.remove(presetName);
//     await prefs.setStringList('preset_names', names);
//     final lastUsed = prefs.getString('last_used_preset');
//     if (lastUsed == presetName) {
//       await prefs.remove('last_used_preset');
//       setState(() {
//         currentPresetName = null;
//       });
//     }
//   }

//   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final jsonString = prefs.getString('preset_$presetName');
//       if (jsonString == null) {
//         if (!autoLoad) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text("선택한 설정이 존재하지 않습니다.")));
//         }
//         return;
//       }
//       for (var node in focusNodes) node.dispose();
//       players.clear();
//       nameControllers.clear();
//       focusNodes.clear();
//       itemKeys.clear();

//       final List decoded = jsonDecode(jsonString);
//       for (var p in decoded) {
//         final player = Player.fromJson(p);
//         players.add(player);
//         nameControllers.add(TextEditingController(text: player.name));
//         final focusNode = FocusNode();
//         final itemKey = GlobalKey();
//         focusNode.addListener(() {
//           if (focusNode.hasFocus) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _scrollToItem(itemKey);
//             });
//           }
//         });
//         focusNodes.add(focusNode);
//         itemKeys.add(itemKey);
//       }
//       setState(() {
//         currentPresetName = presetName;
//       });
//       if (!autoLoad) {
//         await prefs.setString('last_used_preset', presetName);
//       }
//     } catch (_) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
//     }
//   }

//   void showSaveDialog() async {
//     final controller = TextEditingController();
//     await showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text("설정 이름 저장"),
//             content: TextField(
//               controller: controller,
//               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   await saveCurrentSettings(controller.text.trim());
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text("저장"),
//               ),
//             ],
//           ),
//     );
//   }

//   void showLoadDialog() async {
//     final prefs = await SharedPreferences.getInstance();
//     final presetNames = prefs.getStringList('preset_names') ?? [];
//     if (presetNames.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
//       return;
//     }
//     await showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text("불러올 설정 선택"),
//             content: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children:
//                     presetNames.map((name) {
//                       return ListTile(
//                         title: Text(name),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () async {
//                             Navigator.of(ctx).pop();
//                             await deletePreset(name);
//                           },
//                         ),
//                         onTap: () async {
//                           Navigator.of(ctx).pop();
//                           await loadPreset(name);
//                         },
//                       );
//                     }).toList(),
//               ),
//             ),
//           ),
//     );
//   }

//   void clearAllSettings() async {
//     initializePlayers(2);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('last_used_preset');
//     setState(() {
//       currentPresetName = null;
//     });
//   }

//   @override
//   void dispose() {
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     for (var controller in nameControllers) {
//       controller.dispose();
//     }
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     final bool isKeyboardVisible = keyboardHeight != 0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'TimeSquad',
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.8,
//             color: Colors.black87,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0.0,
//         toolbarHeight: 60.h,
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           controller: _scrollController, // ScrollController 연결
//           padding: EdgeInsets.only(
//             left: 24.w,
//             right: 24.w,
//             top: 16.h,
//             bottom: keyboardHeight, // 키보드 높이만큼 하단 패딩 추가
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
//                   const Spacer(),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
//                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
//                       IconButton(
//                         icon: const Icon(FeatherIcons.rotateCcw),
//                         onPressed: clearAllSettings,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               ReorderableListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.only(bottom: 16.h), // 플레이어 카드 사이의 간격과 하단 여백
//                 buildDefaultDragHandles: false,
//                 proxyDecorator: (child, index, animation) {
//                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
//                   return ScaleTransition(
//                     scale: scale,
//                     child: Material(
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                       color: Colors.transparent,
//                       child: child,
//                     ),
//                   );
//                 },
//                 itemCount: players.length,
//                 onReorder: (oldIndex, newIndex) {
//                   setState(() {
//                     if (newIndex > oldIndex) newIndex--;
//                     final player = players.removeAt(oldIndex);
//                     final controller = nameControllers.removeAt(oldIndex);
//                     final focusNode = focusNodes.removeAt(oldIndex);
//                     final itemKey = itemKeys.removeAt(oldIndex);

//                     players.insert(newIndex, player);
//                     nameControllers.insert(newIndex, controller);
//                     focusNodes.insert(newIndex, focusNode);
//                     itemKeys.insert(newIndex, itemKey);
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   final player = players.elementAt(index);
//                   const double borderRadius = 20.0;
//                   const double boxHeight = 48.0;

//                   return ReorderableDelayedDragStartListener(
//                     key: itemKeys[index],
//                     index: index,
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 12.h),
//                       child: Container(
//                         margin: EdgeInsets.zero,
//                         decoration: BoxDecoration(
//                           color: Color.lerp(Colors.white, player.color, 0.2),
//                           borderRadius: BorderRadius.circular(borderRadius.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Dismissible(
//                           key: ValueKey(player),
//                           direction: DismissDirection.horizontal,
//                           background: ClipRRect(
//                             borderRadius: BorderRadius.circular(borderRadius.r),
//                             child: Container(
//                               alignment: Alignment.centerLeft,
//                               padding: EdgeInsets.only(left: 20.w),
//                               color: Colors.white,
//                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
//                             ),
//                           ),
//                           secondaryBackground: ClipRRect(
//                             borderRadius: BorderRadius.circular(borderRadius.r),
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               padding: EdgeInsets.only(right: 20.w),
//                               color: Colors.white,
//                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
//                             ),
//                           ),
//                           onDismissed: (_) {
//                             removePlayer(index);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 40.w,
//                                   height: 40.w,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Text(
//                                     '${index + 1}',
//                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 SizedBox(width: 12.w),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: boxHeight,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withOpacity(0.6),
//                                           borderRadius: BorderRadius.circular(8.r),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 8.w,
//                                           vertical: 4.h,
//                                         ),
//                                         alignment: Alignment.centerLeft,
//                                         child: TextField(
//                                           controller: nameControllers.elementAt(index),
//                                           focusNode: focusNodes.elementAt(index),
//                                           onChanged: (val) => players.elementAt(index).name = val,
//                                           style: TextStyle(
//                                             fontSize: 16.sp,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                           decoration: InputDecoration.collapsed(
//                                             hintText: 'Enter Name',
//                                             hintStyle: TextStyle(
//                                               color: Colors.grey.shade500,
//                                               fontSize: 16.sp,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: 8.h),
//                                       GestureDetector(
//                                         onTap: () async {
//                                           FocusScope.of(context).unfocus();
//                                           Duration selectedDuration = Duration(
//                                             seconds: players.elementAt(index).originalSeconds,
//                                           );
//                                           await showModalBottomSheet(
//                                             context: context,
//                                             builder:
//                                                 (context) => SizedBox(
//                                                   height: 200,
//                                                   child: CupertinoTimerPicker(
//                                                     mode: CupertinoTimerPickerMode.hms,
//                                                     initialTimerDuration:
//                                                         selectedDuration.inSeconds == 0
//                                                             ? const Duration(minutes: 10)
//                                                             : selectedDuration,
//                                                     onTimerDurationChanged: (Duration newDuration) {
//                                                       setState(() {
//                                                         players.elementAt(index).seconds =
//                                                             newDuration.inSeconds;
//                                                         players.elementAt(index).originalSeconds =
//                                                             newDuration.inSeconds;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                           );
//                                         },
//                                         child: Container(
//                                           height: boxHeight,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.6),
//                                             borderRadius: BorderRadius.circular(8.r),
//                                           ),
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 12.w,
//                                             vertical: 10.h,
//                                           ),
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             players.elementAt(index).originalSeconds == 0
//                                                 ? 'Set Time'
//                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
//                                             style: TextStyle(
//                                               fontSize: 16.sp,
//                                               fontWeight: FontWeight.w500,
//                                               color:
//                                                   players.elementAt(index).originalSeconds == 0
//                                                       ? Colors.grey.shade500
//                                                       : Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     FocusScope.of(context).unfocus();
//                                     final color = await showDialog<Color>(
//                                       context: context,
//                                       builder:
//                                           (context) => AlertDialog(
//                                             title: const Text('Select Color'),
//                                             content: Wrap(
//                                               spacing: 8.w,
//                                               children:
//                                                   Colors.primaries.map((c) {
//                                                     return GestureDetector(
//                                                       onTap: () => Navigator.pop(context, c),
//                                                       child: Container(
//                                                         width: 30.w,
//                                                         height: 30.w,
//                                                         decoration: BoxDecoration(
//                                                           color: c,
//                                                           borderRadius: BorderRadius.circular(15.r),
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                             ),
//                                           ),
//                                     );
//                                     if (color != null) {
//                                       setState(() => players.elementAt(index).color = color);
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: player.color,
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//                                   ),
//                                   child: const Text('Color'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Offstage(
//         offstage: isKeyboardVisible,
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 16.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FloatingActionButton.extended(
//                 heroTag: 'addPlayerBtn',
//                 onPressed: addPlayer,
//                 icon: const Icon(Icons.person_add, color: Colors.white),
//                 label: const Text('추가', style: TextStyle(color: Colors.white)),
//                 backgroundColor: Colors.indigo,
//               ),
//               FloatingActionButton.extended(
//                 heroTag: 'startBtn',
//                 onPressed: () {
//                   bool allPlayersValid = true;
//                   for (int i = 0; i < players.length; i++) {
//                     if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
//                       allPlayersValid = false;
//                       break;
//                     }
//                   }

//                   if (allPlayersValid) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(
//                       context,
//                     ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
//                   }
//                 },
//                 icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
//                 label: const Text('시작', style: TextStyle(color: Colors.white)),
//                 backgroundColor: Colors.teal,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TimerScreen extends StatefulWidget {
//   final List<Player> players;
//   const TimerScreen({super.key, required this.players});

//   @override
//   State<TimerScreen> createState() => _TimerScreenState();
// }

// class _TimerScreenState extends State<TimerScreen> {
//   Timer? _timer;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }

//   void startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       setState(() {
//         final player = widget.players.elementAt(currentIndex);
//         if (player.seconds > 0) {
//           player.seconds--;
//           player.elapsedSeconds++;
//         } else {
//           player.isCompleted = true;
//           switchToNextPlayer();
//         }
//       });
//     });
//   }

//   void pauseTimer() {
//     _timer?.cancel();
//   }

//   void switchToNextPlayer() {
//     pauseTimer();
//     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
//       showSummaryDialog();
//       return;
//     }
//     do {
//       currentIndex = (currentIndex + 1) % widget.players.length;
//     } while (widget.players.elementAt(currentIndex).isCompleted);
//     startTimer();
//   }

//   void resetAll() {
//     for (var p in widget.players) {
//       p.seconds = p.originalSeconds;
//       p.elapsedSeconds = 0;
//       p.isCompleted = false;
//     }
//     setState(() {
//       currentIndex = 0;
//     });
//     startTimer();
//   }

//   String formatDuration(int seconds) {
//     final d = Duration(seconds: seconds);
//     final hours = d.inHours.toString().padLeft(2, '0');
//     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
//     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
//     return '$hours:$minutes:$secs';
//   }

//   void showSummaryDialog() {
//     _timer?.cancel();
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Round Complete'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children:
//                   widget.players.map((p) {
//                     final formatted = formatDuration(p.elapsedSeconds);
//                     return Text('${p.name} ⏱ $formatted');
//                   }).toList(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   resetAll();
//                 },
//                 child: const Text('Next Round'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   resetAll();
//                   Navigator.of(context).popUntil((r) => r.isFirst);
//                 },
//                 child: const Text('Home'),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final player = widget.players.elementAt(currentIndex);
//     return Scaffold(
//       backgroundColor: player.color,
//       body: SafeArea(
//         child: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             setState(() {
//               pauseTimer();
//               switchToNextPlayer();
//             });
//           },
//           child: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
//                     SizedBox(height: 16.h),
//                     Text(
//                       formatDuration(player.seconds),
//                       style: TextStyle(
//                         fontSize: 64.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           widget.players.elementAt(currentIndex).isCompleted = true;
//                           pauseTimer();
//                           switchToNextPlayer();
//                         });
//                       },
//                       child: const Text('Complete'),
//                     ),
//                     SizedBox(height: 12.h),
//                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 20.h,
//                 right: 20.w,
//                 child: IconButton(
//                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
//                   onPressed: () {
//                     pauseTimer();
//                     showDialog(
//                       context: context,
//                       builder:
//                           (context) => AlertDialog(
//                             title: const Text('홈으로 이동'),
//                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context).popUntil((r) => r.isFirst);
//                                 },
//                                 child: const Text('설정 유지'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   resetAll();
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context).popUntil((r) => r.isFirst);
//                                 },
//                                 child: const Text('초기화 후 이동'),
//                               ),
//                             ],
//                           ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// 설정창 세로모드만, Timer창 가로 모드 지원 버전

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/cupertino.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter/services.dart'; // SystemChrome을 사용하기 위한 import

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final lastUsed = prefs.getString('last_used_preset'); // 마지막 사용된 프리셋 이름 불러오기
//   runApp(MyApp(lastUsedPreset: lastUsed));
// }

// class MyApp extends StatelessWidget {
//   final String? lastUsedPreset;
//   const MyApp({super.key, this.lastUsedPreset});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       builder:
//           (context, child) => MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Multi Player Timer',
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.white,
//               fontFamily: 'Roboto',
//               textTheme: TextTheme(
//                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
//                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
//                 bodyLarge: TextStyle(fontSize: 16.sp),
//               ),
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
//                 ),
//               ),
//             ),
//             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
//           ),
//     );
//   }
// }

// class Player {
//   String name;
//   int seconds;
//   int originalSeconds;
//   Color color;
//   bool isCompleted;
//   int elapsedSeconds = 0;

//   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
//     : originalSeconds = seconds;

//   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

//   static Player fromJson(Map<String, dynamic> json) =>
//       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// }

// class PlayerSetupScreen extends StatefulWidget {
//   final String? lastUsedPreset;
//   const PlayerSetupScreen({super.key, this.lastUsedPreset});

//   @override
//   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// }

// class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
//   final List<Player> players = [];
//   final List<TextEditingController> nameControllers = [];
//   final List<FocusNode> focusNodes = [];
//   final List<GlobalKey> itemKeys = [];

//   final ScrollController _scrollController = ScrollController(); // ScrollController 추가

//   String? currentPresetName;

//   @override
//   void initState() {
//     super.initState();
//     // PlayerSetupScreen (Settings Screen) 진입 시 세로 모드로 고정
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     if (widget.lastUsedPreset != null) {
//       currentPresetName = widget.lastUsedPreset;
//       loadPreset(widget.lastUsedPreset!, autoLoad: true);
//     } else {
//       initializePlayers(2);
//     }
//   }

//   void initializePlayers(int count) {
//     players.clear();
//     nameControllers.clear();
//     for (var node in focusNodes) node.dispose();
//     focusNodes.clear();
//     itemKeys.clear();

//     for (int i = 0; i < count; i++) {
//       players.add(Player(name: '', seconds: 0, color: Colors.blue));
//       nameControllers.add(TextEditingController(text: ''));
//       final focusNode = FocusNode();
//       final itemKey = GlobalKey();
//       focusNode.addListener(() {
//         if (focusNode.hasFocus) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _scrollToItem(itemKey);
//           });
//         }
//       });
//       focusNodes.add(focusNode);
//       itemKeys.add(itemKey);
//     }
//     setState(() {});
//   }

//   void addPlayer() {
//     final newIndex = players.length;
//     players.add(Player(name: '', seconds: 0, color: Colors.blue));
//     nameControllers.add(TextEditingController(text: ''));
//     final focusNode = FocusNode();
//     final itemKey = GlobalKey();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _scrollToItem(itemKey);
//         });
//       }
//     });
//     focusNodes.add(focusNode);
//     itemKeys.add(itemKey);
//     setState(() {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollToItem(itemKey);
//       });
//     });
//   }

//   void removePlayer(int index) {
//     players.removeAt(index);
//     nameControllers.removeAt(index);
//     focusNodes.removeAt(index).dispose();
//     itemKeys.removeAt(index);
//     setState(() {});
//   }

//   void _scrollToItem(GlobalKey key) {
//     final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null || !_scrollController.hasClients) return;

//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     if (keyboardHeight == 0) return; // 키보드가 없으면 스크롤할 필요 없음

//     // 현재 위젯의 화면 상에서의 위치와 크기
//     final Rect itemRect =
//         renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject()) & renderBox.size;

//     // 현재 스크롤 뷰의 보이는 영역 (키보드를 제외한 부분)
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double bottomPadding = MediaQuery.of(context).padding.bottom; // SafeArea bottom padding
//     final double viewportBottom = screenHeight - keyboardHeight; // 키보드 상단

//     // 앱바 높이
//     final double appBarHeight = AppBar().preferredSize.height;
//     // SafeArea 상단 패딩
//     final double safeAreaTopPadding = MediaQuery.of(context).padding.top;
//     // Settings 텍스트와 아이콘 Row의 높이 (대략적인 값, 실제 측정 필요 시 GlobalKey 사용)
//     final double settingsRowHeight = 30.h;
//     // SingleChildScrollView의 top 패딩
//     final double singleChildScrollViewTopPadding = 16.h;

//     // 상단 UI 요소들이 가려지지 않고 보존되어야 하는 최소 Y 좌표
//     // (앱바 하단 + SafeArea 상단 패딩 + SingleChildScrollView 상단 패딩 + Settings Row 높이)
//     final double minimumVisibleY =
//         appBarHeight + safeAreaTopPadding + singleChildScrollViewTopPadding + settingsRowHeight;

//     double targetOffset = _scrollController.offset;

//     // 플레이어 카드의 하단이 키보드 상단(viewportBottom)에 맞춰지도록 스크롤 오프셋 조정
//     // 현재 스크롤 오프셋 + (플레이어 카드의 하단 Y 좌표 - 뷰포트의 하단 Y 좌표)
//     final double requiredScrollForBottom = itemRect.bottom - viewportBottom;
//     if (requiredScrollForBottom > 0) {
//       // 위젯이 키보드에 가려진 경우
//       targetOffset = _scrollController.offset + requiredScrollForBottom;
//     }
//     // 2. 위젯의 상단이 앱바나 설정 섹션에 가려지는 경우 (하단을 맞추고 나니 상단이 가려진 경우)
//     // 이 부분은 위 1번 로직이 우선적으로 수행된 후, 만약 그 결과로 상단이 너무 올라갔을 때만 적용
//     final currentItemTop =
//         itemRect.top -
//         (_scrollController.offset - targetOffset); // 새로운 targetOffset 적용 시 아이템의 예상 top 위치
//     if (currentItemTop < minimumVisibleY) {
//       // 위젯의 상단이 minimumVisibleY에 맞춰지도록 스크롤을 조정
//       targetOffset = _scrollController.offset - (minimumVisibleY - itemRect.top);
//     }

//     // 스크롤 가능한 최대 범위와 최소 범위로 클램프
//     targetOffset = targetOffset.clamp(
//       _scrollController.position.minScrollExtent,
//       _scrollController.position.maxScrollExtent,
//     );

//     // 스크롤 실행
//     _scrollController.animateTo(
//       targetOffset,
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeOut,
//     );
//   }

//   Future<void> saveCurrentSettings(String presetName) async {
//     if (presetName.isEmpty) return;
//     final prefs = await SharedPreferences.getInstance();
//     final encoded = players.map((p) => p.toJson()).toList();
//     await prefs.setString('preset_$presetName', jsonEncode(encoded));
//     await prefs.setString(
//       'last_used_preset',
//       presetName,
//     ); // 현재 저장하는 프리셋 이름을 'last_used_preset'으로 저장
//     final names = prefs.getStringList('preset_names') ?? [];
//     if (!names.contains(presetName)) {
//       names.add(presetName);
//       await prefs.setStringList('preset_names', names);
//     }
//     setState(() {
//       currentPresetName = presetName;
//     });
//   }

//   Future<void> deletePreset(String presetName) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('preset_$presetName');
//     final names = prefs.getStringList('preset_names') ?? [];
//     names.remove(presetName);
//     await prefs.setStringList('preset_names', names);
//     final lastUsed = prefs.getString('last_used_preset');
//     if (lastUsed == presetName) {
//       await prefs.remove('last_used_preset');
//       setState(() {
//         currentPresetName = null;
//       });
//     }
//   }

//   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final jsonString = prefs.getString('preset_$presetName');
//       if (jsonString == null) {
//         if (!autoLoad) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text("선택한 설정이 존재하지 않습니다.")));
//         }
//         return;
//       }
//       for (var node in focusNodes) node.dispose();
//       players.clear();
//       nameControllers.clear();
//       focusNodes.clear();
//       itemKeys.clear();

//       final List decoded = jsonDecode(jsonString);
//       for (var p in decoded) {
//         final player = Player.fromJson(p);
//         players.add(player);
//         nameControllers.add(TextEditingController(text: player.name));
//         final focusNode = FocusNode();
//         final itemKey = GlobalKey();
//         focusNode.addListener(() {
//           if (focusNode.hasFocus) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _scrollToItem(itemKey);
//             });
//           }
//         });
//         focusNodes.add(focusNode);
//         itemKeys.add(itemKey);
//       }
//       setState(() {
//         currentPresetName = presetName;
//       });
//       if (!autoLoad) {
//         await prefs.setString('last_used_preset', presetName);
//       }
//     } catch (_) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
//     }
//   }

//   void showSaveDialog() async {
//     final controller = TextEditingController();
//     await showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text("설정 이름 저장"),
//             content: TextField(
//               controller: controller,
//               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   await saveCurrentSettings(controller.text.trim());
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text("저장"),
//               ),
//             ],
//           ),
//     );
//   }

//   void showLoadDialog() async {
//     final prefs = await SharedPreferences.getInstance();
//     final presetNames = prefs.getStringList('preset_names') ?? [];
//     if (presetNames.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
//       return;
//     }
//     await showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text("불러올 설정 선택"),
//             content: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children:
//                     presetNames.map((name) {
//                       return ListTile(
//                         title: Text(name),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () async {
//                             Navigator.of(ctx).pop();
//                             await deletePreset(name);
//                           },
//                         ),
//                         onTap: () async {
//                           Navigator.of(ctx).pop();
//                           await loadPreset(name);
//                         },
//                       );
//                     }).toList(),
//               ),
//             ),
//           ),
//     );
//   }

//   void clearAllSettings() async {
//     initializePlayers(2);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('last_used_preset');
//     setState(() {
//       currentPresetName = null;
//     });
//   }

//   @override
//   void dispose() {
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     for (var controller in nameControllers) {
//       controller.dispose();
//     }
//     _scrollController.dispose();
//     // PlayerSetupScreen (Settings Screen)을 떠날 때,
//     // 앱의 기본 방향(세로 고정)으로 되돌리는 것은 TimerScreen에서 모든 방향을 지원하기 때문에
//     // 여기서는 특별히 변경할 필요가 없습니다. TimerScreen의 dispose에서 다시 설정될 것입니다.
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     final bool isKeyboardVisible = keyboardHeight != 0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'TimeSquad',
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.8,
//             color: Colors.black87,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0.0,
//         toolbarHeight: 60.h,
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           controller: _scrollController, // ScrollController 연결
//           padding: EdgeInsets.only(
//             left: 24.w,
//             right: 24.w,
//             top: 16.h,
//             bottom: keyboardHeight, // 키보드 높이만큼 하단 패딩 추가
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
//                   const Spacer(),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
//                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
//                       IconButton(
//                         icon: const Icon(FeatherIcons.rotateCcw),
//                         onPressed: clearAllSettings,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               ReorderableListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.only(bottom: 16.h), // 플레이어 카드 사이의 간격과 하단 여백
//                 buildDefaultDragHandles: false,
//                 proxyDecorator: (child, index, animation) {
//                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
//                   return ScaleTransition(
//                     scale: scale,
//                     child: Material(
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                       color: Colors.transparent,
//                       child: child,
//                     ),
//                   );
//                 },
//                 itemCount: players.length,
//                 onReorder: (oldIndex, newIndex) {
//                   setState(() {
//                     if (newIndex > oldIndex) newIndex--;
//                     final player = players.removeAt(oldIndex);
//                     final controller = nameControllers.removeAt(oldIndex);
//                     final focusNode = focusNodes.removeAt(oldIndex);
//                     final itemKey = itemKeys.removeAt(oldIndex);

//                     players.insert(newIndex, player);
//                     nameControllers.insert(newIndex, controller);
//                     focusNodes.insert(newIndex, focusNode);
//                     itemKeys.insert(newIndex, itemKey);
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   final player = players.elementAt(index);
//                   const double borderRadius = 20.0;
//                   const double boxHeight = 48.0;

//                   return ReorderableDelayedDragStartListener(
//                     key: itemKeys[index],
//                     index: index,
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 12.h),
//                       child: Container(
//                         margin: EdgeInsets.zero,
//                         decoration: BoxDecoration(
//                           color: Color.lerp(Colors.white, player.color, 0.2),
//                           borderRadius: BorderRadius.circular(borderRadius.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Dismissible(
//                           key: ValueKey(player),
//                           direction: DismissDirection.horizontal,
//                           background: ClipRRect(
//                             borderRadius: BorderRadius.circular(borderRadius.r),
//                             child: Container(
//                               alignment: Alignment.centerLeft,
//                               padding: EdgeInsets.only(left: 20.w),
//                               color: Colors.white,
//                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
//                             ),
//                           ),
//                           secondaryBackground: ClipRRect(
//                             borderRadius: BorderRadius.circular(borderRadius.r),
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               padding: EdgeInsets.only(right: 20.w),
//                               color: Colors.white,
//                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
//                             ),
//                           ),
//                           onDismissed: (_) {
//                             removePlayer(index);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 40.w,
//                                   height: 40.w,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Text(
//                                     '${index + 1}',
//                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 SizedBox(width: 12.w),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: boxHeight,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withOpacity(0.6),
//                                           borderRadius: BorderRadius.circular(8.r),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 8.w,
//                                           vertical: 4.h,
//                                         ),
//                                         alignment: Alignment.centerLeft,
//                                         child: TextField(
//                                           controller: nameControllers.elementAt(index),
//                                           focusNode: focusNodes.elementAt(index),
//                                           onChanged: (val) => players.elementAt(index).name = val,
//                                           style: TextStyle(
//                                             fontSize: 16.sp,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                           decoration: InputDecoration.collapsed(
//                                             hintText: 'Enter Name',
//                                             hintStyle: TextStyle(
//                                               color: Colors.grey.shade500,
//                                               fontSize: 16.sp,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: 8.h),
//                                       GestureDetector(
//                                         onTap: () async {
//                                           FocusScope.of(context).unfocus();
//                                           Duration selectedDuration = Duration(
//                                             seconds: players.elementAt(index).originalSeconds,
//                                           );
//                                           await showModalBottomSheet(
//                                             context: context,
//                                             builder:
//                                                 (context) => SizedBox(
//                                                   height: 200,
//                                                   child: CupertinoTimerPicker(
//                                                     mode: CupertinoTimerPickerMode.hms,
//                                                     initialTimerDuration:
//                                                         selectedDuration.inSeconds == 0
//                                                             ? const Duration(minutes: 10)
//                                                             : selectedDuration,
//                                                     onTimerDurationChanged: (Duration newDuration) {
//                                                       setState(() {
//                                                         players.elementAt(index).seconds =
//                                                             newDuration.inSeconds;
//                                                         players.elementAt(index).originalSeconds =
//                                                             newDuration.inSeconds;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                           );
//                                         },
//                                         child: Container(
//                                           height: boxHeight,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.6),
//                                             borderRadius: BorderRadius.circular(8.r),
//                                           ),
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 12.w,
//                                             vertical: 10.h,
//                                           ),
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             players.elementAt(index).originalSeconds == 0
//                                                 ? 'Set Time'
//                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
//                                             style: TextStyle(
//                                               fontSize: 16.sp,
//                                               fontWeight: FontWeight.w500,
//                                               color:
//                                                   players.elementAt(index).originalSeconds == 0
//                                                       ? Colors.grey.shade500
//                                                       : Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     FocusScope.of(context).unfocus();
//                                     final color = await showDialog<Color>(
//                                       context: context,
//                                       builder:
//                                           (context) => AlertDialog(
//                                             title: const Text('Select Color'),
//                                             content: Wrap(
//                                               spacing: 8.w,
//                                               children:
//                                                   Colors.primaries.map((c) {
//                                                     return GestureDetector(
//                                                       onTap: () => Navigator.pop(context, c),
//                                                       child: Container(
//                                                         width: 30.w,
//                                                         height: 30.w,
//                                                         decoration: BoxDecoration(
//                                                           color: c,
//                                                           borderRadius: BorderRadius.circular(15.r),
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                             ),
//                                           ),
//                                     );
//                                     if (color != null) {
//                                       setState(() => players.elementAt(index).color = color);
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: player.color,
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//                                   ),
//                                   child: const Text('Color'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Offstage(
//         offstage: isKeyboardVisible,
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 16.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FloatingActionButton.extended(
//                 heroTag: 'addPlayerBtn',
//                 onPressed: addPlayer,
//                 icon: const Icon(Icons.person_add, color: Colors.white),
//                 label: const Text('추가', style: TextStyle(color: Colors.white)),
//                 backgroundColor: Colors.indigo,
//               ),
//               FloatingActionButton.extended(
//                 heroTag: 'startBtn',
//                 onPressed: () {
//                   bool allPlayersValid = true;
//                   for (int i = 0; i < players.length; i++) {
//                     if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
//                       allPlayersValid = false;
//                       break;
//                     }
//                   }

//                   if (allPlayersValid) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(
//                       context,
//                     ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
//                   }
//                 },
//                 icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
//                 label: const Text('시작', style: TextStyle(color: Colors.white)),
//                 backgroundColor: Colors.teal,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TimerScreen extends StatefulWidget {
//   final List<Player> players;
//   const TimerScreen({super.key, required this.players});

//   @override
//   State<TimerScreen> createState() => _TimerScreenState();
// }

// class _TimerScreenState extends State<TimerScreen> {
//   Timer? _timer;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     // TimerScreen 진입 시 모든 방향 허용
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     startTimer();
//   }

//   void startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       setState(() {
//         final player = widget.players.elementAt(currentIndex);
//         if (player.seconds > 0) {
//           player.seconds--;
//           player.elapsedSeconds++;
//         } else {
//           player.isCompleted = true;
//           switchToNextPlayer();
//         }
//       });
//     });
//   }

//   void pauseTimer() {
//     _timer?.cancel();
//   }

//   void switchToNextPlayer() {
//     pauseTimer();
//     if (widget.players.where((p) => !p.isCompleted).isEmpty) {
//       showSummaryDialog();
//       return;
//     }
//     do {
//       currentIndex = (currentIndex + 1) % widget.players.length;
//     } while (widget.players.elementAt(currentIndex).isCompleted);
//     startTimer();
//   }

//   void resetAll() {
//     for (var p in widget.players) {
//       p.seconds = p.originalSeconds;
//       p.elapsedSeconds = 0;
//       p.isCompleted = false;
//     }
//     setState(() {
//       currentIndex = 0;
//     });
//     startTimer();
//   }

//   String formatDuration(int seconds) {
//     final d = Duration(seconds: seconds);
//     final hours = d.inHours.toString().padLeft(2, '0');
//     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
//     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
//     return '$hours:$minutes:$secs';
//   }

//   void showSummaryDialog() {
//     _timer?.cancel();
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Round Complete'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children:
//                   widget.players.map((p) {
//                     final formatted = formatDuration(p.elapsedSeconds);
//                     return Text('${p.name} ⏱ $formatted');
//                   }).toList(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   resetAll();
//                 },
//                 child: const Text('Next Round'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   resetAll();
//                   Navigator.of(context).popUntil((r) => r.isFirst);
//                 },
//                 child: const Text('Home'),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     // TimerScreen을 떠날 때 다시 Setting Screen의 세로 모드 고정으로 되돌립니다.
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final player = widget.players.elementAt(currentIndex);
//     return Scaffold(
//       backgroundColor: player.color,
//       body: SafeArea(
//         child: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             setState(() {
//               pauseTimer();
//               switchToNextPlayer();
//             });
//           },
//           child: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(player.name, style: TextStyle(fontSize: 28.sp, color: Colors.white)),
//                     SizedBox(height: 16.h),
//                     Text(
//                       formatDuration(player.seconds),
//                       style: TextStyle(
//                         fontSize: 64.sp,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                     SizedBox(height: 24.h),
//                     ElevatedButton(
//                       onPressed: () {
//                         setState(() {
//                           widget.players.elementAt(currentIndex).isCompleted = true;
//                           pauseTimer();
//                           switchToNextPlayer();
//                         });
//                       },
//                       child: const Text('Complete'),
//                     ),
//                     SizedBox(height: 12.h),
//                     ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
//                   ],
//                 ),
//               ),
//               Positioned(
//                 top: 20.h,
//                 right: 20.w,
//                 child: IconButton(
//                   icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
//                   onPressed: () {
//                     pauseTimer();
//                     showDialog(
//                       context: context,
//                       builder:
//                           (context) => AlertDialog(
//                             title: const Text('홈으로 이동'),
//                             content: const Text('정말 홈으로 가시겠습니까? \n설정을 유지하거나 초기화할 수 있습니다.'),
//                             actions: [
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context).popUntil((r) => r.isFirst);
//                                 },
//                                 child: const Text('설정 유지'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   resetAll();
//                                   Navigator.of(context).pop();
//                                   Navigator.of(context).popUntil((r) => r.isFirst);
//                                 },
//                                 child: const Text('초기화 후 이동'),
//                               ),
//                             ],
//                           ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter/cupertino.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';
// import 'package:flutter/services.dart'; // SystemChrome을 사용하기 위한 import

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   final lastUsed = prefs.getString('last_used_preset'); // 마지막 사용된 프리셋 이름 불러오기
//   runApp(MyApp(lastUsedPreset: lastUsed));
// }

// class MyApp extends StatelessWidget {
//   final String? lastUsedPreset;
//   const MyApp({super.key, this.lastUsedPreset});

//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: const Size(390, 844),
//       builder:
//           (context, child) => MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Multi Player Timer',
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.white,
//               fontFamily: 'Roboto',
//               textTheme: TextTheme(
//                 displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
//                 titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
//                 bodyLarge: TextStyle(fontSize: 16.sp),
//               ),
//               elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
//                   padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
//                 ),
//               ),
//             ),
//             home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
//           ),
//     );
//   }
// }

// class Player {
//   String name;
//   int seconds;
//   int originalSeconds;
//   Color color;
//   bool isCompleted;
//   int elapsedSeconds = 0;

//   Player({required this.name, required this.seconds, required this.color, this.isCompleted = false})
//     : originalSeconds = seconds;

//   Map<String, dynamic> toJson() => {'name': name, 'seconds': originalSeconds, 'color': color.value};

//   static Player fromJson(Map<String, dynamic> json) =>
//       Player(name: json['name'], seconds: json['seconds'], color: Color(json['color']));
// }

// class PlayerSetupScreen extends StatefulWidget {
//   final String? lastUsedPreset;
//   const PlayerSetupScreen({super.key, this.lastUsedPreset});

//   @override
//   State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
// }

// class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
//   final List<Player> players = [];
//   final List<TextEditingController> nameControllers = [];
//   final List<FocusNode> focusNodes = [];
//   final List<GlobalKey> itemKeys = [];

//   final ScrollController _scrollController = ScrollController(); // ScrollController 추가

//   String? currentPresetName;

//   @override
//   void initState() {
//     super.initState();
//     // PlayerSetupScreen (Settings Screen) 진입 시 세로 모드로 고정
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);

//     if (widget.lastUsedPreset != null) {
//       currentPresetName = widget.lastUsedPreset;
//       loadPreset(widget.lastUsedPreset!, autoLoad: true);
//     } else {
//       initializePlayers(2);
//     }
//   }

//   void initializePlayers(int count) {
//     players.clear();
//     nameControllers.clear();
//     for (var node in focusNodes) node.dispose();
//     focusNodes.clear();
//     itemKeys.clear();

//     for (int i = 0; i < count; i++) {
//       players.add(Player(name: '', seconds: 0, color: Colors.blue));
//       nameControllers.add(TextEditingController(text: ''));
//       final focusNode = FocusNode();
//       final itemKey = GlobalKey();
//       focusNode.addListener(() {
//         if (focusNode.hasFocus) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _scrollToItem(itemKey);
//           });
//         }
//       });
//       focusNodes.add(focusNode);
//       itemKeys.add(itemKey);
//     }
//     setState(() {});
//   }

//   void addPlayer() {
//     final newIndex = players.length;
//     players.add(Player(name: '', seconds: 0, color: Colors.blue));
//     nameControllers.add(TextEditingController(text: ''));
//     final focusNode = FocusNode();
//     final itemKey = GlobalKey();
//     focusNode.addListener(() {
//       if (focusNode.hasFocus) {
//         WidgetsBinding.instance.addPostFrameCallback((_) {
//           _scrollToItem(itemKey);
//         });
//       }
//     });
//     focusNodes.add(focusNode);
//     itemKeys.add(itemKey);
//     setState(() {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollToItem(itemKey);
//       });
//     });
//   }

//   void removePlayer(int index) {
//     players.removeAt(index);
//     nameControllers.removeAt(index);
//     focusNodes.removeAt(index).dispose();
//     itemKeys.removeAt(index);
//     setState(() {});
//   }

//   void _scrollToItem(GlobalKey key) {
//     final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
//     if (renderBox == null || !_scrollController.hasClients) return;

//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     if (keyboardHeight == 0) return; // 키보드가 없으면 스크롤할 필요 없음

//     // 현재 위젯의 화면 상에서의 위치와 크기
//     final Rect itemRect =
//         renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject()) & renderBox.size;

//     // 현재 스크롤 뷰의 보이는 영역 (키보드를 제외한 부분)
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double bottomPadding = MediaQuery.of(context).padding.bottom; // SafeArea bottom padding
//     final double viewportBottom = screenHeight - keyboardHeight; // 키보드 상단

//     // 앱바 높이
//     final double appBarHeight = AppBar().preferredSize.height;
//     // SafeArea 상단 패딩
//     final double safeAreaTopPadding = MediaQuery.of(context).padding.top;
//     // Settings 텍스트와 아이콘 Row의 높이 (대략적인 값, 실제 측정 필요 시 GlobalKey 사용)
//     final double settingsRowHeight = 30.h;
//     // SingleChildScrollView의 top 패딩
//     final double singleChildScrollViewTopPadding = 16.h;

//     // 상단 UI 요소들이 가려지지 않고 보존되어야 하는 최소 Y 좌표
//     // (앱바 하단 + SafeArea 상단 패딩 + SingleChildScrollView 상단 패딩 + Settings Row 높이)
//     final double minimumVisibleY =
//         appBarHeight + safeAreaTopPadding + singleChildScrollViewTopPadding + settingsRowHeight;

//     double targetOffset = _scrollController.offset;

//     // 플레이어 카드의 하단이 키보드 상단(viewportBottom)에 맞춰지도록 스크롤 오프셋 조정
//     // 현재 스크롤 오프셋 + (플레이어 카드의 하단 Y 좌표 - 뷰포트의 하단 Y 좌표)
//     final double requiredScrollForBottom = itemRect.bottom - viewportBottom;
//     if (requiredScrollForBottom > 0) {
//       // 위젯이 키보드에 가려진 경우
//       targetOffset = _scrollController.offset + requiredScrollForBottom;
//     }
//     // 2. 위젯의 상단이 앱바나 설정 섹션에 가려지는 경우 (하단을 맞추고 나니 상단이 가려진 경우)
//     // 이 부분은 위 1번 로직이 우선적으로 수행된 후, 만약 그 결과로 상단이 너무 올라갔을 때만 적용
//     final currentItemTop =
//         itemRect.top -
//         (_scrollController.offset - targetOffset); // 새로운 targetOffset 적용 시 아이템의 예상 top 위치
//     if (currentItemTop < minimumVisibleY) {
//       // 위젯의 상단이 minimumVisibleY에 맞춰지도록 스크롤을 조정
//       targetOffset = _scrollController.offset - (minimumVisibleY - itemRect.top);
//     }

//     // 스크롤 가능한 최대 범위와 최소 범위로 클램프
//     targetOffset = targetOffset.clamp(
//       _scrollController.position.minScrollExtent,
//       _scrollController.position.maxScrollExtent,
//     );

//     // 스크롤 실행
//     _scrollController.animateTo(
//       targetOffset,
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeOut,
//     );
//   }

//   Future<void> saveCurrentSettings(String presetName) async {
//     if (presetName.isEmpty) return;
//     final prefs = await SharedPreferences.getInstance();
//     final encoded = players.map((p) => p.toJson()).toList();
//     await prefs.setString('preset_$presetName', jsonEncode(encoded));
//     await prefs.setString(
//       'last_used_preset',
//       presetName,
//     ); // 현재 저장하는 프리셋 이름을 'last_used_preset'으로 저장
//     final names = prefs.getStringList('preset_names') ?? [];
//     if (!names.contains(presetName)) {
//       names.add(presetName);
//       await prefs.setStringList('preset_names', names);
//     }
//     setState(() {
//       currentPresetName = presetName;
//     });
//   }

//   Future<void> deletePreset(String presetName) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('preset_$presetName');
//     final names = prefs.getStringList('preset_names') ?? [];
//     names.remove(presetName);
//     await prefs.setStringList('preset_names', names);
//     final lastUsed = prefs.getString('last_used_preset');
//     if (lastUsed == presetName) {
//       await prefs.remove('last_used_preset');
//       setState(() {
//         currentPresetName = null;
//       });
//     }
//   }

//   Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final jsonString = prefs.getString('preset_$presetName');
//       if (jsonString == null) {
//         if (!autoLoad) {
//           ScaffoldMessenger.of(
//             context,
//           ).showSnackBar(const SnackBar(content: Text("선택한 설정이 존재하지 않습니다.")));
//         }
//         return;
//       }
//       for (var node in focusNodes) node.dispose();
//       players.clear();
//       nameControllers.clear();
//       focusNodes.clear();
//       itemKeys.clear();

//       final List decoded = jsonDecode(jsonString);
//       for (var p in decoded) {
//         final player = Player.fromJson(p);
//         players.add(player);
//         nameControllers.add(TextEditingController(text: player.name));
//         final focusNode = FocusNode();
//         final itemKey = GlobalKey();
//         focusNode.addListener(() {
//           if (focusNode.hasFocus) {
//             WidgetsBinding.instance.addPostFrameCallback((_) {
//               _scrollToItem(itemKey);
//             });
//           }
//         });
//         focusNodes.add(focusNode);
//         itemKeys.add(itemKey);
//       }
//       setState(() {
//         currentPresetName = presetName;
//       });
//       if (!autoLoad) {
//         await prefs.setString('last_used_preset', presetName);
//       }
//     } catch (_) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
//     }
//   }

//   void showSaveDialog() async {
//     final controller = TextEditingController();
//     await showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text("설정 이름 저장"),
//             content: TextField(
//               controller: controller,
//               decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   await saveCurrentSettings(controller.text.trim());
//                   Navigator.of(ctx).pop();
//                 },
//                 child: const Text("저장"),
//               ),
//             ],
//           ),
//     );
//   }

//   void showLoadDialog() async {
//     final prefs = await SharedPreferences.getInstance();
//     final presetNames = prefs.getStringList('preset_names') ?? [];
//     if (presetNames.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
//       return;
//     }
//     await showDialog(
//       context: context,
//       builder:
//           (ctx) => AlertDialog(
//             title: const Text("불러올 설정 선택"),
//             content: SingleChildScrollView(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children:
//                     presetNames.map((name) {
//                       return ListTile(
//                         title: Text(name),
//                         trailing: IconButton(
//                           icon: const Icon(Icons.delete, color: Colors.red),
//                           onPressed: () async {
//                             Navigator.of(ctx).pop();
//                             await deletePreset(name);
//                           },
//                         ),
//                         onTap: () async {
//                           Navigator.of(ctx).pop();
//                           await loadPreset(name);
//                         },
//                       );
//                     }).toList(),
//               ),
//             ),
//           ),
//     );
//   }

//   void clearAllSettings() async {
//     initializePlayers(2);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('last_used_preset');
//     setState(() {
//       currentPresetName = null;
//     });
//   }

//   @override
//   void dispose() {
//     for (var node in focusNodes) {
//       node.dispose();
//     }
//     for (var controller in nameControllers) {
//       controller.dispose();
//     }
//     _scrollController.dispose();
//     // PlayerSetupScreen (Settings Screen)을 떠날 때,
//     // 앱의 기본 방향(세로 고정)으로 되돌리는 것은 TimerScreen에서 모든 방향을 지원하기 때문에
//     // 여기서는 특별히 변경할 필요가 없습니다. TimerScreen의 dispose에서 다시 설정될 것입니다.
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
//     final bool isKeyboardVisible = keyboardHeight != 0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'TimeSquad',
//           style: TextStyle(
//             fontSize: 22.sp,
//             fontWeight: FontWeight.w600,
//             letterSpacing: 0.8,
//             color: Colors.black87,
//           ),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         scrolledUnderElevation: 0.0,
//         toolbarHeight: 60.h,
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           controller: _scrollController, // ScrollController 연결
//           padding: EdgeInsets.only(
//             left: 24.w,
//             right: 24.w,
//             top: 16.h,
//             bottom: keyboardHeight, // 키보드 높이만큼 하단 패딩 추가
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: [
//                   Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
//                   const Spacer(),
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
//                       IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
//                       IconButton(
//                         icon: const Icon(FeatherIcons.rotateCcw),
//                         onPressed: clearAllSettings,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16.h),
//               ReorderableListView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.only(bottom: 16.h), // 플레이어 카드 사이의 간격과 하단 여백
//                 buildDefaultDragHandles: false,
//                 proxyDecorator: (child, index, animation) {
//                   final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
//                   return ScaleTransition(
//                     scale: scale,
//                     child: Material(
//                       elevation: 0,
//                       shadowColor: Colors.transparent,
//                       color: Colors.transparent,
//                       child: child,
//                     ),
//                   );
//                 },
//                 itemCount: players.length,
//                 onReorder: (oldIndex, newIndex) {
//                   setState(() {
//                     if (newIndex > oldIndex) newIndex--;
//                     final player = players.removeAt(oldIndex);
//                     final controller = nameControllers.removeAt(oldIndex);
//                     final focusNode = focusNodes.removeAt(oldIndex);
//                     final itemKey = itemKeys.removeAt(oldIndex);

//                     players.insert(newIndex, player);
//                     nameControllers.insert(newIndex, controller);
//                     focusNodes.insert(newIndex, focusNode);
//                     itemKeys.insert(newIndex, itemKey);
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   final player = players.elementAt(index);
//                   const double borderRadius = 20.0;
//                   const double boxHeight = 48.0;

//                   return ReorderableDelayedDragStartListener(
//                     key: itemKeys[index],
//                     index: index,
//                     child: Padding(
//                       padding: EdgeInsets.only(bottom: 12.h),
//                       child: Container(
//                         margin: EdgeInsets.zero,
//                         decoration: BoxDecoration(
//                           color: Color.lerp(Colors.white, player.color, 0.2),
//                           borderRadius: BorderRadius.circular(borderRadius.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.2),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 3),
//                             ),
//                           ],
//                         ),
//                         clipBehavior: Clip.antiAlias,
//                         child: Dismissible(
//                           key: ValueKey(player),
//                           direction: DismissDirection.horizontal,
//                           background: ClipRRect(
//                             borderRadius: BorderRadius.circular(borderRadius.r),
//                             child: Container(
//                               alignment: Alignment.centerLeft,
//                               padding: EdgeInsets.only(left: 20.w),
//                               color: Colors.white,
//                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
//                             ),
//                           ),
//                           secondaryBackground: ClipRRect(
//                             borderRadius: BorderRadius.circular(borderRadius.r),
//                             child: Container(
//                               alignment: Alignment.centerRight,
//                               padding: EdgeInsets.only(right: 20.w),
//                               color: Colors.white,
//                               child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
//                             ),
//                           ),
//                           onDismissed: (_) {
//                             removePlayer(index);
//                           },
//                           child: Container(
//                             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//                             child: Row(
//                               children: [
//                                 Container(
//                                   width: 40.w,
//                                   height: 40.w,
//                                   alignment: Alignment.center,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                   ),
//                                   child: Text(
//                                     '${index + 1}',
//                                     style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                                   ),
//                                 ),
//                                 SizedBox(width: 12.w),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Container(
//                                         height: boxHeight,
//                                         decoration: BoxDecoration(
//                                           color: Colors.white.withOpacity(0.6),
//                                           borderRadius: BorderRadius.circular(8.r),
//                                         ),
//                                         padding: EdgeInsets.symmetric(
//                                           horizontal: 8.w,
//                                           vertical: 4.h,
//                                         ),
//                                         alignment: Alignment.centerLeft,
//                                         child: TextField(
//                                           controller: nameControllers.elementAt(index),
//                                           focusNode: focusNodes.elementAt(index),
//                                           onChanged: (val) => players.elementAt(index).name = val,
//                                           style: TextStyle(
//                                             fontSize: 16.sp,
//                                             fontWeight: FontWeight.w500,
//                                           ),
//                                           decoration: InputDecoration.collapsed(
//                                             hintText: 'Enter Name',
//                                             hintStyle: TextStyle(
//                                               color: Colors.grey.shade500,
//                                               fontSize: 16.sp,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(height: 8.h),
//                                       GestureDetector(
//                                         onTap: () async {
//                                           FocusScope.of(context).unfocus();
//                                           Duration selectedDuration = Duration(
//                                             seconds: players.elementAt(index).originalSeconds,
//                                           );
//                                           await showModalBottomSheet(
//                                             context: context,
//                                             builder:
//                                                 (context) => SizedBox(
//                                                   height: 200,
//                                                   child: CupertinoTimerPicker(
//                                                     mode: CupertinoTimerPickerMode.hms,
//                                                     initialTimerDuration:
//                                                         selectedDuration.inSeconds == 0
//                                                             ? const Duration(minutes: 10)
//                                                             : selectedDuration,
//                                                     onTimerDurationChanged: (Duration newDuration) {
//                                                       setState(() {
//                                                         players.elementAt(index).seconds =
//                                                             newDuration.inSeconds;
//                                                         players.elementAt(index).originalSeconds =
//                                                             newDuration.inSeconds;
//                                                       });
//                                                     },
//                                                   ),
//                                                 ),
//                                           );
//                                         },
//                                         child: Container(
//                                           height: boxHeight,
//                                           decoration: BoxDecoration(
//                                             color: Colors.white.withOpacity(0.6),
//                                             borderRadius: BorderRadius.circular(8.r),
//                                           ),
//                                           padding: EdgeInsets.symmetric(
//                                             horizontal: 12.w,
//                                             vertical: 10.h,
//                                           ),
//                                           alignment: Alignment.centerLeft,
//                                           child: Text(
//                                             players.elementAt(index).originalSeconds == 0
//                                                 ? 'Set Time'
//                                                 : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
//                                             style: TextStyle(
//                                               fontSize: 16.sp,
//                                               fontWeight: FontWeight.w500,
//                                               color:
//                                                   players.elementAt(index).originalSeconds == 0
//                                                       ? Colors.grey.shade500
//                                                       : Colors.black,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 SizedBox(width: 8.w),
//                                 ElevatedButton(
//                                   onPressed: () async {
//                                     FocusScope.of(context).unfocus();
//                                     final color = await showDialog<Color>(
//                                       context: context,
//                                       builder:
//                                           (context) => AlertDialog(
//                                             title: const Text('Select Color'),
//                                             content: Wrap(
//                                               spacing: 8.w,
//                                               children:
//                                                   Colors.primaries.map((c) {
//                                                     return GestureDetector(
//                                                       onTap: () => Navigator.pop(context, c),
//                                                       child: Container(
//                                                         width: 30.w,
//                                                         height: 30.w,
//                                                         decoration: BoxDecoration(
//                                                           color: c,
//                                                           borderRadius: BorderRadius.circular(15.r),
//                                                         ),
//                                                       ),
//                                                     );
//                                                   }).toList(),
//                                             ),
//                                           ),
//                                     );
//                                     if (color != null) {
//                                       setState(() => players.elementAt(index).color = color);
//                                     }
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: player.color,
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.r),
//                                     ),
//                                   ),
//                                   child: const Text('Color'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Offstage(
//         offstage: isKeyboardVisible,
//         child: Padding(
//           padding: EdgeInsets.only(bottom: 16.h),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               FloatingActionButton.extended(
//                 heroTag: 'addPlayerBtn',
//                 onPressed: addPlayer,
//                 icon: const Icon(Icons.person_add, color: Colors.white),
//                 label: const Text('추가', style: TextStyle(color: Colors.white)),
//                 backgroundColor: Colors.indigo,
//               ),
//               FloatingActionButton.extended(
//                 heroTag: 'startBtn',
//                 onPressed: () {
//                   bool allPlayersValid = true;
//                   for (int i = 0; i < players.length; i++) {
//                     if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
//                       allPlayersValid = false;
//                       break;
//                     }
//                   }

//                   if (allPlayersValid) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
//                     );
//                   } else {
//                     ScaffoldMessenger.of(
//                       context,
//                     ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
//                   }
//                 },
//                 icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
//                 label: const Text('시작', style: TextStyle(color: Colors.white)),
//                 backgroundColor: Colors.teal,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class TimerScreen extends StatefulWidget {
//   final List<Player> players;
//   const TimerScreen({super.key, required this.players});

//   @override
//   State<TimerScreen> createState() => _TimerScreenState();
// }

// class _TimerScreenState extends State<TimerScreen> {
//   Timer? _timer;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//       DeviceOrientation.landscapeLeft,
//       DeviceOrientation.landscapeRight,
//     ]);
//     startTimer();
//   }

//   void startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//       setState(() {
//         final player = widget.players[currentIndex];
//         if (player.seconds > 0) {
//           player.seconds--;
//           player.elapsedSeconds++;
//         } else {
//           player.isCompleted = true;
//           switchToNextPlayer();
//         }
//       });
//     });
//   }

//   void pauseTimer() {
//     _timer?.cancel();
//   }

//   void switchToNextPlayer() {
//     pauseTimer();
//     if (widget.players.every((p) => p.isCompleted)) {
//       showSummaryDialog();
//       return;
//     }
//     do {
//       currentIndex = (currentIndex + 1) % widget.players.length;
//     } while (widget.players[currentIndex].isCompleted);
//     startTimer();
//   }

//   void resetAll() {
//     for (var p in widget.players) {
//       p.seconds = p.originalSeconds;
//       p.elapsedSeconds = 0;
//       p.isCompleted = false;
//     }
//     setState(() {
//       currentIndex = 0;
//     });
//     startTimer();
//   }

//   String formatDuration(int seconds) {
//     final d = Duration(seconds: seconds);
//     final hours = d.inHours.toString().padLeft(2, '0');
//     final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
//     final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
//     return '$hours:$minutes:$secs';
//   }

//   void showSummaryDialog() {
//     _timer?.cancel();
//     showDialog(
//       context: context,
//       builder:
//           (_) => AlertDialog(
//             title: const Text('Round Complete'),
//             content: Column(
//               mainAxisSize: MainAxisSize.min,
//               children:
//                   widget.players
//                       .map((p) => Text('${p.name} ⏱ ${formatDuration(p.elapsedSeconds)}'))
//                       .toList(),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                   resetAll();
//                 },
//                 child: const Text('Next Round'),
//               ),
//               TextButton(
//                 onPressed: () {
//                   resetAll();
//                   Navigator.of(context).popUntil((r) => r.isFirst);
//                 },
//                 child: const Text('Home'),
//               ),
//             ],
//           ),
//     );
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final player = widget.players[currentIndex];
//     final orientation = MediaQuery.of(context).orientation;

//     return Scaffold(
//       backgroundColor: player.color,
//       body: SafeArea(
//         child: GestureDetector(
//           behavior: HitTestBehavior.opaque,
//           onTap: () {
//             setState(() {
//               pauseTimer();
//               switchToNextPlayer();
//             });
//           },
//           child:
//               orientation == Orientation.portrait
//                   ? Stack(
//                     children: [
//                       Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               player.name,
//                               style: TextStyle(fontSize: 28.sp, color: Colors.white),
//                             ),
//                             SizedBox(height: 16.h),
//                             Text(
//                               formatDuration(player.seconds),
//                               style: TextStyle(
//                                 fontSize: 64.sp,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             SizedBox(height: 24.h),
//                             ElevatedButton(
//                               onPressed: () {
//                                 setState(() {
//                                   widget.players[currentIndex].isCompleted = true;
//                                   pauseTimer();
//                                   switchToNextPlayer();
//                                 });
//                               },
//                               child: const Text('Complete'),
//                             ),
//                             SizedBox(height: 12.h),
//                             ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
//                           ],
//                         ),
//                       ),
//                       Positioned(
//                         top: 20.h,
//                         right: 20.w,
//                         child: IconButton(
//                           icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
//                           onPressed: () {
//                             pauseTimer();
//                             showDialog(
//                               context: context,
//                               builder:
//                                   (context) => AlertDialog(
//                                     title: const Text('홈으로 이동'),
//                                     content: const Text('정말 홈으로 가시겠습니까?\n설정을 유지하거나 초기화할 수 있습니다.'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).popUntil((r) => r.isFirst);
//                                         },
//                                         child: const Text('설정 유지'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           resetAll();
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).popUntil((r) => r.isFirst);
//                                         },
//                                         child: const Text('초기화 후 이동'),
//                                       ),
//                                     ],
//                                   ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   )
//                   : Stack(
//                     children: [
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Center(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Text(
//                                     player.name,
//                                     style: TextStyle(fontSize: 32.sp, color: Colors.white),
//                                   ),
//                                   SizedBox(height: 16.h),
//                                   Text(
//                                     formatDuration(player.seconds),
//                                     style: TextStyle(
//                                       fontSize: 80.sp,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(right: 40.w),
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.white.withOpacity(0.9),
//                                     foregroundColor: Colors.purple.shade800,
//                                     textStyle: TextStyle(fontSize: 18.sp),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20.r),
//                                     ),
//                                     padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
//                                   ),
//                                   onPressed: () {
//                                     setState(() {
//                                       widget.players[currentIndex].isCompleted = true;
//                                       pauseTimer();
//                                       switchToNextPlayer();
//                                     });
//                                   },
//                                   child: const Text('Complete'),
//                                 ),
//                                 SizedBox(height: 16.h),
//                                 ElevatedButton(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.white.withOpacity(0.9),
//                                     foregroundColor: Colors.purple.shade800,
//                                     textStyle: TextStyle(fontSize: 18.sp),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(20.r),
//                                     ),
//                                     padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
//                                   ),
//                                   onPressed: resetAll,
//                                   child: const Text('Restart'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       Positioned(
//                         top: 20.h,
//                         right: 20.w,
//                         child: IconButton(
//                           icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
//                           onPressed: () {
//                             pauseTimer();
//                             showDialog(
//                               context: context,
//                               builder:
//                                   (context) => AlertDialog(
//                                     title: const Text('홈으로 이동'),
//                                     content: const Text('정말 홈으로 가시겠습니까?\n설정을 유지하거나 초기화할 수 있습니다.'),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).popUntil((r) => r.isFirst);
//                                         },
//                                         child: const Text('설정 유지'),
//                                       ),
//                                       TextButton(
//                                         onPressed: () {
//                                           resetAll();
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).popUntil((r) => r.isFirst);
//                                         },
//                                         child: const Text('초기화 후 이동'),
//                                       ),
//                                     ],
//                                   ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter/services.dart'; // SystemChrome을 사용하기 위한 import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final lastUsed = prefs.getString('last_used_preset'); // 마지막 사용된 프리셋 이름 불러오기
  runApp(MyApp(lastUsedPreset: lastUsed));
}

class MyApp extends StatelessWidget {
  final String? lastUsedPreset;
  const MyApp({super.key, this.lastUsedPreset});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder:
          (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Multi Player Timer',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Roboto',
              textTheme: TextTheme(
                displaySmall: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                titleMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                bodyLarge: TextStyle(fontSize: 16.sp),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 14.h),
                ),
              ),
            ),
            home: PlayerSetupScreen(lastUsedPreset: lastUsedPreset),
          ),
    );
  }
}

enum TimerType { digital, analog, hybrid }

// ✅ Player 클래스 수정
class Player {
  String name;
  int seconds;
  int originalSeconds;
  Color color;
  bool isCompleted;
  int elapsedSeconds = 0;
  TimerType timerType;

  Player({
    required this.name,
    required this.seconds,
    required this.color,
    this.isCompleted = false,
    this.timerType = TimerType.digital,
  }) : originalSeconds = seconds;

  Map<String, dynamic> toJson() => {
    'name': name,
    'seconds': originalSeconds,
    'color': color.value,
    'timerType': timerType.index,
  };

  static Player fromJson(Map<String, dynamic> json) => Player(
    name: json['name'],
    seconds: json['seconds'],
    color: Color(json['color']),
    timerType: TimerType.values[json['timerType'] ?? 0],
  );
}

class PlayerSetupScreen extends StatefulWidget {
  final String? lastUsedPreset;
  const PlayerSetupScreen({super.key, this.lastUsedPreset});

  @override
  State<PlayerSetupScreen> createState() => _PlayerSetupScreenState();
}

class _PlayerSetupScreenState extends State<PlayerSetupScreen> {
  final List<Player> players = [];
  final List<TextEditingController> nameControllers = [];
  final List<FocusNode> focusNodes = [];
  final List<GlobalKey> itemKeys = [];

  final ScrollController _scrollController = ScrollController(); // ScrollController 추가

  String? currentPresetName;

  @override
  void initState() {
    super.initState();
    // PlayerSetupScreen (Settings Screen) 진입 시 세로 모드로 고정
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    if (widget.lastUsedPreset != null) {
      currentPresetName = widget.lastUsedPreset;
      loadPreset(widget.lastUsedPreset!, autoLoad: true);
    } else {
      initializePlayers(2);
    }
  }

  void initializePlayers(int count) {
    players.clear();
    nameControllers.clear();
    for (var node in focusNodes) node.dispose();
    focusNodes.clear();
    itemKeys.clear();

    for (int i = 0; i < count; i++) {
      players.add(Player(name: '', seconds: 0, color: Colors.blue));
      nameControllers.add(TextEditingController(text: ''));
      final focusNode = FocusNode();
      final itemKey = GlobalKey();
      focusNode.addListener(() {
        if (focusNode.hasFocus) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToItem(itemKey);
          });
        }
      });
      focusNodes.add(focusNode);
      itemKeys.add(itemKey);
    }
    setState(() {});
  }

  void addPlayer() {
    final newIndex = players.length;
    players.add(Player(name: '', seconds: 0, color: Colors.blue));
    nameControllers.add(TextEditingController(text: ''));
    final focusNode = FocusNode();
    final itemKey = GlobalKey();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToItem(itemKey);
        });
      }
    });
    focusNodes.add(focusNode);
    itemKeys.add(itemKey);
    setState(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToItem(itemKey);
      });
    });
  }

  void removePlayer(int index) {
    players.removeAt(index);
    nameControllers.removeAt(index);
    focusNodes.removeAt(index).dispose();
    itemKeys.removeAt(index);
    setState(() {});
  }

  void _scrollToItem(GlobalKey key) {
    final RenderBox? renderBox = key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null || !_scrollController.hasClients) return;

    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardHeight == 0) return; // 키보드가 없으면 스크롤할 필요 없음

    // 현재 위젯의 화면 상에서의 위치와 크기
    final Rect itemRect =
        renderBox.localToGlobal(Offset.zero, ancestor: context.findRenderObject()) & renderBox.size;

    // 현재 스크롤 뷰의 보이는 영역 (키보드를 제외한 부분)
    final double screenHeight = MediaQuery.of(context).size.height;
    final double bottomPadding = MediaQuery.of(context).padding.bottom; // SafeArea bottom padding
    final double viewportBottom = screenHeight - keyboardHeight; // 키보드 상단

    // 앱바 높이
    final double appBarHeight = AppBar().preferredSize.height;
    // SafeArea 상단 패딩
    final double safeAreaTopPadding = MediaQuery.of(context).padding.top;
    // Settings 텍스트와 아이콘 Row의 높이 (대략적인 값, 실제 측정 필요 시 GlobalKey 사용)
    final double settingsRowHeight = 30.h;
    // SingleChildScrollView의 top 패딩
    final double singleChildScrollViewTopPadding = 16.h;

    // 상단 UI 요소들이 가려지지 않고 보존되어야 하는 최소 Y 좌표
    // (앱바 하단 + SafeArea 상단 패딩 + SingleChildScrollView 상단 패딩 + Settings Row 높이)
    final double minimumVisibleY =
        appBarHeight + safeAreaTopPadding + singleChildScrollViewTopPadding + settingsRowHeight;

    double targetOffset = _scrollController.offset;

    // 플레이어 카드의 하단이 키보드 상단(viewportBottom)에 맞춰지도록 스크롤 오프셋 조정
    // 현재 스크롤 오프셋 + (플레이어 카드의 하단 Y 좌표 - 뷰포트의 하단 Y 좌표)
    final double requiredScrollForBottom = itemRect.bottom - viewportBottom;
    if (requiredScrollForBottom > 0) {
      // 위젯이 키보드에 가려진 경우
      targetOffset = _scrollController.offset + requiredScrollForBottom;
    }
    // 2. 위젯의 상단이 앱바나 설정 섹션에 가려지는 경우 (하단을 맞추고 나니 상단이 가려진 경우)
    // 이 부분은 위 1번 로직이 우선적으로 수행된 후, 만약 그 결과로 상단이 너무 올라갔을 때만 적용
    final currentItemTop =
        itemRect.top -
        (_scrollController.offset - targetOffset); // 새로운 targetOffset 적용 시 아이템의 예상 top 위치
    if (currentItemTop < minimumVisibleY) {
      // 위젯의 상단이 minimumVisibleY에 맞춰지도록 스크롤을 조정
      targetOffset = _scrollController.offset - (minimumVisibleY - itemRect.top);
    }

    // 스크롤 가능한 최대 범위와 최소 범위로 클램프
    targetOffset = targetOffset.clamp(
      _scrollController.position.minScrollExtent,
      _scrollController.position.maxScrollExtent,
    );

    // 스크롤 실행
    _scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  Future<void> saveCurrentSettings(String presetName) async {
    if (presetName.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();
    final encoded = players.map((p) => p.toJson()).toList();
    await prefs.setString('preset_$presetName', jsonEncode(encoded));
    await prefs.setString(
      'last_used_preset',
      presetName,
    ); // 현재 저장하는 프리셋 이름을 'last_used_preset'으로 저장
    final names = prefs.getStringList('preset_names') ?? [];
    if (!names.contains(presetName)) {
      names.add(presetName);
      await prefs.setStringList('preset_names', names);
    }
    setState(() {
      currentPresetName = presetName;
    });
  }

  Future<void> deletePreset(String presetName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('preset_$presetName');
    final names = prefs.getStringList('preset_names') ?? [];
    names.remove(presetName);
    await prefs.setStringList('preset_names', names);
    final lastUsed = prefs.getString('last_used_preset');
    if (lastUsed == presetName) {
      await prefs.remove('last_used_preset');
      setState(() {
        currentPresetName = null;
      });
    }
  }

  Future<void> loadPreset(String presetName, {bool autoLoad = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('preset_$presetName');
      if (jsonString == null) {
        if (!autoLoad) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("선택한 설정이 존재하지 않습니다.")));
        }
        return;
      }
      for (var node in focusNodes) node.dispose();
      players.clear();
      nameControllers.clear();
      focusNodes.clear();
      itemKeys.clear();

      final List decoded = jsonDecode(jsonString);
      for (var p in decoded) {
        final player = Player.fromJson(p);
        players.add(player);
        nameControllers.add(TextEditingController(text: player.name));
        final focusNode = FocusNode();
        final itemKey = GlobalKey();
        focusNode.addListener(() {
          if (focusNode.hasFocus) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToItem(itemKey);
            });
          }
        });
        focusNodes.add(focusNode);
        itemKeys.add(itemKey);
      }
      setState(() {
        currentPresetName = presetName;
      });
      if (!autoLoad) {
        await prefs.setString('last_used_preset', presetName);
      }
    } catch (_) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("설정을 불러오는 중 오류가 발생했습니다.")));
    }
  }

  void showSaveDialog() async {
    final controller = TextEditingController();
    await showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("설정 이름 저장"),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "예: 친구들과 타이머"),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await saveCurrentSettings(controller.text.trim());
                  Navigator.of(ctx).pop();
                },
                child: const Text("저장"),
              ),
            ],
          ),
    );
  }

  void showLoadDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final presetNames = prefs.getStringList('preset_names') ?? [];
    if (presetNames.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("저장된 설정이 없습니다.")));
      return;
    }
    await showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("불러올 설정 선택"),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    presetNames.map((name) {
                      return ListTile(
                        title: Text(name),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            Navigator.of(ctx).pop();
                            await deletePreset(name);
                          },
                        ),
                        onTap: () async {
                          Navigator.of(ctx).pop();
                          await loadPreset(name);
                        },
                      );
                    }).toList(),
              ),
            ),
          ),
    );
  }

  void clearAllSettings() async {
    initializePlayers(2);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('last_used_preset');
    setState(() {
      currentPresetName = null;
    });
  }

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in nameControllers) {
      controller.dispose();
    }
    _scrollController.dispose();
    // PlayerSetupScreen (Settings Screen)을 떠날 때,
    // 앱의 기본 방향(세로 고정)으로 되돌리는 것은 TimerScreen에서 모든 방향을 지원하기 때문에
    // 여기서는 특별히 변경할 필요가 없습니다. TimerScreen의 dispose에서 다시 설정될 것입니다.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    final bool isKeyboardVisible = keyboardHeight != 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TimeSquad',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
            color: Colors.black87,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.0,
        toolbarHeight: 60.h,
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController, // ScrollController 연결
          padding: EdgeInsets.only(
            left: 24.w,
            right: 24.w,
            top: 16.h,
            bottom: keyboardHeight, // 키보드 높이만큼 하단 패딩 추가
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('Settings', style: TextStyle(fontSize: 18.sp, color: Colors.grey.shade700)),
                  const Spacer(),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(FeatherIcons.save), onPressed: showSaveDialog),
                      IconButton(icon: const Icon(FeatherIcons.folder), onPressed: showLoadDialog),
                      IconButton(
                        icon: const Icon(FeatherIcons.rotateCcw),
                        onPressed: clearAllSettings,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ReorderableListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: 16.h), // 플레이어 카드 사이의 간격과 하단 여백
                buildDefaultDragHandles: false,
                proxyDecorator: (child, index, animation) {
                  final scale = Tween<double>(begin: 1.0, end: 1.03).animate(animation);
                  return ScaleTransition(
                    scale: scale,
                    child: Material(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      color: Colors.transparent,
                      child: child,
                    ),
                  );
                },
                itemCount: players.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex--;
                    final player = players.removeAt(oldIndex);
                    final controller = nameControllers.removeAt(oldIndex);
                    final focusNode = focusNodes.removeAt(oldIndex);
                    final itemKey = itemKeys.removeAt(oldIndex);

                    players.insert(newIndex, player);
                    nameControllers.insert(newIndex, controller);
                    focusNodes.insert(newIndex, focusNode);
                    itemKeys.insert(newIndex, itemKey);
                  });
                },
                itemBuilder: (context, index) {
                  final player = players.elementAt(index);
                  const double borderRadius = 20.0;
                  const double boxHeight = 48.0;

                  return ReorderableDelayedDragStartListener(
                    key: itemKeys[index],
                    index: index,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Container(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          color: Color.lerp(Colors.white, player.color, 0.2),
                          borderRadius: BorderRadius.circular(borderRadius.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Dismissible(
                          key: ValueKey(player),
                          direction: DismissDirection.horizontal,
                          background: ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius.r),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20.w),
                              color: Colors.white,
                              child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
                            ),
                          ),
                          secondaryBackground: ClipRRect(
                            borderRadius: BorderRadius.circular(borderRadius.r),
                            child: Container(
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 20.w),
                              color: Colors.white,
                              child: Icon(Icons.delete, color: Colors.red, size: 30.sp),
                            ),
                          ),
                          onDismissed: (_) {
                            removePlayer(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            child: Row(
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: boxHeight,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.6),
                                          borderRadius: BorderRadius.circular(8.r),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8.w,
                                          vertical: 4.h,
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: TextField(
                                          controller: nameControllers.elementAt(index),
                                          focusNode: focusNodes.elementAt(index),
                                          onChanged: (val) => players.elementAt(index).name = val,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration.collapsed(
                                            hintText: 'Enter Name',
                                            hintStyle: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8.h),

                                      GestureDetector(
                                        onTap: () async {
                                          FocusScope.of(context).unfocus();
                                          Duration selectedDuration = Duration(
                                            seconds: players.elementAt(index).originalSeconds,
                                          );
                                          await showModalBottomSheet(
                                            context: context,
                                            builder:
                                                (context) => SizedBox(
                                                  height: 200,
                                                  child: CupertinoTimerPicker(
                                                    mode: CupertinoTimerPickerMode.hms,
                                                    initialTimerDuration:
                                                        selectedDuration.inSeconds == 0
                                                            ? const Duration(minutes: 10)
                                                            : selectedDuration,
                                                    onTimerDurationChanged: (Duration newDuration) {
                                                      setState(() {
                                                        players.elementAt(index).seconds =
                                                            newDuration.inSeconds;
                                                        players.elementAt(index).originalSeconds =
                                                            newDuration.inSeconds;
                                                      });
                                                    },
                                                  ),
                                                ),
                                          );
                                        },
                                        child: Container(
                                          height: boxHeight,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.6),
                                            borderRadius: BorderRadius.circular(8.r),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 10.h,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            players.elementAt(index).originalSeconds == 0
                                                ? 'Set Time'
                                                : 'Time: ${Duration(seconds: players.elementAt(index).originalSeconds).toString().split('.').first.padLeft(8, "0")}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  players.elementAt(index).originalSeconds == 0
                                                      ? Colors.grey.shade500
                                                      : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  // 시계 타입 선택 버튼과 색상 버튼을 세로로 배치
                                  children: [
                                    // 타이머 타입 선택 버튼 (아날로그/디지털)
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            FeatherIcons.watch, // 디지털 시계 아이콘
                                            color:
                                                player.timerType == TimerType.digital
                                                    ? Colors
                                                        .blue
                                                        .shade800 // 선택됨
                                                    : Colors.grey, // 선택 안 됨
                                            size: 24.sp,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              player.timerType = TimerType.digital; // 디지털 선택 시
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            FeatherIcons.clock, // 아날로그 시계 아이콘
                                            color:
                                                player.timerType == TimerType.analog
                                                    ? Colors
                                                        .blue
                                                        .shade800 // 선택됨
                                                    : Colors.grey, // 선택 안 됨
                                            size: 24.sp,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              player.timerType = TimerType.analog; // 아날로그 선택 시
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.timer_outlined, // 디지털 시계 아이콘
                                            color:
                                                player.timerType == TimerType.digital
                                                    ? Colors
                                                        .blue
                                                        .shade800 // 선택됨
                                                    : Colors.grey, // 선택 안 됨
                                            size: 24.sp,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              player.timerType = TimerType.digital; // 디지털 선택 시
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        final color = await showDialog<Color>(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: const Text('Select Color'),
                                                content: Wrap(
                                                  spacing: 8.w,
                                                  children:
                                                      Colors.primaries.map((c) {
                                                        return GestureDetector(
                                                          onTap: () => Navigator.pop(context, c),
                                                          child: Container(
                                                            width: 30.w,
                                                            height: 30.w,
                                                            decoration: BoxDecoration(
                                                              color: c,
                                                              borderRadius: BorderRadius.circular(
                                                                15.r,
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                ),
                                              ),
                                        );
                                        if (color != null) {
                                          setState(() => players.elementAt(index).color = color);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: player.color,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                      ),
                                      child: const Text('Color'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Offstage(
        offstage: isKeyboardVisible,
        child: Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton.extended(
                heroTag: 'addPlayerBtn',
                onPressed: addPlayer,
                icon: const Icon(Icons.person_add, color: Colors.white),
                label: const Text('추가', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.indigo,
              ),
              FloatingActionButton.extended(
                heroTag: 'startBtn',
                onPressed: () {
                  bool allPlayersValid = true;
                  for (int i = 0; i < players.length; i++) {
                    if (nameControllers[i].text.trim().isEmpty || players[i].originalSeconds == 0) {
                      allPlayersValid = false;
                      break;
                    }
                  }

                  if (allPlayersValid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => TimerScreen(players: players)),
                    );
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("모든 플레이어의 이름과 시간을 설정해주세요.")));
                  }
                },
                icon: const Icon(FeatherIcons.arrowRightCircle, color: Colors.white),
                label: const Text('시작', style: TextStyle(color: Colors.white)),
                backgroundColor: Colors.teal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TimerScreen extends StatefulWidget {
  final List<Player> players;
  const TimerScreen({super.key, required this.players});

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  Timer? _timer;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        final player = widget.players[currentIndex];
        if (player.seconds > 0) {
          player.seconds--;
          player.elapsedSeconds++;
        } else {
          player.isCompleted = true;
          switchToNextPlayer();
        }
      });
    });
  }

  void pauseTimer() {
    _timer?.cancel();
  }

  void switchToNextPlayer() {
    pauseTimer();
    if (widget.players.every((p) => p.isCompleted)) {
      showSummaryDialog();
      return;
    }
    do {
      currentIndex = (currentIndex + 1) % widget.players.length;
    } while (widget.players[currentIndex].isCompleted);
    startTimer();
  }

  void resetAll() {
    for (var p in widget.players) {
      p.seconds = p.originalSeconds;
      p.elapsedSeconds = 0;
      p.isCompleted = false;
    }
    setState(() {
      currentIndex = 0;
    });
    startTimer();
  }

  String formatDuration(int seconds) {
    final d = Duration(seconds: seconds);
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final secs = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$secs';
  }

  void showSummaryDialog() {
    _timer?.cancel();
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Round Complete'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  widget.players
                      .map((p) => Text('${p.name} ⏱ ${formatDuration(p.elapsedSeconds)}'))
                      .toList(),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  resetAll();
                },
                child: const Text('Next Round'),
              ),
              TextButton(
                onPressed: () {
                  resetAll();
                  Navigator.of(context).popUntil((r) => r.isFirst);
                },
                child: const Text('Home'),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final player = widget.players[currentIndex];
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      backgroundColor: player.color,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              pauseTimer();
              switchToNextPlayer();
            });
          },
          child:
              orientation == Orientation.portrait
                  ? Stack(
                    children: [
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              player.name,
                              style: TextStyle(fontSize: 28.sp, color: Colors.white),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              formatDuration(player.seconds),
                              style: TextStyle(
                                fontSize: 64.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 24.h),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  widget.players[currentIndex].isCompleted = true;
                                  pauseTimer();
                                  switchToNextPlayer();
                                });
                              },
                              child: const Text('Complete'),
                            ),
                            SizedBox(height: 12.h),
                            ElevatedButton(onPressed: resetAll, child: const Text('Restart')),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 20.h,
                        right: 20.w,
                        child: IconButton(
                          icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
                          onPressed: () {
                            pauseTimer();
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('홈으로 이동'),
                                    content: const Text('정말 홈으로 가시겠습니까?\n설정을 유지하거나 초기화할 수 있습니다.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popUntil((r) => r.isFirst);
                                        },
                                        child: const Text('설정 유지'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          resetAll();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popUntil((r) => r.isFirst);
                                        },
                                        child: const Text('초기화 후 이동'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                  : Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    player.name,
                                    style: TextStyle(fontSize: 32.sp, color: Colors.white),
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    formatDuration(player.seconds),
                                    style: TextStyle(
                                      fontSize: 80.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 40.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(0.9),
                                    foregroundColor: Colors.purple.shade800,
                                    textStyle: TextStyle(fontSize: 18.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      widget.players[currentIndex].isCompleted = true;
                                      pauseTimer();
                                      switchToNextPlayer();
                                    });
                                  },
                                  child: const Text('Complete'),
                                ),
                                SizedBox(height: 16.h),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white.withOpacity(0.9),
                                    foregroundColor: Colors.purple.shade800,
                                    textStyle: TextStyle(fontSize: 18.sp),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                                  ),
                                  onPressed: resetAll,
                                  child: const Text('Restart'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 20.h,
                        right: 20.w,
                        child: IconButton(
                          icon: Icon(FeatherIcons.home, color: Colors.white, size: 28.sp),
                          onPressed: () {
                            pauseTimer();
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('홈으로 이동'),
                                    content: const Text('정말 홈으로 가시겠습니까?\n설정을 유지하거나 초기화할 수 있습니다.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popUntil((r) => r.isFirst);
                                        },
                                        child: const Text('설정 유지'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          resetAll();
                                          Navigator.of(context).pop();
                                          Navigator.of(context).popUntil((r) => r.isFirst);
                                        },
                                        child: const Text('초기화 후 이동'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
