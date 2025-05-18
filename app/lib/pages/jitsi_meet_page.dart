import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class JitsiMeetPage extends StatefulWidget {
  const JitsiMeetPage({Key? key}) : super(key: key);

  @override
  _JitsiMeetPageState createState() => _JitsiMeetPageState();
}

class _JitsiMeetPageState extends State<JitsiMeetPage> {
  String? _meetLink;
  bool _loading = false;

  String _generateJitsiLink() {
    final roomId = DateTime.now().millisecondsSinceEpoch.toString();
    return 'https://meet.jit.si/$roomId';
  }

  Future<void> _createJitsiMeet() async {
    setState(() {
      _loading = true;
    });

    final link = _generateJitsiLink();
    await Clipboard.setData(ClipboardData(text: link));
    await _openInBrowser(link);

    setState(() {
      _meetLink = link;
      _loading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Jitsi Meet link copied to clipboard!')),
    );

    _openInBrowser(link);
  }

  Future<void> _openInBrowser(String url) async {
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not open the link')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Jitsi Meet Creator')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _loading ? null : _createJitsiMeet,
                child: Text(
                  _loading ? 'Generating...' : 'Create Jitsi Meet Link',
                ),
              ),
              if (_meetLink != null) ...[
                const SizedBox(height: 20),
                SelectableText('Meet Link:\n$_meetLink'),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
