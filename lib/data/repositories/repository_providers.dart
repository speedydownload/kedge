import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/providers.dart';
import '../../domain/session_service.dart';
import 'profile_repository.dart';
import 'session_repository.dart';
import 'stats_repository.dart';

part 'repository_providers.g.dart';

@Riverpod(keepAlive: true)
ProfileRepository profileRepository(Ref ref) =>
    ProfileRepository(ref.watch(databaseProvider));

@Riverpod(keepAlive: true)
SessionRepository sessionRepository(Ref ref) =>
    SessionRepository(ref.watch(databaseProvider));

@Riverpod(keepAlive: true)
StatsRepository statsRepository(Ref ref) =>
    StatsRepository(ref.watch(databaseProvider));

@Riverpod(keepAlive: true)
StreakRepository streakRepository(Ref ref) =>
    StreakRepository(ref.watch(databaseProvider));

@Riverpod(keepAlive: true)
SessionService sessionService(Ref ref) => SessionService(
      sessions: ref.watch(sessionRepositoryProvider),
      stats: ref.watch(statsRepositoryProvider),
      streaks: ref.watch(streakRepositoryProvider),
      engine: ref.watch(blockingEngineProvider),
    );
