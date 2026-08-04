import 'package:Echo/themes/colors.dart';
import 'package:Echo/themes/typography.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:Echo/services/media_player.dart';
import 'package:Echo/utils/adaptive_widgets/buttons.dart';
import 'package:Echo/utils/adaptive_widgets/listtile.dart';
import 'package:Echo/utils/adaptive_widgets/progress_ring.dart';
import 'package:Echo/utils/song_thumbnail.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:Echo/utils/bottom_modals.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  Color? backgroundColor;



  void updateBackgroundColor(ImageProvider image) async {
    backgroundColor = AppColors.floatingPlayer(context);
  }

  @override
  Widget build(BuildContext context) {
    final mediaPlayer = GetIt.I<MediaPlayer>();
    final player = mediaPlayer.player;
    return StreamBuilder(
        stream: mediaPlayer.currentTrackStream,
        builder: (
          context,
          snapshot,
        ) {
          final data = snapshot.data;
          final currentSong = data?.currentItem;
          if (currentSong == null) {
            return const SizedBox(); // or loading indicator
          }
          return ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: GestureDetector(
              onTap: () {
                context.push('/player');
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4), // Reduced padding
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // LEFT: Song Info (Art + Text)
                          Expanded(
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SongThumbnail(
                                    song: currentSong.extras!,
                                    dp: MediaQuery.of(context)
                                        .devicePixelRatio,
                                    height: 40,
                                    width: 40,
                                    fit: BoxFit.fill,
                                    onImageReady: updateBackgroundColor,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: appTextTheme().bodyMedium?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.onFloatingPlayer(context),
                                        ),
                                      ),
                                      if (currentSong.artist != null ||
                                          currentSong.extras!['subtitle'] !=
                                              null)
                                        Text(
                                          currentSong.artist ??
                                              currentSong
                                                  .extras!['subtitle'],
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: appTextTheme().bodySmall?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.onFloatingPlayer(context).withValues(alpha: 0.8),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // RIGHT: Controls (Prev, Play/Pause, Next)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              StreamBuilder(
                                stream: context
                                    .watch<MediaPlayer>()
                                    .player
                                    .sequenceStateStream,
                                builder: (context, snapshot) {
                                  return AdaptiveIconButton(
                                    onPressed: () {
                                      player.seekToPrevious();
                                    },
                                    icon: Icon(
                                      Icons.skip_previous,
                                      size: 24,
                                      color: AppColors.onFloatingPlayer(context),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 4),
                              ValueListenableBuilder(
                                valueListenable:
                                    GetIt.I<MediaPlayer>().buttonState,
                                builder: (context, buttonState, child) {
                                  return (buttonState == ButtonState.loading)
                                      ? const SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: AdaptiveProgressRing(),
                                        )
                                      : AdaptiveIconButton(
                                          onPressed: () {
                                            player.playing
                                                ? player.pause()
                                                : player.play();
                                          },
                                          icon: Icon(
                                            buttonState ==
                                                    ButtonState.playing
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 30, // Slightly smaller play button
                                            color: AppColors.onFloatingPlayer(context),
                                          ),
                                        );
                                },
                              ),
                              const SizedBox(width: 4),
                              StreamBuilder(
                                stream: context
                                    .watch<MediaPlayer>()
                                    .player
                                    .sequenceStateStream,
                                builder: (context, snapshot) {
                                  return AdaptiveIconButton(
                                    onPressed: () {
                                    player.seekToNext();
                                    },
                                    icon: Icon(
                                      Icons.skip_next,
                                      size: 24,
                                      color: AppColors.onFloatingPlayer(context),
                                    ),
                                  );
                                },
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
        });
  }
}
