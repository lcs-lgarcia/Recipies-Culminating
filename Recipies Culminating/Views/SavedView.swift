//
//  SavedView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
//
import Blackbird
import SwiftUI

struct SavedView: View {
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    @BlackbirdLiveModels({ db in
        try await Recipe.read(from: db)
    }) var savedRecipes
    @BlackbirdLiveModels({ db in
        try await Ingredient.read(from: db)
    }) var savedIngr
    
    var body: some View {
       
        NavigationView{
            
            List(savedRecipes.results, id: \.id){currentRecipe in
                VStack(alignment:.leading){
                    Text(currentRecipe.name)
                        .bold()
                    List(savedIngr.results, id: \.recipe_id){currentRecip in
                        VStack(alignment:.leading){
                            Text(currentRecip.description)
                        }
                    }
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

