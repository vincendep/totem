# Totem

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Hammerspoon](https://img.shields.io/badge/Hammerspoon-0.9.90-blue.svg)](https://www.hammerspoon.org/)
[![Version](https://img.shields.io/badge/version-1.0-blue.svg)](https://github.com/vincendep/totem)

Totem is a Hammerspoon window manager script that allows you to easily manage window positions using hotkeys.

## Features

- Move windows to predefined positions on the screen
- Supports various window positions such as center, left, right, top, bottom, and more
- Easily configurable hotkeys

## Installation

1. Install [Hammerspoon](https://www.hammerspoon.org/).
2. Clone this repository or download the `init.lua` file.
3. Place the `init.lua` file in your Hammerspoon configuration directory (`~/.hammerspoon/`).

## Usage

1. Open Hammerspoon and ensure it is running.
2. Edit your `~/.hammerspoon/init.lua` file to include the following line to load Totem:

    ```lua
    local totem = require("init")
    totem:init()
    ```

3. Configure your hotkeys by calling the `bindHotKeys` function with your desired key mappings. For example:

    ```lua
    totem:bindHotKeys({
        center = {{"cmd", "alt"}, "C"},
        left = {{"cmd", "alt"}, "Left"},
        right = {{"cmd", "alt"}, "Right"},
        top = {{"cmd", "alt"}, "Up"},
        bottom = {{"cmd", "alt"}, "Down"},
        top_left = {{"cmd", "alt"}, "1"},
        top_right = {{"cmd", "alt"}, "2"},
        bottom_left = {{"cmd", "alt"}, "3"},
        bottom_right = {{"cmd", "alt"}, "4"},
    })
    ```

4. Reload your Hammerspoon configuration by clicking the Hammerspoon menu icon and selecting "Reload Config".

## License

This project is licensed under the MIT License. See the [LICENSE](https://opensource.org/licenses/MIT) file for details.

## Author

Vincenzo De Petris - [vincenzodepetris@gmail.com](mailto:vincenzodepetris@gmail.com)

## Homepage

[https://github.com/vincendep/totem](https://github.com/vincendep/totem)