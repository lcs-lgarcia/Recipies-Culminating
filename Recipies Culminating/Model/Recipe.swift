import Blackbird
import Foundation

struct Recipe: BlackbirdModel{
    @BlackbirdColumn var  id  : Int
    @BlackbirdColumn var name: String
    @BlackbirdColumn var steps: String
    
}




