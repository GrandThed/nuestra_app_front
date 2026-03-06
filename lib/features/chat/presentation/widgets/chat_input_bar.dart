import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuestra_app/core/services/image_picker_service.dart';
import 'package:nuestra_app/core/utils/file_utils.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class ChatInputBar extends StatefulWidget {
  final void Function(String text, List<String> imageUrls) onSend;
  final bool isSending;

  const ChatInputBar({super.key, required this.onSend, this.isSending = false});

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  final _imagePickerService = ImagePickerService();
  final List<String> _attachedImagePaths = [];

  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _speechAvailable = false;
  bool _isListening = false;

  bool get _canSend =>
      !widget.isSending &&
      (_controller.text.trim().isNotEmpty || _attachedImagePaths.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    try {
      _speechAvailable = await _speech.initialize(
        onError: (_) {
          if (mounted) setState(() => _isListening = false);
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            if (mounted) setState(() => _isListening = false);
          }
        },
      );
    } catch (_) {
      _speechAvailable = false;
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _speech.stop();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSend() {
    if (!_canSend) return;

    final text = _controller.text.trim();
    final images = List<String>.from(_attachedImagePaths);

    _controller.clear();
    setState(() {
      _attachedImagePaths.clear();
    });

    widget.onSend(text, images);
  }

  Future<void> _pickImage() async {
    final choice = await ImagePickerService.showImageSourcePicker(
      context,
      allowMultiple: false,
    );
    if (choice == null) return;

    final source = choice == ImagePickerChoice.camera
        ? ImageSource.camera
        : ImageSource.gallery;

    final file = await _imagePickerService.pickImage(source: source);
    if (file != null) {
      setState(() {
        _attachedImagePaths.add(file.path);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _attachedImagePaths.removeAt(index);
    });
  }

  Future<void> _toggleListening() async {
    if (!_speechAvailable) return;

    if (_isListening) {
      await _speech.stop();
      setState(() => _isListening = false);
    } else {
      setState(() => _isListening = true);
      await _speech.listen(
        onResult: (result) {
          setState(() {
            _controller.text = result.recognizedWords;
            _controller.selection = TextSelection.fromPosition(
              TextPosition(offset: _controller.text.length),
            );
          });
        },
        localeId: 'es_AR',
        listenOptions: stt.SpeechListenOptions(
          listenMode: stt.ListenMode.dictation,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasText = _controller.text.trim().isNotEmpty;
    final hasImages = _attachedImagePaths.isNotEmpty;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(6, 4, 6, 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Attached images preview
            if (hasImages)
              Container(
                height: 76,
                margin: const EdgeInsets.only(bottom: 6),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 8),
                  itemCount: _attachedImagePaths.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox(
                              width: 68,
                              height: 68,
                              child: fileImage(
                                _attachedImagePaths[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 2,
                            right: 2,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

            // Input row
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Text field with embedded icons
                Expanded(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colorScheme.surfaceContainerHighest
                          .withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // Attach image
                        Padding(
                          padding: const EdgeInsets.only(left: 4, bottom: 2),
                          child: IconButton(
                            onPressed:
                                widget.isSending ? null : _pickImage,
                            icon: Icon(
                              Icons.attach_file_rounded,
                              color: colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.7),
                            ),
                            iconSize: 24,
                            tooltip: 'Adjuntar imagen',
                          ),
                        ),

                        // Text field
                        Expanded(
                          child: KeyboardListener(
                            focusNode: FocusNode(skipTraversal: true),
                            onKeyEvent: kIsWeb
                                ? (event) {
                                    if (event is KeyDownEvent &&
                                        event.logicalKey ==
                                            LogicalKeyboardKey.enter &&
                                        !HardwareKeyboard
                                            .instance.isShiftPressed) {
                                      // Prevent newline insertion on web
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        // Remove the trailing newline that was just inserted
                                        final text = _controller.text;
                                        if (text.endsWith('\n')) {
                                          _controller.text =
                                              text.substring(0, text.length - 1);
                                          _controller.selection =
                                              TextSelection.fromPosition(
                                            TextPosition(
                                                offset:
                                                    _controller.text.length),
                                          );
                                        }
                                        _handleSend();
                                      });
                                    }
                                  }
                                : null,
                            child: TextField(
                              controller: _controller,
                              focusNode: _focusNode,
                              enabled: !widget.isSending,
                              maxLines: 5,
                              minLines: 1,
                              textCapitalization:
                                  TextCapitalization.sentences,
                              style: const TextStyle(fontSize: 16),
                              decoration: InputDecoration(
                                hintText: _isListening
                                    ? 'Escuchando...'
                                    : 'Mensaje',
                                hintStyle: TextStyle(
                                  color: colorScheme.onSurfaceVariant
                                      .withValues(alpha: 0.5),
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 12,
                                ),
                                isDense: true,
                              ),
                              onChanged: (_) => setState(() {}),
                              onSubmitted: (_) => _handleSend(),
                            ),
                          ),
                        ),

                        // Camera icon (inside field, right side)
                        Padding(
                          padding: const EdgeInsets.only(right: 4, bottom: 2),
                          child: IconButton(
                            onPressed: widget.isSending
                                ? null
                                : () async {
                                    final file =
                                        await _imagePickerService.pickImage(
                                      source: ImageSource.camera,
                                    );
                                    if (file != null) {
                                      setState(() {
                                        _attachedImagePaths.add(file.path);
                                      });
                                    }
                                  },
                            icon: Icon(
                              Icons.camera_alt_outlined,
                              color: colorScheme.onSurfaceVariant
                                  .withValues(alpha: 0.7),
                            ),
                            iconSize: 24,
                            tooltip: 'Cámara',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 6),

                // Mic / Send button — swaps based on content
                SizedBox(
                  width: 48,
                  height: 48,
                  child: widget.isSending
                      ? DecoratedBox(
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        )
                      : (hasText || hasImages)
                          ? Material(
                              color: colorScheme.primary,
                              shape: const CircleBorder(),
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: _handleSend,
                                child: Center(
                                  child: Icon(
                                    Icons.send_rounded,
                                    size: 22,
                                    color: colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            )
                          : _speechAvailable
                              ? Material(
                                  color: _isListening
                                      ? colorScheme.error
                                      : colorScheme.primary,
                                  shape: const CircleBorder(),
                                  child: InkWell(
                                    customBorder: const CircleBorder(),
                                    onTap: _toggleListening,
                                    child: Center(
                                      child: Icon(
                                        _isListening
                                            ? Icons.stop_rounded
                                            : Icons.mic,
                                        size: 22,
                                        color: _isListening
                                            ? colorScheme.onError
                                            : colorScheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                )
                              : Material(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.4),
                                  shape: const CircleBorder(),
                                  child: const Center(
                                    child: Icon(
                                      Icons.send_rounded,
                                      size: 22,
                                      color: Colors.white38,
                                    ),
                                  ),
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
