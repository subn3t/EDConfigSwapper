# Elite Dangerous Profile Swapper

A simple batch script utility to independently swap between different Elite Dangerous control bindings and display configurations. Mix and match controls and display settings for maximum flexibility.

## Features

- **Independent swapping** - Controls and display settings are separate
- Mix and match: HOTAS + VR, HOTAS + TV, Controller + VR, Controller + TV
- Simple double-click operation
- Preserves all Elite Dangerous settings including backups and logs
- Easily extensible to additional profiles

## What Gets Swapped

**Controls** (swap_controls.bat):
- All `.binds` files
- Start presets
- Binding backup files
- Error logs

**Display** (swap_display.bat):
- Display settings (resolution, windowed/fullscreen, VR mode, etc.)
- Quality settings (textures, shadows, bloom, anti-aliasing, etc.)
- All other graphics configuration files

## Prerequisites

- Elite Dangerous (Odyssey)
- Windows operating system

## Usage

Double-click the quick launchers to swap settings:

**Controls:**
- **_hotas.bat** - Switch to HOTAS control bindings
- **_controller.bat** - Switch to controller bindings

**Display:**
- **_vr.bat** - Switch to VR display settings
- **_2d.bat** - Switch to 2D/TV display settings

### Example Combinations

| Setup | Run |
|-------|-----|
| VR Simrig | `_hotas.bat` + `_vr.bat` |
| Couch Gaming | `_controller.bat` + `_2d.bat` |
| TV Simrig | `_hotas.bat` + `_2d.bat` |

Then launch Elite Dangerous and your settings will be active.

## File Structure

```
EDConfigSwapper/
├── swap_controls.bat       # Controls swapping script
├── swap_display.bat        # Display swapping script
├── capture_controls.bat    # Capture current control bindings
├── capture_display.bat     # Capture current display settings
├── _hotas.bat             # Quick launcher: HOTAS controls
├── _controller.bat        # Quick launcher: Controller
├── _vr.bat                # Quick launcher: VR display
├── _2d.bat                # Quick launcher: 2D display
├── controls/
│   ├── hotas/             # HOTAS control bindings
│   └── controller/        # Controller bindings
└── display/
    ├── vr/                # VR display settings
    └── 2d/                # 2D/TV display settings
```

## Setup Your Profiles

### Initial Capture

For each display profile you want to create:

1. Launch Elite Dangerous and configure your graphics for that setup
2. Exit Elite Dangerous
3. Run: `capture_display.bat <profile_name>`
   - Example: `capture_display.bat vr`
4. Repeat for each display profile

For control bindings:
1. Configure your controls in-game
2. Exit Elite Dangerous
3. Run: `capture_controls.bat <profile_name>`
   - Example: `capture_controls.bat hotas`

## Adding More Profiles

### New Controls Profile

1. Create folder: `controls/<profile_name>/`
2. Create launcher:
   ```batch
   @echo off
   call "%~dp0swap_controls.bat" <profile_name>
   ```
3. Copy your bindings into the folder

### New Display Profile

1. Create folder: `display/<profile_name>/`
2. Create launcher:
   ```batch
   @echo off
   call "%~dp0swap_display.bat" <profile_name>
   ```
3. Capture settings: `capture_display.bat <profile_name>`

## Important Notes

- Live Elite Dangerous folders:
  - Bindings: `%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Bindings`
  - Graphics: `%LOCALAPPDATA%\Frontier Developments\Elite Dangerous\Options\Graphics`
- Always exit Elite Dangerous before swapping profiles
- Controls swap completely clears the Bindings folder before copying
- Display swap overwrites existing graphics files

## Troubleshooting

**Script reports "Profile folder not found"**
- Ensure the profile folder exists in the correct location (`controls/` or `display/`)

**Display settings aren't changing**
- Make sure you've captured the settings with `capture_display.bat`
- Check that files exist in `display/<profile>/`

**Bindings aren't loading in-game**
- Verify the bindings files exist in `controls/<profile>/`
- Check Elite Dangerous binding loading errors in-game

## License

Free to use and modify as needed.
