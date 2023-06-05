//
//  Recipies_CulminatingApp.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
//
import Blackbird
import SwiftUI

@main
struct Recipies_CulminatingApp: App {
    var body: some Scene {
        WindowGroup {
            
            TabView{
                
                CreatorView()
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem{
                        Label("Create Your Recipies", systemImage: "pencil")
                    }
                
                SavedView()
                    .environment(\.blackbirdDatabase, AppDatabase.instance)
                    .tabItem{
                        Label("Saved Recipies", systemImage: "book.fill")
                    }
                }
            
        }
    }
}
