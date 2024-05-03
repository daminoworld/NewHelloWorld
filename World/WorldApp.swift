/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main entry point of the Hello World experience.
*/

import SwiftUI
import WorldAssets

/// The main entry point of the Hello World experience.
@main
struct WorldApp: App {
    // The view model.
    @State private var model = ViewModel()

    // The immersion styles for different modules.
    @State private var orbitImmersionStyle: ImmersionStyle = .mixed
    @State private var solarImmersionStyle: ImmersionStyle = .full

    var body: some Scene {
        // The main window that presents the app's modules.
        WindowGroup("Hello World", id: "modules") {
            Modules()
                .environment(model)
        }
        .windowStyle(.plain)

        // A volume that displays a globe.
        // Learned: Volumetric window의 max 사이즈는 2x2x2이다.
        // Learned: Volume의 사이즈는 처음 띄워질때 크기로 고정된다
        WindowGroup(id: Module.globe.name) {
            Shoe1()
                .aspectRatio(contentMode: .fit)
        }
        .windowStyle(.volumetric)
        .defaultSize(width: 0.01, height: 0.01, depth: 0.01, in: .meters)

        // An immersive space that places the Earth with some of its satellites
        // in your surroundings.
        ImmersiveSpace(id: Module.orbit.name) {
            Orbit()
                .environment(model)
        }
        .immersionStyle(selection: $orbitImmersionStyle, in: .mixed)

        // An immersive Space that shows the Earth, Moon, and Sun as seen from
        // Earth orbit.
        ImmersiveSpace(id: Module.solar.name) {
            SolarSystem()
                .environment(model)
        }
        .immersionStyle(selection: $solarImmersionStyle, in: .full)
    }
    
    init() {
        // Register all the custom components and systems that the app uses.
        RotationComponent.registerComponent()
        RotationSystem.registerSystem()
        TraceComponent.registerComponent()
        TraceSystem.registerSystem()
        SunPositionComponent.registerComponent()
        SunPositionSystem.registerSystem()
    }
}
