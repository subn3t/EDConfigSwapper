# Elite Dangerous Profile Swapper

A simple batch script utility to quickly swap between different Elite Dangerous control and graphics configurations. Perfect for switching between VR/HOTAS and 2D/controller setups with a single double-click.

## Features

- Instantly swap control bindings between profiles
- Automatically apply graphics settings optimized for each setup
- Simple double-click operation
- Preserves all Elite Dangerous settings including backups and logs
- Easily extensible to additional profiles

## What Gets Swapped

**Control Bindings:**
- All `.binds` files
- Start presets
- Binding backup files
- Error logs

**Graphics Settings:**
- Display settings (resolution, windowed/fullscreen, etc.)
- Quality settings (textures, shadows, bloom, anti-aliasing, etc.)
- All other graphics configuration files

## Prerequisites

- Elite Dangerous (Odyssey)
- Windows operating system

## Installation

1. Clone or download this repository
2. **IMPORTANT:** Edit `capture_graphics.bat` and update the graphics folder path if needed:
   ```batch
   set "GRAPHICS_LIVE=%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics"
   ```
   The default path should work for most installations.

3. Create your profile folders if they don't exist:
   - `vr_hotas/` - For your VR setup
   - `2d_controller/` - For your 2D setup
   - Add more profiles as needed (see "Adding More Profiles" below)

## Setup Your Profiles

### Initial Capture

For each profile you want to create:

1. Launch Elite Dangerous and configure your controls and graphics for that setup
2. Exit Elite Dangerous
3. Run: `capture_graphics.bat <profile_name>`
   - Example: `capture_graphics.bat vr_hotas`
4. Repeat for each profile

### What Gets Captured

The capture script will copy:
- All files from your Elite Dangerous Bindings folder to `<profile>/`
- All files from your Elite Dangerous Graphics folder to `<profile>/Graphics/`

## Usage

Simply double-click the profile launcher you want to use:

- **vr_hotas.bat** - Switch to VR/HOTAS setup
- **2d_controller.bat** - Switch to 2D/controller setup

The script will:
1. Clear the live bindings folder
2. Copy all bindings from the selected profile
3. Copy all graphics settings from the selected profile
4. Report success or any errors

Then launch Elite Dangerous and your settings will be active.

## File Structure

```
EDBinds swapper/
├── swap_binds.bat              # Main swapping script (called by profile launchers)
├── capture_graphics.bat        # Helper script to capture current settings
├── vr_hotas.bat               # VR profile launcher
├── 2d_controller.bat          # 2D profile launcher
├── vr_hotas/                  # VR profile folder
│   ├── Graphics/              # VR graphics settings
│   └── [bindings files]       # VR control bindings
└── 2d_controller/             # 2D profile folder
    ├── Graphics/              # 2D graphics settings
    └── [bindings files]       # 2D control bindings
```

## Adding More Profiles

To create additional profiles (e.g., for racing, exploration, combat):

1. Create a new folder with your profile name (e.g., `racing`)
2. Create a new launcher batch file:
   ```batch
   @echo off
   setlocal
   set "PROFILE=%~n0"
   call "%~dp0swap_binds.bat" "%PROFILE%"
   endlocal
   ```
3. Name it `racing.bat` (must match the folder name)
4. Configure settings in-game and capture them: `capture_graphics.bat racing`

## How It Works

### swap_binds.bat
The main script that performs the swap:
1. Validates the profile folder exists
2. Clears the live Elite Dangerous Bindings folder
3. Copies all bindings from the profile folder (excluding Graphics subfolder)
4. Copies all graphics settings from the profile's Graphics subfolder to the live Graphics folder

### capture_graphics.bat
Helper script to save current settings:
1. Takes a profile name as argument
2. Copies all files from Elite Dangerous Graphics folder to the profile's Graphics subfolder
3. Creates the Graphics subfolder if it doesn't exist

### Profile Launchers (vr_hotas.bat, 2d_controller.bat)
Simple wrappers that:
1. Extract their own filename as the profile name
2. Call swap_binds.bat with that profile name

## Important Notes

- The live Elite Dangerous folders are:
  - Bindings: `%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Bindings`
  - Graphics: `%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics`
- Always exit Elite Dangerous before swapping profiles
- The swap script completely clears the Bindings folder before copying - this ensures clean swaps
- Graphics files are overwritten, not cleared
- Your original settings are preserved in the profile folders

## Troubleshooting

**Script reports "Profile folder not found"**
- Ensure the profile folder exists and matches the launcher filename exactly

**Graphics settings aren't changing**
- Make sure you've captured the graphics settings with `capture_graphics.bat`
- Check that the `Graphics/` subfolder exists in your profile folder

**Bindings aren't loading in-game**
- Verify the bindings files exist in your profile folder
- Check Elite Dangerous binding loading errors in-game

## License

Free to use and modify as needed.
