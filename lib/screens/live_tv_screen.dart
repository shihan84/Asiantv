import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class LiveTvScreen extends StatefulWidget {
  const LiveTvScreen({super.key});

  @override
  State<LiveTvScreen> createState() => _LiveTvScreenState();
}

class _LiveTvScreenState extends State<LiveTvScreen>
    with TickerProviderStateMixin {
  VideoPlayerController? _videoPlayerController;
  bool _isInitialized = false;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  bool _showControls = true;
  bool _isDemoMode = false;

  // Static const durations for performance
  static const Duration _videoTimeout = Duration(seconds: 5);
  static const Duration _controlsTimeout = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    // Allow all orientations when entering Live TV
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _initializePlayerWithFallback();
  }

  @override
  void dispose() {
    // Reset to portrait only when leaving Live TV
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initializePlayerWithFallback() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = '';
      });

      // Try primary URL first
      final primaryUrl = 'https://live.ekamraott.com/4tv/asian/index.m3u8';

      _videoPlayerController?.dispose();
      _videoPlayerController = VideoPlayerController.networkUrl(
        Uri.parse(primaryUrl),
      );

      // Set up timeout
      final timeoutFuture = Future.delayed(_videoTimeout, () {
        if (!_isInitialized && mounted) {
          throw TimeoutException('Video loading timeout', _videoTimeout);
        }
      });

      await _videoPlayerController!.initialize();

      // Cancel timeout if video loads successfully
      timeoutFuture.ignore();

      if (mounted) {
        setState(() {
          _isInitialized = true;
          _isLoading = false;
          _hasError = false;
        });
        _videoPlayerController!.play();
        // Add listener for progress updates
        _videoPlayerController!.addListener(() {
          if (mounted) {
            setState(() {});
          }
        });
      }
    } catch (e) {
      print('Primary video failed: $e');

      // Try fallback URL
      try {
        final fallbackUrl =
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4';

        _videoPlayerController?.dispose();
        _videoPlayerController = VideoPlayerController.networkUrl(
          Uri.parse(fallbackUrl),
        );

        await _videoPlayerController!.initialize();

        if (mounted) {
          setState(() {
            _isInitialized = true;
            _isLoading = false;
            _hasError = false;
            _isDemoMode = true;
          });
          _videoPlayerController!.play();
          // Add listener for progress updates
          _videoPlayerController!.addListener(() {
            if (mounted) {
              setState(() {});
            }
          });
        }
      } catch (fallbackError) {
        print('Fallback video also failed: $fallbackError');

        if (mounted) {
          setState(() {
            _isLoading = false;
            _hasError = true;
            _errorMessage =
                'Unable to load video. Please check your internet connection.';
            _isDemoMode = true;
          });
        }
      }
    }
  }

  void _retryVideo() {
    _initializePlayerWithFallback();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isLandscape = orientation == Orientation.landscape;

          return GestureDetector(
            onTap: () {
              setState(() {
                _showControls = !_showControls;
              });

              // Auto-hide controls after 10 seconds
              if (_showControls) {
                Future.delayed(_controlsTimeout, () {
                  if (mounted) {
                    setState(() {
                      _showControls = false;
                    });
                  }
                });
              }
            },
            child: Stack(
              children: [
                // Video Player
                if (_isInitialized && _videoPlayerController != null)
                  Positioned.fill(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _videoPlayerController!.value.size.width,
                        height: _videoPlayerController!.value.size.height,
                        child: VideoPlayer(_videoPlayerController!),
                      ),
                    ),
                  )
                else if (_isLoading)
                  const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Loading Live TV...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                else if (_hasError)
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 64,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _retryVideo,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                else
                  const Center(
                    child: Text(
                      'Demo Mode - No Video Available',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                // Controls Overlay
                if (_showControls)
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.9),
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                        ),
                      ),
                      child: isLandscape
                          ? Row(
                              children: [
                                // Left side - Back button
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),

                                // Center - Live indicator and title
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: const Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: Colors.white,
                                              size: 8,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'LIVE',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text(
                                        'Asian TV Live',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Center - Video controls
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Play/Pause button
                                      if (_videoPlayerController != null)
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (_videoPlayerController!
                                                  .value.isPlaying) {
                                                _videoPlayerController!.pause();
                                              } else {
                                                _videoPlayerController!.play();
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              _videoPlayerController!
                                                      .value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                      const SizedBox(width: 20),
                                      // Fullscreen toggle
                                      GestureDetector(
                                        onTap: () {
                                          if (isLandscape) {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.portraitUp,
                                            ]);
                                          } else {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft,
                                            ]);
                                          }
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            isLandscape
                                                ? Icons.fullscreen_exit
                                                : Icons.fullscreen,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                // Top - Back button and title
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 12,
                                                vertical: 6,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: const Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(
                                                    Icons.circle,
                                                    color: Colors.white,
                                                    size: 8,
                                                  ),
                                                  SizedBox(width: 6),
                                                  Text(
                                                    'LIVE',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            const Text(
                                              'Asian TV Live',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          SystemChrome
                                              .setPreferredOrientations([
                                            DeviceOrientation.landscapeLeft,
                                          ]);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.5),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.fullscreen,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Bottom - Play/Pause and other controls
                                const Spacer(),
                                // Progress bar
                                if (_videoPlayerController != null &&
                                    _videoPlayerController!.value.isInitialized)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        // Progress bar
                                        Container(
                                          height: 4,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                          child: LinearProgressIndicator(
                                            value: _videoPlayerController!.value
                                                    .position.inMilliseconds /
                                                _videoPlayerController!.value
                                                    .duration.inMilliseconds,
                                            backgroundColor: Colors.transparent,
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(Colors.red),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        // Time display
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _formatDuration(
                                                  _videoPlayerController!
                                                      .value.position),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              _formatDuration(
                                                  _videoPlayerController!
                                                      .value.duration),
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Play/Pause button
                                      if (_videoPlayerController != null)
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (_videoPlayerController!
                                                  .value.isPlaying) {
                                                _videoPlayerController!.pause();
                                              } else {
                                                _videoPlayerController!.play();
                                              }
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.7),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              _videoPlayerController!
                                                      .value.isPlaying
                                                  ? Icons.pause
                                                  : Icons.play_arrow,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                      // Volume button
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.volume_up,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                      // Settings button
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.7),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.settings,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),

                // Floating control button (always visible)
                Positioned(
                  top: 50,
                  right: 20,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showControls = !_showControls;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        _showControls ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),

                // Footer for Live TV
                if (!isLandscape)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  Colors.white.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '© 2024 Asian TV Cable Network',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text(
                            'Hyderabad, India',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white60,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TimeoutException implements Exception {
  final String message;
  final Duration timeout;

  TimeoutException(this.message, this.timeout);

  @override
  String toString() =>
      'TimeoutException: $message (timeout: ${timeout.inSeconds}s)';
}
