# Project Documentation

Author: Otakar Kočí - [xkocio00@stud.fit.vut.cz](mailto:xkocio00@stud.fit.vut.cz)
Bachelor's thesis: Procedural generator of 3D voxel maps

## Structure of the Submitted Archive

The submitted archive has the following folder structure:

- `xkocio00_bp_archive/`
  - `thesis_src/`
  - `demo_src/`
  - `build/`
  - `extra/`
  - `README.md`
  - `video.mp4`
  - `thesis.pdf`


### Thesis LaTeX Sources

The folder `thesis_src/` contains the source files of the LaTeX project needed to build the document of the thesis. Inside it is the default template `Makefile`, which can be used to compile it into the resulting pdf document `projekt.pdf`. This `Makefile` was taken directly from the Overleaf template, without modifications.


### Demo Project Sources

The folder `demo_src/` contains the Godot project with the demo implementation. The important files and folders are the following: 

- `demo_src/`
  - `addons/`
  - `Materials/`
  - `Scenes/`
  - `Scripts/`
  - `project.godot`
  - `PCGVoxelLandscapes.csproj`
  - `PCGVoxelLandscapes.sln`
  - `export_presets.cfg`


The `addons/` folder contains a single third-party extension `DebugMenu` for performance tracking in game. It can be obtained from: [github.com/godot-extended-libraries/godot-debug-menu](https://github.com/godot-extended-libraries/godot-debug-menu).

The folder `Materials/` stores two Godot shader materials for per-voxel variance of solid surfaces and water surfaces with per-voxel variance and simulated waves and movement, together with their shader code. The third and basic material for solid surfaces is generated at runtime.

The `Scenes/` folder contains all Godot scene files, most notably `Root.tscn` and `Player.tscn`, which represent the root of the project and the player character respectively. Other scene files are `Settings.tscn`, `VoxelTypeItem.tscn`, and `VoxelSelectItem.tscn`, which are UI components.

By far the most important folder is `Scripts/`, which contains the demo implementation in C# script files. The notable script files include `Root.cs` and `Player.cs`, which are assigned to similarly named scenes and manage their behavior. The role of Game Manager described in thesis chapter "Generator Implementation in a Game Demo" is mostly fulfilled by the main script `Root.cs`. The layers of the hierarchical chunk system are implemented in the following scripts:


- Hierarchical Chunk System Layers
  - Model Generation Layer
    - `ModelService.cs`
    - `VoxelModel.cs`
    - `VoxelModelDefinitions.cs`
    - `VegetationGenerator.cs`
    - `TreeGenerator.cs`
    - `RockGenerator.cs`
    - `TrunkGenerator.cs`
    - `StalactiteGenerator.cs`
  - World Generation Layer
    - `WorldGeneratorService.cs`
    - `WorldRegion.cs`
    - `WorldGenerator.cs`
    - `WaterGenerator.cs`
  - Voxel Generation Layer
    - `VoxelGeneratorService.cs`
    - `VoxelStorage.cs`
    - `VoxelGenerator.cs`
  - Geometry Generation Layer
    - `GeometryGeneratorService.cs`
    - `GeometryGenerator.cs`
  - World Display Layer
    - `WorldDisplayService.cs`
    - `VoxelAtlas.cs`

The remaining components of the implementation include various user interface-related scripts, such as `Menu.cs`, storage managers `StorageService.cs`, and helper components `Helpers.cs` and `VoxelEditService.cs`, among others.

Other important files are `project.godot` and C# project configuration files.


### Available Executable Binaries

The `build/` folder contains binaries for Windows and Linux (64-bit x86 platform). If these binaries are not sufficient or not working, follow the description below for downloading the Godot Engine editor and running the project within it, as well as exporting it natively for your platform. 

### Additional Files

The `extra/` folder contains the poster and abstract that was submitted to the Excel@FIT conference, in which this bachelor's thesis has participated.

### Demonstration Video

The video in file `video.mp4` is a demonstration of the generator and demo capabilities. Its higher quality version is available at: [https://youtu.be/7SC6Dp_NB0w](https://youtu.be/7SC6Dp_NB0w).

### Thesis Text

The thesis text in the form of a PDF file is available in file `thesis.pdf`.

## Running within Engine and Exporting

In order to open, run, and export the project from within the Godot Engine editor, it is necessary to download the Godot Engine in version 4.6.2 (or newer bugfix version) with support for .NET scripting from the project website: [godotengine.org/download/archive/4.6.2-stable/](https://godotengine.org/download/archive/4.6.2-stable/). The .NET SDK in version 10 also must be installed in the system. It is available at: [dotnet.microsoft.com/en-us/download/dotnet/10.0](https://dotnet.microsoft.com/en-us/download/dotnet/10.0)

Then start the Godot Engine editor, and import the project from its project manager window, which should open by default. In this step, simply select the `project.godot` file at the root of the project, then open the imported project. After the engine initializes and successfully opens the project, it can be run immediately by clicking the arrow button in the top-right section of the window (or pressing F5).

To obtain an executable binary for you platform, first download the export templates. To do this, go to `Editor / Manage Export Templates` and click the **Download and Install** button. After the export templates are installed, the project can be exported to various platforms in `Project / Export` sub-menu. Just follow the existing presets, adjust them to your needs, and click the **Export Project** button.


## Application Manual


### Demo User Interface

Once opened, the application displays the title menu, from which the user can access the settings or worlds sub-menus. The settings sub-menu allows configuration of the demo visuals and render distances. It is important to note that it is available in-game as well, but the render distances can be changed only from within the title menu, due to implementation limitations.

The worlds sub-menu allows creation of new worlds as well as opening or deletion of existing ones. To create a new world, simply press the large button **Create New World**, which brings you to the world creation sub-menu. Here, choose a name and the world generation preset (Settings Profile) and press the **Create** button. If you wish, you can also adjust detailed world generator parameters, but note that some options, such as terrain height and cave generation, can significantly increase memory usage and reduce overall performance.


When a world is selected and opened, or is being created, the application shows a rudimentary loading screen that is hidden once the first geometry column is generated and displayed. It is normal that, upon entering the world space, only a few columns are rendered, and it might take some time before the majority of the area around the camera is ready.


### In-Game Controls

The camera can be moved with either **W**/**A**/**S**/**D** or arrow keys. Camera rotation is done with mouse movement. To move up and down, you can use the **Q**/**E** keys. Note that all movement is rotation-dependent. To toggle between the default fly mode and walking, use the **F** key. When walking, you can also jump with **Space**. To move faster, hold the **Left Shift** key, but note that, especially in high render distances, the chunk system will not be able to keep up with fast movement. You can also toggle a torch-like light source with **T** and toggle the basic sun cycle with **R**. To place and delete voxels in the area of the cross-hair, use the **Left Mouse** button for deletion and the **Right Mouse** button for placement. When you press the **Escape** key, you get to the pause sub-menu. Here you can leave the world, read the controls, access application settings, and most importantly, configure voxel editing and use teleportation.

The voxel size setting determines the size of the voxel cubes. Number 1 denotes the smallest cube (plant voxels), and 7 denotes the largest cube, which fills a whole chunk. The colors below indicate the supported voxel types that can be placed. Note that the last 8 voxel types are specific implementation voxels for the submerged category. Used by the demo to correctly visualize plants in water at different LODs.

The teleportation menu can be used to quickly move to a specified X, Z position in the world in meters from the world origin. Note that after teleportation, the demo will need some time before the new area is generated and starts rendering.

There are also some debugging hotkeys. Key **Y** shows the wireframe, and the keys **F2** and **F3** can be used to display the chunk system and other statistics, as well as the performance overlay, respectively.


### Demo Requirements

As discussed in the thesis chapter "Results Analysis", the demo is quite performance-intensive, especially in terms of memory and CPU utilization, particularly when configured with high render distances. The default configuration is an optimized preset with a very low render distance, which should run on practically any modern device with at least 8 GB of RAM, a quad-core CPU, and a GPU with at least 3 GB of VRAM and support for Vulkan or DirectX 12.

Higher render distances (Medium), as well as demanding world generator configurations (deeper caves, higher terrain range, etc.), should be run on devices with at least 16 GB of RAM, hexa or octa-core CPUs, and GPUs that offer decent performance. Render distances at or above the High preset should be considered experimental. These configurations require at least 32 GB of RAM and CPUs with many cores, as significantly more world segments need to be active and generated on the CPU.

### Known Issues

It was observed that some modern integrated Intel GPUs (such as iGPUs in Intel Core Ultra 7 155H) render the water surfaces incorrectly under Windows when the Forward+ renderer is used. However, when the project is run on these devices and the same configuration under Linux, no issues are present. If you observe these or similar issues, you can switch the renderer to Mobile in the Godot Engine editor (left-right section). However, other renderers than Forward+ were not tested, and the visual quality will be significantly reduced due to the lack of SDFGI and other rendering options.

The demo is very performance-heavy. On weak devices, it may take more than a minute for the world to initialize and start rendering. Similarly, stuttering during movement, as well as slow chunk column generation and LOD updates, can be observed.

The demo was thoroughly manually tested, and the bugs and errors were fixed. However, due to the complexity of the project, especially the parallelized hierarchical chunk system, it is very likely that many issues remain, potentially in the form of missing chunk columns, which was a very common problem during development.

If Godot Engine fails to register the configured main scene, select and run scene `Scenes/Root.tscn` when attempting to run the project. This situation happened a few times during the development of the project.

### Stored Data

The demo stores its data permanently in user space in a folder managed by the Godot Engine. To see the actual paths on your system, visit: [docs.godotengine.org/en/stable/tutorials/io/data_paths.html](https://docs.godotengine.org/en/stable/tutorials/io/data_paths.html). The actual name of the project sub-folder is `PCGVoxelLandscapes`. Along with engine-related files and folders, it contains a `config.json` file with the application configuration and a `worlds` folder that stores data of all created worlds (world configuration and edited voxels).
