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
}

class casiaModel: Codable {
    var sagacain: String?
    var sorb: sorbModel?
}

class sorbModel: Codable {
    var transress: String?
    var hearability: String?
    var subjectatory: String?
    var narren: String?
}
