import Blackbird
import Foundation

struct Creator: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var name: String
    @BlackbirdColumn var ingridients_id: Int
    @BlackbirdColumn var steps: String
    
}




