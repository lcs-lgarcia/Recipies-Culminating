//
//  SavedView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
//
import Blackbird
import SwiftUI

struct SavedView: View {
    
    @BlackbirdLiveModels({ db in
        try await Creator.read(from: db)
    }) var savedRecipes
    
    
    var body: some View {
       
        NavigationView{
            
            List(savedRecipes.results, id: \.id){currentRecipe in
                VStack(alignment:.leading){
                    Text(currentRecipe.name)
                        .bold()
                    Text(currentRecipe.ingridients)
                    Text("Steps")
                        .bold()
                    Text(currentRecipe.steps)
                        
                   
                }
            }
            .navigationTitle("Your Recipes")
        }
        
    }
}
    struct SavedView_Previews: PreviewProvider {
        static var previews: some View {
            SavedView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }

