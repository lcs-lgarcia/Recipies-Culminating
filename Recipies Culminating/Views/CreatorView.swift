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
    @BlackbirdLiveModels({ db in try await IngridientsList.read(from: db)
    }) var todoItems

    @State var nameDish : String = ""
    @State var ingridients : String = ""
    
    var body: some View {
        NavigationView{
            
            VStack{
                HStack{
                    Spacer()
                   
                        TextField("Name of the dish ...", text:$nameDish )
                            
                    
                    Text("     ")
                }
                HStack{
                    Spacer()
                   
                        TextField("Add the ingridients and quantities ...", text:$ingridients
                        )
                            
                   
                    Button(action: {
                        Task {
                            try await db!.transaction { core in
                                try core.query("INSERT INTO Recipes ( ingridients) VALUES (?)", ingridients)
                            }
                        }
                        
                    }, label:{
                        Text("ADD")
                            .font(.caption)
                    })
                    
                    
                }
            
                
            }
                .navigationTitle("Create Your Recipies")
            
        }
    }
}

struct CreatorView_Previews: PreviewProvider {
    static var previews: some View {
        CreatorView()
    }
}
