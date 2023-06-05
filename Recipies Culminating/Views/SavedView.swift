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
        try await IngridientsLis.read(from: db)
    }) var savedRecipes
    
    
    var body: some View {
       
        NavigationView{
            
            List(savedRecipes.results, id: \.id){currentAdvice in
                VStack(alignment:.leading){
                    Text(currentAdvice.name)
                        .bold()
                    Text("Steps")
                        .bold()
                    Text(currentAdvice.steps)
                        
                   
                }
            }
            .navigationTitle("Your Recipes")
        }
        
    }
}
    struct SavedView_Previews: PreviewProvider {
        static var previews: some View {
            SavedView()
        }
    }

