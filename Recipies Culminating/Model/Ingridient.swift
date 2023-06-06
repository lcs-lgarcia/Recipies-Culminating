import Blackbird
import Foundation

struct ingridient: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var ingridients: String
}

