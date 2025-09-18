import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// YouTube Screen
class YouTubeScreen extends StatefulWidget {
  const YouTubeScreen({super.key});

  @override
  State<YouTubeScreen> createState() => _YouTubeScreenState();
}

class _YouTubeScreenState extends State<YouTubeScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  // Static const durations for performance
  static const Duration _animationDuration = Duration(milliseconds: 800);
  static const Duration _loadingDelay = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    _launchYoutube();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchYoutube() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(_loadingDelay);

    try {
      // Try to open YouTube app first
      final youtubeAppUrl =
          Uri.parse('youtube://www.youtube.com/@asiantvnews.');
      final youtubeWebUrl = Uri.parse('https://www.youtube.com/@asiantvnews.');

      if (await canLaunchUrl(youtubeAppUrl)) {
        await launchUrl(youtubeAppUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(youtubeWebUrl)) {
        await launchUrl(youtubeWebUrl, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch YouTube');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching YouTube: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_circle_filled,
                    size: 80,
                    color: Color(0xFFff4757),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Opening YouTube...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Asian TV News Channel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_isLoading)
                    const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFff4757)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Facebook Screen
class FacebookScreen extends StatefulWidget {
  const FacebookScreen({super.key});

  @override
  State<FacebookScreen> createState() => _FacebookScreenState();
}

class _FacebookScreenState extends State<FacebookScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  // Static const durations for performance
  static const Duration _animationDuration = Duration(milliseconds: 800);
  static const Duration _loadingDelay = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    _launchFacebook();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchFacebook() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(_loadingDelay);

    try {
      // Try to open Facebook app first, then fallback to browser
      final facebookAppUrl = Uri.parse('fb://page/asiantvchannelofficial');
      final facebookWebUrl =
          Uri.parse('https://www.facebook.com/asiantvchannelofficial/');

      // Try Facebook app first
      if (await canLaunchUrl(facebookAppUrl)) {
        await launchUrl(facebookAppUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(facebookWebUrl)) {
        // Fallback to browser
        await launchUrl(facebookWebUrl, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch Facebook');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching Facebook: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.facebook,
                    size: 80,
                    color: Color(0xFF3742fa),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Opening Facebook...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Asian TV Official Page',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_isLoading)
                    const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF3742fa)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Instagram Screen
class InstagramScreen extends StatefulWidget {
  const InstagramScreen({super.key});

  @override
  State<InstagramScreen> createState() => _InstagramScreenState();
}

class _InstagramScreenState extends State<InstagramScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  bool _isLoading = false;

  // Static const durations for performance
  static const Duration _animationDuration = Duration(milliseconds: 800);
  static const Duration _loadingDelay = Duration(milliseconds: 1500);

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));

    _animationController.forward();
    _launchInstagram();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchInstagram() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(_loadingDelay);

    try {
      // Try to open Instagram app first
      final instagramAppUrl =
          Uri.parse('instagram://user?username=asiantvnews.in');
      final instagramWebUrl = Uri.parse(
          'https://www.instagram.com/asiantvnews.in?igsh=MW83aTExNTE4Nzlhaw==');

      if (await canLaunchUrl(instagramAppUrl)) {
        await launchUrl(instagramAppUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(instagramWebUrl)) {
        await launchUrl(instagramWebUrl, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch Instagram');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error launching Instagram: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a2e),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 80,
                    color: Color(0xFFff3838),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Opening Instagram...',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Asian TV Channel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (_isLoading)
                    const CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFff3838)),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
