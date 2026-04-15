// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../../../../core/theme/app_colors.dart';

// class CallScreen extends StatefulWidget {
//   final String doctorName;
//   final String doctorAvatarUrl;
//   final String doctorSpecialty;
//   final bool isVideo;

//   const CallScreen({
//     super.key,
//     required this.doctorName,
//     required this.doctorAvatarUrl,
//     required this.doctorSpecialty,
//     required this.isVideo,
//   });

//   @override
//   State<CallScreen> createState() => _CallScreenState();
// }

// class _CallScreenState extends State<CallScreen> {
//   late Timer _timer;
//   int _seconds = 0;
//   bool _muted = false;
//   bool _speakerOn = true;
//   bool _cameraOff = false;
//   bool _calling = true; // true = ringing, false = connected

//   @override
//   void initState() {
//     super.initState();
//     // Simulate call connecting after 2 seconds
//     Future.delayed(const Duration(seconds: 2), () {
//       if (mounted) setState(() => _calling = false);
//       _timer = Timer.periodic(const Duration(seconds: 1), (_) {
//         if (mounted) setState(() => _seconds++);
//       });
//     });
//   }

//   @override
//   void dispose() {
//     if (!_calling) _timer.cancel();
//     super.dispose();
//   }

//   String get _duration {
//     final m = (_seconds ~/ 60).toString().padLeft(2, '0');
//     final s = (_seconds % 60).toString().padLeft(2, '0');
//     return '$m:$s';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A2E),
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Background — blurred avatar for video, dark for audio
//             if (widget.isVideo && !_cameraOff)
//               Positioned.fill(
//                 child: CachedNetworkImage(
//                   imageUrl: widget.doctorAvatarUrl,
//                   fit: BoxFit.cover,
//                   color: Colors.black.withValues(alpha: 0.5),
//                   colorBlendMode: BlendMode.darken,
//                   errorWidget: (_, __, ___) =>
//                       Container(color: const Color(0xFF1A1A2E)),
//                 ),
//               ),

//             // Main content
//             Column(
//               children: [
//                 const SizedBox(height: 40),

//                 // Doctor info
//                 CircleAvatar(
//                   radius: 52,
//                   backgroundColor: AppColors.primaryContainer,
//                   backgroundImage: widget.doctorAvatarUrl.isNotEmpty
//                       ? CachedNetworkImageProvider(widget.doctorAvatarUrl)
//                       : null,
//                   child: widget.doctorAvatarUrl.isEmpty
//                       ? const Icon(Icons.person,
//                           size: 48, color: AppColors.primary)
//                       : null,
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Dr. ${widget.doctorName}',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 22,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 Text(
//                   widget.doctorSpecialty,
//                   style: TextStyle(
//                     color: Colors.white.withValues(alpha: 0.7),
//                     fontSize: 14,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   _calling ? 'Calling...' : _duration,
//                   style: TextStyle(
//                     color: _calling
//                         ? Colors.white.withValues(alpha: 0.6)
//                         : AppColors.primaryLight,
//                     fontSize: 16,
//                   ),
//                 ),

//                 const Spacer(),

//                 // Small self-view for video
//                 if (widget.isVideo)
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 16, bottom: 16),
//                       width: 90,
//                       height: 120,
//                       decoration: BoxDecoration(
//                         color: AppColors.primaryDark,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.white24),
//                       ),
//                       child: _cameraOff
//                           ? const Icon(Icons.videocam_off,
//                               color: Colors.white54)
//                           : const Icon(Icons.person,
//                               color: Colors.white54, size: 40),
//                     ),
//                   ),

//                 // Controls
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
//                   child: Column(
//                     children: [
//                       // Top controls row
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _ControlButton(
//                             icon: _muted ? Icons.mic_off : Icons.mic,
//                             label: _muted ? 'Unmute' : 'Mute',
//                             onTap: () => setState(() => _muted = !_muted),
//                             active: _muted,
//                           ),
//                           _ControlButton(
//                             icon: _speakerOn
//                                 ? Icons.volume_up
//                                 : Icons.volume_off,
//                             label: 'Speaker',
//                             onTap: () =>
//                                 setState(() => _speakerOn = !_speakerOn),
//                             active: !_speakerOn,
//                           ),
//                           if (widget.isVideo)
//                             _ControlButton(
//                               icon: _cameraOff
//                                   ? Icons.videocam_off
//                                   : Icons.videocam,
//                               label: 'Camera',
//                               onTap: () =>
//                                   setState(() => _cameraOff = !_cameraOff),
//                               active: _cameraOff,
//                             ),
//                           _ControlButton(
//                             icon: Icons.chat_bubble_outline,
//                             label: 'Chat',
//                             onTap: () => Navigator.pop(context),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 28),

//                       // End call button
//                       GestureDetector(
//                         onTap: () => Navigator.pop(context),
//                         child: Container(
//                           width: 68,
//                           height: 68,
//                           decoration: const BoxDecoration(
//                             color: AppColors.error,
//                             shape: BoxShape.circle,
//                           ),
//                           child: const Icon(
//                             Icons.call_end_rounded,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         'End Call',
//                         style: TextStyle(color: Colors.white54, fontSize: 12),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _ControlButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//   final bool active;

//   const _ControlButton({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//     this.active = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 52,
//             height: 52,
//             decoration: BoxDecoration(
//               color: active
//                   ? Colors.white.withValues(alpha: 0.3)
//                   : Colors.white.withValues(alpha: 0.1),
//               shape: BoxShape.circle,
//             ),
//             child: Icon(icon, color: Colors.white, size: 22),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             label,
//             style: const TextStyle(color: Colors.white70, fontSize: 11),
//           ),
//         ],
//       ),
//     );
//   }
// }




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/theme/app_colors.dart';

class CallScreen extends StatefulWidget {
  final String doctorName;
  final String doctorAvatarUrl;
  final String doctorSpecialty;
  final bool isVideo;

  const CallScreen({
    super.key,
    required this.doctorName,
    required this.doctorAvatarUrl,
    required this.doctorSpecialty,
    required this.isVideo,
  });

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  late Timer _timer;
  int _seconds = 0;
  bool _muted = false;
  bool _speakerOn = true;
  bool _cameraOff = false;
  bool _calling = true; // true = ringing, false = connected

  @override
  void initState() {
    super.initState();
    // Simulate call connecting after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _calling = false);
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _seconds++);
      });
    });
  }

  @override
  void dispose() {
    if (!_calling) _timer.cancel();
    super.dispose();
  }

  String get _duration {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Stack(
          children: [
            // Background — blurred avatar for video, dark for audio
            if (widget.isVideo && !_cameraOff)
              Positioned.fill(
                child: CachedNetworkImage(
                  imageUrl: widget.doctorAvatarUrl,
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.5), 
                  colorBlendMode: BlendMode.darken,
                  errorWidget: (_, __, ___) =>
                      Container(color: const Color(0xFF1A1A2E)),
                ),
              ),

            // Main content
            Column(
              children: [
                const SizedBox(height: 40),

                // Doctor info
                CircleAvatar(
                  radius: 52,
                  backgroundColor: AppColors.primaryContainer,
                  backgroundImage: widget.doctorAvatarUrl.isNotEmpty
                      ? CachedNetworkImageProvider(widget.doctorAvatarUrl)
                      : null,
                  child: widget.doctorAvatarUrl.isEmpty
                      ? const Icon(Icons.person,
                          size: 48, color: AppColors.primary)
                      : null,
                ),
                const SizedBox(height: 16),
                Text(
                  'Dr. ${widget.doctorName}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.doctorSpecialty,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7), 
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  _calling ? 'Calling...' : _duration,
                  style: TextStyle(
                    color: _calling
                        ? Colors.white.withOpacity(0.6) 
                        : AppColors.primaryLight,
                    fontSize: 16,
                  ),
                ),

                const Spacer(),

                // Small self-view for video
                if (widget.isVideo)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.only(right: 16, bottom: 16),
                      width: 90,
                      height: 120,
                      decoration: BoxDecoration(
                        color: AppColors.primaryDark,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white24),
                      ),
                      child: _cameraOff
                          ? const Icon(Icons.videocam_off,
                              color: Colors.white54)
                          : const Icon(Icons.person,
                              color: Colors.white54, size: 40),
                    ),
                  ),

                // Controls
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
                  child: Column(
                    children: [
                      // Top controls row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _ControlButton(
                            icon: _muted ? Icons.mic_off : Icons.mic,
                            label: _muted ? 'Unmute' : 'Mute',
                            onTap: () => setState(() => _muted = !_muted),
                            active: _muted,
                          ),
                          _ControlButton(
                            icon: _speakerOn
                                ? Icons.volume_up
                                : Icons.volume_off,
                            label: 'Speaker',
                            onTap: () =>
                                setState(() => _speakerOn = !_speakerOn),
                            active: !_speakerOn,
                          ),
                          if (widget.isVideo)
                            _ControlButton(
                              icon: _cameraOff
                                  ? Icons.videocam_off
                                  : Icons.videocam,
                              label: 'Camera',
                              onTap: () =>
                                  setState(() => _cameraOff = !_cameraOff),
                              active: _cameraOff,
                            ),
                          _ControlButton(
                            icon: Icons.chat_bubble_outline,
                            label: 'Chat',
                            onTap: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // End call button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 68,
                          height: 68,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.call_end_rounded,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'End Call',
                        style: TextStyle(color: Colors.white54, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: active
                  ? Colors.white.withOpacity(0.3) 
                  : Colors.white.withOpacity(0.1), 
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}