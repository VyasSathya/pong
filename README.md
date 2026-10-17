# 3D Pong

A local two-player Pong prototype built with Godot and GDScript. Play on a shared keyboard, name both players, and adjust the match through a reusable `GameConfig` resource.

## Play

1. Install Godot 4.3, the version recorded in [project.godot](project.godot).
2. Import `project.godot` in the Godot project manager.
3. Open the project and press **F5** to run it.
4. Enter player names, select **Play**, and press **Space** to serve.

| Action | Default key |
| --- | --- |
| Player 1 up / down | W / S |
| Player 2 up / down | Up / Down arrows |
| Serve the next round | Space |

Use **Settings** on the main menu to rebind paddle controls for the current session. The default match is first to five points.

## How it works

- [game.gd](scripts/game.gd) handles rounds, scoring, multiple balls, and the result screen.
- [ball.gd](scripts/ball.gd) and [paddle.gd](scripts/paddle.gd) implement the arena movement and collisions.
- [game_config.gd](scripts/game_config.gd) exposes ball count, speed increases, paddle speed, arena size, and the winning score in the inspector.
- [game_state.gd](scripts/game_state.gd) carries player names and results between scenes.

To experiment, create a `GameConfig` resource and assign it to the game scene's `config` property. For example, change `num_balls_per_round` from `1` to `2` for a multiball round.

## Project status

This repository contains the editor project and source scenes. A packaged game build and gameplay recording are not included. The README was checked against the source; gameplay has not been verified as part of that documentation review.

## License

This repository does not currently include a license. A public repository alone does not grant permission to reuse its code.
