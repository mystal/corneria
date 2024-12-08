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

enum FireBehavior {
	## The Shooter will automatically fire when not on cooldown.
	AUTO,
	## The Shooter can request to shoot, limited by its fire rate cooldown.
	AT_WILL,
}
