//
//  PivotSeed.swift
//
//

import Fluent

struct PivotSeeds: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return Person.query(on: database)
            .all()
            .and(Expedition.query(on: database).all())
            .flatMap({ (results) -> (EventLoopFuture<Void>) in
                          let (persons, expeditions) = results
            var futures = [EventLoopFuture<Void>]()
            for e in expeditions {
                var personGroup = [String: Person]()
                repeat {
                    if let randomPerson = persons.randomElement() {
                        personGroup[randomPerson.full] = randomPerson
                    }
                } while personGroup.count < 4
                
                let selected : [Person] = personGroup.values.compactMap({$0})
                futures.append(e.$coChiefs.attach([selected[0], selected[1]], on: database))
                futures.append(e.$staffScientists.attach(selected[2], on: database))
                futures.append(e.$loggingStaffScientists.attach(selected[3], on: database))
            }
            return database.eventLoop.flatten(futures).transform(to: ())
        })
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return Expedition.query(on: database).first().transform(to: ())
    }
}
