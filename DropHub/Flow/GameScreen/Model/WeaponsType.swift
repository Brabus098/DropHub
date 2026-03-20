//  WeaponsType.swift

// Тип для опредления базывых картинок в рулетке
enum WeaponsType: Int, CaseIterable {
    case AK47 = 0
    case M4A1S = 1
    case USP
    case TEC
    case MAC
    case MP9
    case MP7
    case Agent
    
    var stringVariation: String {
        switch self {
        case .AK47:
            "Ak_47_main"
        case .M4A1S:
            "M4A1S_main"
        case .USP:
            "USP_main"
        case .TEC:
            "TEC_main"
        case .MAC:
            "MAC_main"
        case .MP9:
            "MP9_main"
        case .MP7:
            "MP7_main"
        case .Agent:
            "Agent_main"
        }
    }
}

