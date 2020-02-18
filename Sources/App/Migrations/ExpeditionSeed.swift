//
//  ExpeditionSeed.swift
//  
//
import Fluent

struct ExpeditionSeed: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        let expeditions = (0..<306).map { number in
            Expedition(area: nil, name: "Expedition#\(number)", number: number, suffix: nil, objective: nil)
        }
        return expeditions.create(on: database).transform(to: ())
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return Expedition.query(on: database).delete()
    }
}
