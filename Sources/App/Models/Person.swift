//
//  Person.swift
//  
//

import Fluent
import Vapor

final class Person: Model, Content {
    static let schema = "persons"
    
    @ID(key: "id", generatedBy: .random)
    var id: UUID?

    @Field(key: "first")
    var first: String?
    
    @Field(key: "surname")
    var surname: String?
    
    @Field(key: "full")
    var full: String

    @Siblings(through: ExpeditionCoChief.self, from: \.$person, to: \.$expedition)
    var expeditionsAsCoChief: [Expedition]
    
    @Siblings(through: ExpeditionLoggingStaffScientist.self, from: \.$person, to: \.$expedition)
    var expeditionsAsLoggingStaffScientist: [Expedition]
   
    @Siblings(through: ExpeditionStaffScientist.self, from: \.$person, to: \.$expedition)
    var expeditionsAsStaffScientist: [Expedition]
    
    init() { }

    init(id: UUID? = nil, first: String?, surname: String?, full: String) {
        self.id = id
        self.first = first
        self.surname = surname
        self.full = full
    }
}
