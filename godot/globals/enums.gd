extends Node

enum GameStatus {
    PLAYING,
    WON,
    LOST,
}

enum Faction {
    PLAYER,
    ENEMY,
}

enum UpgradeWallSize {
    # Half the screen width.
    HALF,
    # A third of the screen width.
    THIRD,
}

enum LootCategory {
	BASIC,
	BOSS,
}
