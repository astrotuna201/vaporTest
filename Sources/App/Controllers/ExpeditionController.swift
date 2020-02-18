//
//  ExpeditionController.swift
//  
//

import Fluent
import Vapor

struct ExpeditionController {
    func index(req: Request) throws -> EventLoopFuture<[Expedition]> {
        return Expedition.query(on: req.db)
            .all()
    }

    func create(req: Request) throws -> EventLoopFuture<Expedition> {
        let expedition = try req.content.decode(Expedition.self)
        return expedition.save(on: req.db).map { expedition }
    }

    func delete(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        return Expedition.find(req.parameters.get("expeditionID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { $0.delete(on: req.db) }
            .transform(to: .ok)
    }
}
