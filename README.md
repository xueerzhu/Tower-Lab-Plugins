# Tower Lab Plugins

A Unity project for developing and testing plugins for the Tower Lab game.

## Overview

This repository contains the plugin development environment for Tower Lab, providing:
- Plugin base classes and interfaces
- Development tools and utilities
- Plugin reference storage
- Testing framework

## Getting Started

1. Open the project in Unity (requires Unity 6000.2.0f1 or later)
2. Download and import plugins into the `Assets/Plugins/` directory for reference
3. Use "Tower Lab > Plugin Tools" menu for development utilities
4. Create your own plugins by inheriting from `PluginBase`

## Plugin Development Workflow

1. **Create**: Inherit from `PluginBase` or implement `IPlugin`
2. **Develop**: Write your plugin logic in `OnInitialize()` and Update methods
3. **Test**: Use the development tools to test your plugin
4. **Package**: Export as Unity package for integration with Tower Lab
5. **Deploy**: Import into main Tower Lab project

## Integration with Main Project

Plugins developed here are designed to be imported into the main Tower Lab project. The plugin system provides a clean interface for extending game functionality without modifying core systems.

## Documentation

See `Assets/Documentation/README.md` for detailed plugin development guide.

## Requirements

- Unity 6000.2.0f1 or later
- Compatible with Tower Lab project architecture