//
//  ChuckapiApp.swift
//  Chuckapi
//
//  Created by Kostiantyn Kaniuka on 31.01.2023.
//

import SwiftUI

@main
struct ChuckapiApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
            ContentView()
                    .navigationTitle("Norris Jokes")
                        .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
