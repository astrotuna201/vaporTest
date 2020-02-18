//
//  PersonMigration.swift
//  
//

import Fluent

struct PersonMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Person.schema)
            .field("id", .uuid, .identifier(auto: false))
            .field("first", .string)
            .field("surname", .string)
            .field("full", .string, .required)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Person.schema).delete()
    }
}


