//
//  HttpModel.swift
//  PinjamCair
//
//  Created by hekang on 2026/2/24.
//

class BaseModel: Codable {
    var ectopurposeess: String?
    var urgth: String?
    var casia: casiaModel?
    
    enum CodingKeys: String, CodingKey {
        case ectopurposeess, urgth, casia
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        urgth = try container.decodeIfPresent(String.self, forKey: .urgth)
        casia = try container.decodeIfPresent(casiaModel.self, forKey: .casia)
        
        if let stringValue = try? container.decode(String.self, forKey: .ectopurposeess) {
            ectopurposeess = stringValue
        } else if let intValue = try? container.decode(Int.self, forKey: .ectopurposeess) {
            ectopurposeess = String(intValue)
        } else {
            ectopurposeess = nil
        }
    }
}

class casiaModel: Codable {
    var sagacain: String?
    var station: String?
    var maliion: String?
    var feliee: String?
    var sorb: sorbModel?
    var dorsally: [dorsallyModel]?
    var dipsiauous: [dipsiauousModel]?
}

class sorbModel: Codable {
    var transress: String?
    var hearability: String?
    var subjectatory: String?
    var narren: String?
}

class dorsallyModel: Codable {
    var rusbadior: String?
    var genlike: String?
    var openarium: String?
}

class dipsiauousModel: Codable {
    var emesive: String?
    var notdropality: [notdropalityModel]?
}

class notdropalityModel: Codable {
    var stochacity: Int?
    var shareian: String?
    var adduous: String?
    var employeesome: String?
    var phrenious: String?
    var autoesque: String?
    var nauo: String?
    var manthamericanible: String?
    var townaire: String?
    var multatule: String?
}
