
struct UserHoldingResponse: Codable {
    let data: UserHoldingDataModel?

    enum CodingKeys: String, CodingKey {
        case data
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try? container.decodeIfPresent(UserHoldingDataModel.self, forKey: .data)
    }
}

struct UserHoldingDataModel: Codable {
    let userHolding: [UserHolding]?

    enum CodingKeys: String, CodingKey {
        case userHolding = "userHolding"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userHolding = try? container.decodeIfPresent([UserHolding].self, forKey: .userHolding)
    }
}

struct UserHolding: Codable {
    let avgPrice: Double?
    let close: Double?
    let ltp: Double?
    let quantity: Int?
    let symbol: String?

    enum CodingKeys: String, CodingKey {
        case avgPrice, close, ltp, quantity, symbol
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        avgPrice = try? container.decodeIfPresent(Double.self, forKey: .avgPrice)
        close = try? container.decodeIfPresent(Double.self, forKey: .close)
        ltp = try? container.decodeIfPresent(Double.self, forKey: .ltp)
        quantity = try? container.decodeIfPresent(Int.self, forKey: .quantity)
        symbol = try? container.decodeIfPresent(String.self, forKey: .symbol)
    }
}



