/// Shared domain enums. Drift persists these by index — only append values,
/// never reorder or remove.
library;

enum TriggerType { onDemand, schedule, appLimit }

enum FrictionLevel { gentle, firm, strict }

enum SessionState { scheduled, active, completed, endedEarly, cancelled }

enum SessionEndReason { ranOut, earlyUnlock, cancelledBeforeStart }
