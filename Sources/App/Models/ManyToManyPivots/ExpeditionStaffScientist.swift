//
//  ExpeditionStaffScientist.swift
//  
//

import Fluent
import Vapor

final class ExpeditionStaffScientist: Model {
    static let schema = "expedition+personStaffScientist"
    
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

struct ExpeditionStaffScientistMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ExpeditionStaffScientist.schema)
            .field("id", .uuid, .identifier(auto: false))
            .field("expedition_id", .uuid, .required)
            .field("person_id", .uuid, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(ExpeditionStaffScientist.schema).delete()
    }
}
