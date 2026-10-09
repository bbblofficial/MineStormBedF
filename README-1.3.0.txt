BedFight 1.3.0 - build: mvn clean package   (JDK 8+; output: target/BedFight-1.3.0.jar, SQLite shaded in)

NEW / REWRITTEN (Java 8 clean):
  BedFightPlugin, db/*, lobby/LobbyManager, game/MatchManager, game/Match, hook/PlaceholderHook,
  listener/EventListener, command/CommandRouter, util/Messages, util/ConfigMerger, util/WorldFiles,
  util/Defense, arena/Pos, arena/Teams (display/name repaired), resources: config.yml, messages.yml, plugin.yml

UNTOUCHED BUT DAMAGED BY THE DECOMPILER (JD-Core loses string-concat operands of Java 9+ code):
  party/PartyManager, party/PartyCommand, party/PartyGui, party/PartyListener, command/BedFightCommand,
  gui/PrivateMatchGui, spectate/SpectatorManager, kit/KitEditorGui, kit/KitManager, scoreboard/ScoreboardManager
  Symptoms: "PREFIX + PREFIX", "String.valueOf(X) + String.valueOf(X)", "" + ... - the message text/variables are gone.
  They compile, but chat/GUI text is wrong. Re-decompile ONLY these files from your original BedFight-1.2.1.jar
  with CFR or Vineflower (both handle invokedynamic string concat) and paste them over; only Java-8 edits are needed
  (replace List.of -> Arrays.asList).

----------------------------------------------------------------------------------------------------
CHANGES (aqua/white theme, messages.yml, /bedfight creator)
  * /bedfight creator  -> prints "Created by Itz_nanm" (players + console, no permission needed). The credit line is
    re-added automatically if it is removed from messages.yml (creator.lines).
  * messages.yml now holds the chat prefix, the queue/match/spectate/arena-setup/admin messages and every on-screen
    title (titles.*). Placeholders are {name}. Reload with /bedfight reload.
  * Theme is aqua (&b) + white (&f): chat prefix, messages, titles, scoreboard.yml, party chat format, and the
    party / private-match / kit / spectator menus. Team colours are NOT changed (they identify the teams).
  * Fixed two syntax breaks that were already in the uploaded source: Sounds.java:38 and PartyManager.java:142
    (a dropped comma in a lambda call, "}delay)" -> "}, delay)").
  * BedFightCommand: the lost message operands were reconstructed (arena/world/player names etc.).

NOT YET IN messages.yml (text still hard-coded in these files, but recoloured to aqua/white):
  party/PartyManager, party/PartyCommand, party/PartyGui, party/PartyListener, gui/PrivateMatchGui,
  kit/KitEditorGui, kit/KitManager (item/GUI text), spectate/SpectatorManager (item names), arena/Arena.validate()
  (admin validation errors). Their text is damaged by the decompiler (see above); re-decompile them from the
  original 1.2.1 jar and they can be moved to messages.yml the same way.

SOUNDS + AUTO-MERGE
  * New voices.yml keys (coin = ORB_PICKUP, LEVEL_UP): countdown-count, countdown-final, spawn, fight-go,
    respawn-count (pitch rises, see respawn-sounds in config.yml), respawn-done.
  * Every bundled .yml (config, messages, settings, voices, scoreboard) is merged on start and on /bedfight reload:
    missing keys are added with their comments, your existing values are never changed or deleted.
