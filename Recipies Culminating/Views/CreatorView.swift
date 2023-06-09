//
//  CreatorView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
    //
import Blackbird
import SwiftUI

struct CreatorView: View {
    
  //  let ingridientId: Int
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels({ db in try await Recipe.read(from: db)
    }) var Create
    @BlackbirdLiveModels({ db in try await Ingredient.read(from: db)
    }) var Ingre
   
   
    @BlackbirdLiveQuery var recip: Blackbird.LiveResults<Blackbird.Row>
    @State var recipeSteps : String = ""
    @State var nameDish : String = ""
    @State var ingredients: String = ""
    
   
    var body: some View {
        
        //Mark Initializer
        init(ingridientId: Int) {
            
            //  Initialize the live query
            _recip = BlackbirdLiveQuery(tableName: "Ingredient", { db in
                try await db.query("SELECT * FROM Ingredient WHERE recipe_id = \(ingridientId)")
            })
            
            self.ingridientId = ingridientId
            
        }
        
        
        NavigationView{
            ScrollView{
                VStack{
                    VStack{
                        Spacer()
                        Text("Name of the dish")
                            .bold()
                        TextField("Be original!", text:$nameDish )
                            .textFieldStyle(.roundedBorder)
                        Spacer()
                    }
                    VStack{
                        Spacer()
                        Text("Ingredients")
                            .bold()
                        HStack{
                            TextField("Add the ingredients and quantities ...", text:$ingredients
                            )
                            .textFieldStyle(.roundedBorder)
                            
                            
                            Button(action: {
                                Task {
                                    try await db!.transaction { core in
                                        try core.query("INSERT INTO Ingredient (description, recipe_id) VALUES ((?), (?))", ingredients, recipe_id)
                                    }
                                }
                                
                            }, label:{
                                Text("ADD")
                                    .font(.caption)
                            })
                            
                            
                        }
                    }
                    List{
                        ForEach(Ingre.results){
                            currentRecipe in
                            Label(title: {
                                Text(currentRecipe.description)
                            }, icon: {
                               
                            } )
                            
                           
                            
                        }

                        
                    }
                   Text("Steps")
                      .bold()
                   TextField("Write the steps ...", text:$recipeSteps )
                        .textFieldStyle(.roundedBorder)
                }
                
                Button(action: {
                    Task {
                        try await db!.transaction { core in
                            try core.query("""
INSERT INTO Recipe (name,steps)VALUES((?),(?)
)
""",
                                           nameDish, recipeSteps)
                        }
                        nameDish = ""
                        ingredients = ""
                        recipeSteps = ""
                    }
                    Task {
                        try await db!.transaction { core in
                            try core.query("""
INSERT INTO Ingredient (description,id) VALUES((?), (?)
)
""",
                                           ingredients)
                        }
                    }
                }, label:{
                    Text("SAVE")
                        
                })
                
            }
                .navigationTitle("Create Your Recipies")
            
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView(recip: 2)
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
