//
//  CreatorView.swift
//  Recipies Culminating
//
//  Created by Lucas García on 29/5/23.
    //
import Blackbird
import SwiftUI

struct CreatorView: View {
    
    @Environment(\.blackbirdDatabase) var db: Blackbird.Database?
    
    @BlackbirdLiveModels({ db in try await Creator.read(from: db)
    }) var create
    @BlackbirdLiveModels({ db in try await Ingridient.read(from: db)
    }) var ingrd

    @State var recipeSteps : String = ""
    @State var nameDish : String = ""
    @State var ingridients : String = ""
    
    var body: some View {
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
                        Text("Ingridients")
                            .bold()
                        HStack{
                            TextField("Add the ingridients and quantities ...", text:$ingridients
                            )
                            .textFieldStyle(.roundedBorder)
                            
                            
                            Button(action: {
                                Task {
                                    try await db!.transaction { core in
                                        try core.query("INSERT INTO ingridients (ingridient) VALUES (?)", ingridients)
                                    }
                                }
                                
                            }, label:{
                                Text("ADD")
                                    .font(.caption)
                            })
                            
                            
                        }
                    }
                    List{
                        ForEach(ingrd.results){
                            currentItem in
                            Label(title: {
                                Text(currentItem.ingridients)
                            }, icon: {
                                Text("-")
                            })
                            
                            
                            
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
INSERT INTO Creator (name, ingridients, steps)VALUES((?),(?),(?)
)
""",
                                           nameDish, ingridients, recipeSteps)
                        }
                        nameDish = ""
                        ingridients = ""
                        recipeSteps = ""
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
        CreatorView()
            .environment(\.blackbirdDatabase, AppDatabase.instance)

    }
}
