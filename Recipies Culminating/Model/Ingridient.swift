import Blackbird
import Foundation

struct Ingridient: BlackbirdModel{
    @BlackbirdColumn var id: Int
    @BlackbirdColumn var ingridients: String
}

