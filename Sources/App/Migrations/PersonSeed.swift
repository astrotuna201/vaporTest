//
//  PersonSeed.swift
//
//
import Fluent

struct PersonSeed: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let persons = (0..<570).map { number in
            Person(first: "A", surname: "Person#\(number)", full: "A Person#\(number)")
        }
        return persons.create(on: database).transform(to: ())
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return Person.query(on: database).delete()
    }
}
