//
//  Expedition.swift
//  
//

import Fluent
import Vapor

final class Expedition: Model, Content {
    static let schema = "expeditions"
    
    @ID(key: "id", generatedBy: .random)
    var id: UUID?

    @Field(key: "area")
    var area: String?

    @Field(key: "name")
    var name: String

    @Field(key: "number")
    var number: Int

    @Field(key: "suffix")
    var suffix: String?

    @Field(key: "objective")
    var objective: String?

    @Siblings(through: ExpeditionCoChief.self, from: \.$expedition, to: \.$person)
    var coChiefs: [Person]
    
    @Siblings(through: ExpeditionLoggingStaffScientist.self, from: \.$expedition, to: \.$person)
    var loggingStaffScientists: [Person]
  
    @Siblings(through: ExpeditionStaffScientist.self, from: \.$expedition, to: \.$person)
    var staffScientists: [Person]

    init() { }

    init(id: UUID? = nil, area: String?, name: String, number: Int, suffix: String?, objective: String?) {
        self.id = id
        self.area = area
        self.name = name
        self.number = number
        self.suffix = suffix
        self.objective = objective
    }
}
