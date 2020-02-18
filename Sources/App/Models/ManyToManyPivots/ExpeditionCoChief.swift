//
//  ExpeditionCoChief.swift
//  
//

import Fluent
import Vapor

final class ExpeditionCoChief: Model {
    static let schema = "expedition+personCoChiefs"
    
    @ID(key: "id", generatedBy: .random)
    var id: UUID?

    @Parent(key: "expedition_id")
    var expedition: Expedition
    
    @Parent(key: "person_id")
    var person: Person

    init() { }

    init(expeditionID: UUID, personID: UUID) {
        self.$expedition.id = expeditionID
        self.$person.id = personID
    }
}

struct ExpeditionCoChiefMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ExpeditionCoChief.schema)
            .field("id", .uuid, .identifier(auto: false))
            .field("expedition_id", .uuid, .required)
            .field("person_id", .uuid, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ExpeditionCoChief.schema).delete()
    }
}

