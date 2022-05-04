//
//  TESTApp.swift
//  TEST
//
//  Created by User02 on 2022/5/4.
//

import SwiftUI
import Firebase

@main
struct TESTApp: App {
    init() {
            FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
