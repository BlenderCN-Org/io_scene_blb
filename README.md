# Blender BLB Exporter #
[![License: GPL v2](https://img.shields.io/badge/License-GPL%20v2-blue.svg)](https://img.shields.io/badge/License-GPL%20v2-blue.svg)

A [Blender](https://www.blender.org/) add-on written in Python 3 for exporting [Blockland](http://blockland.us/) bricks (.BLB files) directly from Blender 2.67 and newer without the need for intermediary formats or external programs. It works on the principle of "what you see is what you get", the brick will look exactly the same in-game as it does in the 3D viewport<sup>[__*__](#exporter-fn-1)</sup>.

The add-on does not support importing .BLB files yet.


## Table of Contents ##
1. [Features](#features)
   1. [Additional Features](#additional-features)
   1. [Planned Features](#planned-features)
1. [Installation](#installation)
   1. [Updating](#updating)
1. [Blender Export Properties](#blender-export-properties)
   1. [Bricks to Export](#bricks-to-export)
   1. [Brick Name from (Single Export)](#brick-name-from-single-export)
   1. [Export Only (Single Export)](#export-only-single-export)
   1. [Brick Names from (Multiple Export)](#brick-names-from-multiple-export)
   1. [Bricks Defined by (Multiple Export)](#bricks-defined-by-multiple-export)
   1. [Export Bricks in (Multiple Export)](#export-bricks-in-multiple-export)
   1. [Forward Axis](#forward-axis)
   1. [Scale](#scale)
   1. [Apply Modifiers](#apply-modifiers)
   1. [Calculate Collision](#calculate-collision)
   1. [Coverage](#coverage)
   1. [Automatic Quad Sorting](#automatic-quad-sorting)
   1. [Use Material Colors](#use-material-colors)
   1. [Use Vertex Colors](#use-vertex-colors)
   1. [Parse Object Colors](#parse-object-colors)
   1. [Calculate UVs](#calculate-uvs)
   1. [Store UVs](#store-uvs)
   1. [Round Normals](#round-normals)
   1. [Custom Definition Tokens](#custom-definition-tokens)
   1. [Terse Mode](#terse-mode)
   1. [Write Log](#write-log)
   1. [Only on Warnings](#only-on-warnings)
   1. [Precision](#precision)
1. [Terminology](#terminology)
1. [Definition Tokens](#definition-tokens)
   1. [Definition Objects](#definition-objects)
      1. [Defining Brick Grid](#defining-brick-grid)
   1. [Mesh Definition Tokens](#mesh-definition-tokens)
      1. [Defining Quad Sorting & Coverage](#defining-quad-sorting--coverage)
      1. [Defining Colors](#defining-colors)
   1. [Brick Textures](#brick-textures)
1. [UV Mapping](#uv-mapping)
	1. [The TOP Brick Texture](#the-top-brick-texture)
1. [Rounded Values](#rounded-values)
1. [Troubleshooting](#troubleshooting)
	1. [Automatically calculated UV coordinates for brick textures are distorted](#automatically-calculated-uv-coordinates-for-brick-textures-are-distorted)
	1. [Automatically calculated UV coordinates for brick textures are rotated incorrectly](#automatically-calculated-uv-coordinates-for-brick-textures-are-rotated-incorrectly)
1. [Contributors](#contributors)

## Features ##
The exporter supports all BLB features.
- [x] Brick size
   - Automatic calculation or manually defined
- [x] Brick grid
   - Automatic calculation (full brick only) or manually defined
- [x] Coverage
   - Manually define hiding own and adjacent brick quads
   - Automatic area calculation for arbitrary brick grid shapes
   - Automatic and/or manual quad sorting
- [x] Collision boxes
   - Automatic calculation (full brick only) or manually defined
- [x] Textures
   - Automatic (side texture only) or manual brick texture definition
- [x] Quads
   - Triangles are automatically converted to quads
   - N-gons are ignored
- [x] UV coordinates
   - Manually define UV coordinates
   - Automatic UV calculation for all brick textures
- [x] Colors
   - Multiple ways to define colors: materials, object names, vertex paint
   - Per-vertex coloring
   - Transparency
   - Additive and subtractive colors
- [x] Flat and smooth shading
- [ ] DTS collision is intentionally not a part of this add-on as it an entirely different file format.
   - See Nick Smith's [io_scene_dts](https://github.com/portify/io_scene_dts) for a Blender DTS importer/exporter.

### Additional Features ###
- [x] Save and load export settings
- [x] Export multiple bricks from the same file
- [x] Vertices are all relative to the defined or calculated brick bounds
   - Object centers (orange dot) are irrelevant: calculations are performed using raw vertex world coordinates
   - Object locations relative to the origin of the world are irrelevant: the calculated center of the brick bounds acts as the new world origin
   - Object locations relative to the Blender grid are irrelevant: the brick bounds define the brick grid origin (however it is highly recommended to align the brick bounds object with the Blender grid for ease of use)
   - This allows you to easily create multiple bricks in the same file in any location in the 3D space and the bricks still export correctly as expected
   - Arbitrary brick grid rotation, however, is not supported
- [x] Selective object export: selection, visible layers, entire scene
- [x] Change brick rotation during export: does not affect objects in viewport
- [x] Change brick scale during export: does not affect objects in viewport
- [x] Apply modifiers (e.g. edge split) during export: does not affect objects in viewport
- [x] Terse file writing: excludes optional lines from the BLB file
- [x] Pretty .BLB files: extraneous zeros are not written at the end of floating point values and if possible, they are written as integers
- [x] Logging with descriptive error and warning messages to help you correct problems with the model
- [x] Changeable floating point accuracy

### Planned Features ###
These features may or may not be implemented at some unspecified time in the future.

- Importing .BLB files
- Export-time brick rotation on the Z-axis
- Automatic rendering of the brick preview icon

## Installation ##
1. Download the add-on using one of them methods below:
    1. **The cutting edge:** [download the latest version of the develop branch](https://github.com/DemianWright/io_scene_blb/archive/develop.zip) or go to the [develop branch page](https://github.com/DemianWright/io_scene_blb/tree/develop) and press `Clone or download > Download ZIP`.
        * The develop branch contains the newest features still under active development. Some functionality may be broken or only half-implemented.
    1. **The latest version:** [download the latest version of the master branch](https://github.com/DemianWright/io_scene_blb/archive/master.zip) or go to the [front page](https://github.com/DemianWright/io_scene_blb) of the repository and press `Clone or download > Download ZIP`.
    1. **A specific version:** [go to the releases page](https://github.com/DemianWright/io_scene_blb/releases) and follow the instructions on the specific release.
1. Open Blender and go to `File > User Preferences > Add-ons`.
1. Press the `Install from File...` button at the bottom of the dialog and find the downloaded .ZIP file.
1. Press `Install from File...` again.
1. Enable the add-on in the add-ons list and press `Save User Settings` to keep the add-on enabled the next time you start Blender.
1. The export option is under `File > Export > Blockland Brick (.blb)`.

### Updating ###
1. Open Blender and go to `File > User Preferences > Add-ons`.
1. Quickly find the add-on by typing `blb` into the search field.
1. Expand the add-on by clicking the white triangle on the left, press the `Remove` button, and confirm the removal.
1. Follow the installation instructions above.

## Blender Export Properties ##
The following properties are present in the current version of the exporter.

#### Bricks to Export ####
How many bricks to export in one go from the file.

Value | Description
------|------------
Single | Export only one brick. (Default)
Multiple | Export one or more bricks. Shows additional settings when selected.

#### Brick Name from (Single Export) ####
Where the .BLB file name is defined.

Value | Description
------|------------
Bounds | Brick name is defined in the [Bounds object](#definition-objects-bounds) after the bounds definition token, separated with a whitespace character. Export file dialog is only used set to directory. (Default)
File | Brick name is the same as the file name. Can be manually set in the export file dialog.

#### Export Only (Single Export) ####
Which objects to process and export to the .BLB file.

Value | Description
------|------------
Selection | Objects that are selected and have an orange outline. (Default)
Layers | All objects in the layers that are currently visible, regardless of selection.
Scene | All objects in the current scene. I.e. all objects in all layers regardless of the layer visibility.

#### Brick Names from (Multiple Export) ####
Where the names of the .BLB files are defined.

Value | Description
------|------------
Bounds | Brick names are defined in the [Bounds object](#definition-objects-bounds) after the bounds definition token, separated with a whitespace character. Export file dialog is only used set to directory. (Default)
Groups | Brick names are the same as the names of the groups name. Export file dialog is only used set to directory.

#### Bricks Defined by (Multiple Export) ####
How is a single brick defined.

Value | Description
------|------------
Groups | Each brick is in its own group. Objects in multiple groups belong to multiple bricks. (Default)
Layers | Each brick is in its own layer. Objects in multiple layers belong to multiple bricks. When selected brick names must be defined in the [Bounds object](#definition-objects-bounds).

#### Export Bricks in (Multiple Export) ####
Which bricks to process and export to .BLB files.

Value | Description
------|------------
Layers | Export all bricks in the layers that are currently visible. (Default)
Scene | Export all bricks in the current scene. I.e. all bricks in all layers regardless of the layer visibility.

#### Forward Axis ####
The Blender 3D axis that will point forwards in-game when the player plants the brick directly in front of them without rotating it. Does not change the rotation of the objects in the Blender scene.

Possible values:
- Positive X-axis ("Right")
- Default: Positive Y-axis ("Forward")
- Negative X-axis ("Left")
- Negative Y-axis ("Back")

#### Scale ####
The scale of the brick in-game. Values outside the the range of 0.001–400.0 may be typed in manually. Does not change the scale of the objects in the Blender scene. (Default: 100%)

:exclamation: Be aware that at 100% scale a 1x1x1 Blockland brick is defined to be 1.0 x 1.0 x 1.2 Blender units on the X, Y, and Z axes. In other words a 1x1f plate would be 1.0 x 1.0 x 0.4 Blender units.

#### Apply Modifiers ####
Applies any modifiers on the object before exporting. Does not change the modifiers of the objects in the Blender scene. (Default: True)

#### Calculate Collision ####
If no manual collision definition objects exist, calculates a cuboid collision that is the same size as the brick bounds. If disabled and no collision is defined, brick will have no collision. (Default: True)

#### Coverage ####
Enable coverage calculations. Shows additional settings when selected. This is pointless unless [Automatic Quad Sorting](#automatic-quad-sorting) is enabled or at least one object has a quad sorting definition. See [Defining Quad Sorting & Coverage](#defining-quad-sorting--coverage) for more information. (Default: False)

#### Automatic Quad Sorting ####
Automatically calculate the correct section for quads that in the same plane as the bounding planes of the bounds object. This is pointless unless [Coverage](#coverage) is enabled. (Default: True)

#### Use Material Colors ####
Get object colors from object materials. (Default: False)

#### Use Vertex Colors ####
Get object colors from vertex color layers. (Default: False)

#### Parse Object Colors ####
Get object colors from object names. (Default: False)

#### Calculate UVs ####
Automatically calculate correct UV coordinates based on the brick texture name specified in the material name. See [UV Mapping](#uv-mapping) for more information. (Default: True)

#### Store UVs ####
Write calculated UVs into Blender objects. Data in existing generated UV layers will be overwritten. See [UV Mapping](#uv-mapping) for a list of generated UV layer names. (Default: True)

#### Round Normals ####
Round vertex normals to the user-defined floating point value precision. If disabled normals will be written as accurately as possible but extraneous zeros will still be removed. (Default: False)

#### Custom Definition Tokens ####
Allows you to specify the definition tokens the exporter uses. Shows additional settings when selected. See [Definition Tokens](#definition-tokens) for more information. (Default: False)

#### Terse Mode ####
When enabled does not write optional lines to the .BLB file such as the lines marking the different quad sections. Using this option is not recommended as it makes the .BLB file harder to read and understand. Although the file is shorter, the difference in file size is negligible. (Default: False)

#### Write Log ####
Write a log file to the same folder as the exported brick detailing the export process. Shows additional settings when selected. (Default: True)

#### Only on Warnings ####
Write a log file only if warnings or errors occurred during the export process. (Default: True)

#### Precision ####
Allows you to specify a custom precision for floating point numbers. See [Rounded Values](#rounded-values) for more details. (Default: 0.000001)

## Terminology ##
Term | Definition
-----|-----------
Axis Aligned Plane | A plane where all vertices have the same coordinates on exactly on axis. I.e. when viewed from one of the three axes the plane cannot be seen as it is viewed directly from the side.
Brick Grid | The three dimensional space of the game divided into 1x1x1 plates, also the blocks of characters near the top of the .BLB file containing characters such as `u`, `x`, and `-` that define whether bricks may be placed above, below, or inside this brick grid "slot" (the space of a 1x1x1 plate).
Brick | A collection of meshes that act as a single object in Blockland and all the non-visual data it contains. (E.g. brick grid information.)
Coverage | The coverage system describes how to hide faces on this and adjacent bricks, also the 6 pairs of integers near the top of the .BLB file.
Cuboid | More specifically a **right cuboid**. A [convex polyhedron](https://en.wikipedia.org/wiki/Convex_polytope) with 6 faces that are all at right angles with each other. I.e. a cube or a cube that has been scaled on one axis.
Definition Object | An object containing a special definition token. These objects cannot be seen in-game. They exist to tell the exporter how to create the brick.
Definition Token | A special word in an object's name that tells the exporter what to do with that object.
Face | A **tri** or a **quad**.
Mesh | The vertices, edges, and faces that make up a 3D model. Multiple meshes can be within an object. Used interchangeably with **object** and **model**.
Model | See object. Used interchangeably with **object** and **mesh**.
N-gon | A plane with more than 4 vertices. These are not supported.
Object | The things you see in the 3D viewport. Blender objects can contain multiple meshes. This document uses this term interchangeably with **model** and **mesh**.
Plane | A two-dimensional surface in 3D space. Used interchangeably with **tri** and **quad**.
Quad | A plane with 4 vertices.
Token | A string (word) of one or more letters surrounded with a whitespace character (usually a space) on one or both sides.
Tri | A plane with 3 vertices. (A triangle.) Not supported by Blockland bricks, converted to **quads** automatically.
Volume | A piece of 3D space, usually cuboidal in shape.

## Definition Tokens ##
An object may contain other text in addition to definition tokens as long as the tokens themselves are separated from other tokens and text by one whitespace character. (E.g. a space.) The definition tokens may be changed from the defaults by selecting `Custom Definition Tokens` in the export dialog.

Blender adds a running index (e.g. `.003`) to the end of duplicate object, material, etc. names. This is handled correctly, you need not worry about it. The logic for removing the index simply checks if `.` is the fourth last character in the object name and simply removes it an everything after it.

Below is a full list of all definition tokens. For more information on what each of them do, read the rest of the readme.

Token | Usable In | Description
------|-----------|------------
`bounds` | Object name | The bounds object.
`collision` | Object name | A collision box.
`c` | Object name | Define object color.
`qt` | Object name | Sort quads in top section.
`qb` | Object name | Sort quads in bottom section.
`qn` | Object name | Sort quads in north section.
`qe` | Object name | Sort quads in east section.
`qs` | Object name | Sort quads in south section.
`qw` | Object name | Sort quads in west section.
`qo` | Object name | Sort quads in omni section.
`gridb` | Object name | Write brick grid `b` symbol.
`gridd` | Object name | Write brick grid `d` symbol.
`gridu` | Object name | Write brick grid `u` symbol.
`grid-` | Object name | Write brick grid `-` symbol.
`gridx` | Object name | Write brick grid `x` symbol.
`blank` | Material name | Do not write a color.
`cadd` | Material name, vertex color layer name | Use color as an additive color.
`csub` | Material name, vertex color layer name | Use color as a subtractive color.

### Definition Objects ###
When a definition object token is read in an object's name it is treated as a definition object. Definition objects are never exported as visual 3D models, in fact they are not exported at all. Instead the data they contain in their name (or elsewhere) and the 3D space they represent is processed further to acquire the necessary information for the BLB file.

Definition Object | Token | Requirements | Maximum Count/Brick | Axis Aligned | Brick Grid Aligned | Can Overlap | Description
------------------|-------|--------------|--------------------:|:------------:|:------------------:|:-----------:|------------
<a name="definition-objects-bounds">Bounds</a> | `bounds` | At least 2 vertices, must have volume | 1 | Yes [**(1)**](#definition-objects-fn-1) | Yes | N/A | Defines the brick bounds (brick size).
<a name="definition-objects-collision">Collision</a> | `collision` | At least 2 vertices, must be within [**Bounds**](#definition-objects-bounds) object [**(2)**](#definition-objects-fn-2) | 10 | Yes [**(3)**](#definition-objects-fn-3)  | No | Yes | Defines a collision box.
Brick Grid | See [Defining Brick Grid](#defining-brick-grid) | At least 2 vertices, must have volume, must be within [**Bounds**](#definition-objects-bounds) object | Unlimited | Yes [**(1)**](#definition-objects-fn-1) | Yes | Yes [**(4)**](#definition-objects-fn-4) | Defines a volume in the brick grid to fill with a specific brick grid symbol.

<a name="definition-objects-fn-1">**(1)**</a> It is highly recommended to use axis aligned cuboids to define bounds and the brick grid. However, if you insist on defining the size of your brick in monkey heads, you can. Only the minimum and maximum coordinates of the bounds and brick grid objects are used.

<a name="definition-objects-fn-2">**(2)**</a> Collision boxes outside brick bounds are not invalid and the brick will function in-game. This behavior is not allowed by the exporter because collision outside brick bounds is horribly broken as it was never intended work in that manner.

<a name="definition-objects-fn-3">**(3)**</a> Blockland only supports [AABB collision](https://en.wikipedia.org/wiki/Minimum_bounding_box#Axis-aligned_minimum_bounding_box) with bricks. In other words brick collision may only be defined using boxes of varying sizes that align with the axes. You can rotate said boxes however you want but that does translate to collision boxes that are at an angle in-game. Only the the minimum and maximum coordinates of the object are used. Using anything else than cuboids to define collision is not recommended as it makes the Blender file more confusing to understand.

<a name="definition-objects-fn-4">**(4)**</a> See [Defining Brick Grid](#defining-brick-grid) for the specific rules about overlapping brick grid definitions.

#### Defining Brick Grid ####
Brick grid definitions represent a 3D volume in the 3D space the brick grid encompasses. You can imagine it as if the entire cuboidal shape of the brick would be filled with 1x1f plates and these volumes define the properties of all the 1x1f plates within that volume. Each brick grid definition has their own priority. When two or more brick grid definition objects overlap in 3D space, the one with the **higher** priority takes precedence and will overwrite the symbols in the brick grid that any definitions with lower priorities would have written.

:exclamation: Be aware that if your brick does not contain a `brickd` definition on the bottom of the brick, the brick cannot be planted on other bricks or the ground.

Token | Brick Grid Symbol | Description
------|:-----------------:|------------
`gridb` | `b` | Bricks may be placed above and below this volume. This brick can be planted on the ground.
`gridd` | `d` | Bricks may be placed below this volume. This brick can be planted on the ground.
`gridu` | `u` | Bricks may be placed above this volume.
`grid-` | `-` | Bricks may be placed inside this volume. (I.e. empty space.) This is the default symbol, any volume that does not have a brick grid definition uses this symbol.
`gridx` | `x` | Bricks may not be placed inside this volume.

### Mesh Definition Tokens ###
Objects that have one or more of these definition tokens are exported into the BLB file and can be seen in-game. The definition tokens below will not cause an object to be treated as a definition object. These objects are exported normally and can be seen in-game. Instead the definition token will change some aspect of the mesh or brick.

A single object may not contain the same definition more than once.

Definition | Token | Requirements | Maximum Count/Brick | Axis Aligned | Brick Grid Aligned | Description 
-----------|-------|--------------|--------------------:|:------------:|:------------------:|------------
<a name="mesh-definition-tokens-color">Color</a> | `c` <red> <green> <blue> <alpha> | See [Defining Colors](#defining-colors) | Unlimited | No | No | Defines the object's RGBA color.
Coverage | See [Defining Quad Sorting & Coverage](#defining-quad-sorting--coverage) | Must contain a face | Unlimited | No | No | Assigns the object's quads into a specific section in the brick.

#### Defining Quad Sorting & Coverage ####
BLB files allow model quads to be sorted into seven sections: top, bottom, north, east, south, west, and omni. Quads in these sections may then be automatically hidden in-game using the coverage system, if it is defined correctly in the BLB file. This way the game does not have to render quads that are completely covered by adjacent bricks improving frame rate when a large number of bricks are on the screen at once. Quads are sorted into these sections by using one of the tokens below in the name of the object containing the faces to be sorted in that section. If nothing is specified, omni section is used.

Token | Section
------|--------
`qt` | Top
`qb` | Bottom
`qn` | North
`qe` | East
`qs` | South
`qw` | West
`qo` | Omni ("any" or "none", default)

Sorting quads in the manner described above is pointless unless the [Coverage](#coverage) property in the export dialog is enabled and at least one option is enabled. The coverage properties have two options for each section/side of the brick:

Option | Description
-------|------------
Hide Self | When enabled, for example for the **top section**, the game will not render the quads in the **top** section of **this brick** when the **top** area of **this brick** is **completely covered**.
Hide Adjacent | When enabled, for example for the **top section**, the game will not render the quads in the **bottom** section of **adjacent bricks** on **top** of this brick if the coverage rules for those bricks are fulfilled.

#### Defining Colors ####
The exporter supports three methods for defining vertex colors. To allow faces to be colored using the spray can tool in-game, do not assign a color those faces.

Method | Overrides | Extent of Coloring | RGB Values | Alpha Value | Notes
-------|-----------|--------------------|------------|-------------|------
Object Colors | In-game paint color | Entire object (color & alpha)| In object name after the [Color token](#mesh-definition-tokens-color) [**(1)**](#defining-colors-fn-1) | In object name after the red, green, and blue values | Implemented only to support legacy 3D brick models, not recommended for use.
Material Colors | Object Colors | Assigned faces (color & alpha) | In `Material` tab as `Diffuse Color` | In `Material` tab under `Transparency` in `Alpha` slider| Recommended method for defining colors. Multiple materials may be used in a single object.
Vertex Colors | Material Colors | Entire object (per-vertex color), entire object (alpha) | In `Data` tab under `Vertex Color` as a vertex color layer, modified using the `Vertex Paint` mode | In `Data` tab under `Vertex Color` as the name of the vertex color layer [**(2)**](#defining-colors-fn-2) | Creating a vertex color layers will color the entire object white, but the color of individual vertices may be changed.

There are three definition tokens that are specific to dealing with colors.

Token | Usable In | Description
------|-----------|------------
<a name="defining-colors-blank">`blank`</a> | Material name | Ignore the material's color and do not write any color for the faces with this material assigned so they can be colored by the spray can in-game. This feature exists because an object that has a material, cannot have faces that do not have a material assigned to them.
`cadd` | Material name, vertex color layer name | Use this color as an additive color: add the values of this color to the spray can color in-game. For example to make the spray can color a little lighter use a **dark gray** color.
`csub` | Material name, vertex color layer name | Use this color as a subtractive color: subtract the values of this color from the spray can color in-game. For example to make the spray can color a lot darker use a **light gray** color.

<a name="defining-colors-fn-1">**(1)**</a> The exporter understands two ways of defining an RGBA color using text:
1. The commonly used method of writing 4 integers that are in the range 0–255, where 0 is black, separated with a whitespace character such as a space. For example `127 255 10 191` for a yellow-green color that is 25% transparent. A full object name could be for example `glass c 240 255 255 128.001`.
   - In the above example the running index `.001` that Blender added at the end would be removed by the exporter.
1. Writing 4 decimals in the range 0.0–1.0, where 0.0 is black, separated with a whitespace character such as a space. An object could have a name such as `c 0,125 0,0 0,5 1,0 flower`, for example.
   - :exclamation: Please note that you **must** use a comma character (`,`) as the decimal separator.
   - The leading zero may be omitted.
   - Up to 16 decimals are supported.

<a name="defining-colors-fn-2">**(2)**</a> The definition of the alpha color value follows the same rules as described in footnote [**(1)**](#defining-colors-fn-1).

### Brick Textures ###
Defining brick textures is done using Blender materials. To assign a brick texture to a face, assign a material to it containing a valid brick texture name (case insensitive):
- `bottomedge`
- `bottomloop`
- `print`
- `ramp`
- `side`
- `top`

If no brick texture is defined, `side` is used. Material name may contain other words as long as the brick texture name is separated from them with one whitespace character such as a space. A common combination is to define a brick texture name and the [definition token `blank`](#defining-colors-blank) (e.g. `blank ramp` or `ramp blank`) to allow the player to color the face in-game using the spray can.

#### UV Mapping ####
Manually defined UV coordinates must be stored in one or more UV layers that do not share a name with one of the automatically generated UV layers:
- `TEX:BOTTOMEDGE`
- `TEX:BOTTOMLOOP`
- `TEX:PRINT`
- `TEX:RAMP`
- `TEX:TOP`

Any data in UV layers with one the names above will the overwritten during automatic UV calculation.

:exclamation: Note that BLB files only support storing quads. As such, any tris with UV coordinates will have their last UV coordinate duplicated to transform it into a quad. This may or may not cause visual distortion in the UV mapping.

If the [Calculate UVs](#calculate-uvs) property is enabled, UV coordinates will be automatically calculated based on the dimensions of the quad and the name of the material assigned to it. (See [Brick Textures](#brick-textures) to learn how to define brick textures with materials.) The generated coordinates are only guaranteed to be correct for strictly rectangular quads, for any other shapes the results may not be satisfactory. If using brick textures on non-rectangular quads it is recommended to manually define the UV coordinates for best results.

### The TOP Brick Texture ###
Blockland automatically performs rotations on the UV coordinates of the TOP brick texture during runtime so that the lightest side of the texture is always facing towards the sun. Because of this there is no correct way of representing the TOP brick texture in Blender. As a compromise the exporter will rotate the lightest side of the TOP brick texture to face towards the axis select in the [Forward Axis](#forward-axis) property. This means the UV coordinates of the TOP brick texture in Blender may not match those in the written BLB file.

## Rounded Values ##
Floating point numbers (numbers with a decimal point) contain [inherent inaccuracies](https://en.wikipedia.org/wiki/Floating_point#Accuracy_problems). For example when exporting a 1x1x1 brick model at the maximum accuracy the vertex coordinate of one of the corners is `0.5 0.5 1.5000000596046448`. This causes the 1x1x1 brick to be `3.00000011920928955078125` plates tall instead of exactly `3.0` like it should. The only way to get rid of this error is to round the number (vertex coordinates). Practically speaking it is impossible to visually discern the difference between a brick that is 3 plates tall versus one that is `3.00000011920928955078125` plates tall in the game. The floating point errors are effectively 0. The only real benefit that comes from the rounding is nicer looking .BLB files.

The default value of `0.000001` was chosen through manual testing. Rest assured that the rounding will cause no visual oddities whatsoever because the value is so small. This was manually confirmed with a sphere brick made from 524288 quads. Moving the camera as close to the surface of the brick as the game was capable of rendering, the surface of the sphere appeared mathematically perfect because the distance between the vertices was less than the size of a single pixel.

:exclamation: The exporter will only ever write 16 decimal places regardless of the precision of the value.

Floating Point Value | Rounded
---------------------|:------:
Visible mesh vertex coordinates | Yes
[Bounds object](#definition-objects-bounds) vertex coordinates | Yes
[Collision object](#definition-objects-collision) vertex coordinates | Yes
[Brick grid object](#defining-brick-grid) vertex coordinates | Yes
Normal vectors | [Optional](#round-normals)
[RGBA color](#defining-colors) values | No
[UV coordinates](#uv-mapping) | No

## Troubleshooting ##
Solutions to common issues with the BLB Exporter. If you have another issue with the exporter be sure to enable the [Write Log](#write-log) property and export again. The log file may contain warnings or errors describing the issue with the model.

### Automatically calculated UV coordinates for brick textures are distorted ###
The automatic UV calculation is only designed to work with rectangular quads. Manually define UV coordinates for non-rectangular quads.

### Automatically calculated UV coordinates for brick textures are rotated incorrectly ###
The quad with incorrectly rotated UV coordinates (e.g. the lightest side of the SIDE texture pointing sideways instead of up) is not a perfect rectangle. Even one vertex being off by some minuscule, visually indistinguishable amount from a perfectly rectangular shape can cause the automatic UV calculation to incorrectly determine the rotation of the quad. Double check all 4 coordinates of the quad and manually correct any floating point errors. If working on axis-aligned quads or if the vertices should be on grid points snapping the coordinates of the problem quad to grid coordinates using `Mesh > Snap > Snap Selection to Grid` usually fixes floating point errors.

## Contributors ##
- [Nick Smith](https://github.com/portify) - The original source code for reading, processing, and writing Blender data into the .BLB format. It has essentially been completely rewritten since.
- [Demian Wright](https://github.com/DemianWright) - Everything else.

<a name="exporter-fn-1">__*__</a> There's always a footnote, see the issue with [the TOP brick texture](#the-top-brick-texture).