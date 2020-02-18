//
//  ExpeditionMigration.swift
//  
//
import Fluent

struct ExpeditionMigration: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Expedition.schema)
            .field("id", .uuid, .identifier(auto: false))
            .field("area", .string)
            .field("name", .string, .required)
            .field("number", .int, .required)
            .field("suffix", .string)
            .field("objective", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Expedition.schema).delete()
    }
}

