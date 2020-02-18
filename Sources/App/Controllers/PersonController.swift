//
//  PersonController.swift
//  
//

import Fluent
import Vapor

struct PersonController {
    func index(req: Request) throws -> EventLoopFuture<[Person]> {
        return Person.query(on: req.db)
            .sort(\.$surname, .ascending)
            .all()
    }

    func create(req: Request) throws -> EventLoopFuture<Person> {
        let person = try req.content.decode(Person.self)
        return person.save(on: req.db).map { person }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Person.find(req.parameters.get("personID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
