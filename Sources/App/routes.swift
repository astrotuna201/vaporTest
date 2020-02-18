import Fluent
import Vapor

func routes(_ app: Application) throws {
    let compilationMode : String
    #if DEBUG
       compilationMode = "DEBUG"
    #else
       compilationMode = "RELEASE"
    #endif
    
    let expeditionController = ExpeditionController()
    app.get("expeditions", use: expeditionController.index)
    app.delete("expeditions", ":expeditionID", use: expeditionController.delete)
    app.post("expeditions") { req -> EventLoopFuture<Expedition> in
        let expedition = try req.content.decode(Expedition.self)
        return expedition.create(on: req.db)
            .map { expedition }
    }
    
    app.get("expeditionsEagerTimed") { req -> EventLoopFuture<[Expedition]> in
        let initialTime = Date()
        return Expedition.query(on: req.db)
            .with(\.$coChiefs)
            .with(\.$loggingStaffScientists)
            .with(\.$staffScientists)
            .sort(\.$number, .ascending)
            .all()
            .always({_ in
                let timeTaken = Date().timeIntervalSince(initialTime)
                print ("time taken (\(compilationMode)):\t \(timeTaken)")
            })
    }
    
    
    let personController = PersonController()
    app.get("persons", use: personController.index)
    app.delete("persons", ":personID", use: personController.delete)
    app.post("persons") { req -> EventLoopFuture<Person> in
        let person = try req.content.decode(Person.self)
        return person.create(on: req.db)
            .map { person }
    }
    
    app.get("personsEagerTimed") { req -> EventLoopFuture<[Person]> in
        let initialTime = Date()
        return Person.query(on: req.db)
            .with(\.$expeditionsAsCoChief)
            .with(\.$expeditionsAsStaffScientist)
            .with(\.$expeditionsAsLoggingStaffScientist)
            .all()
            .always({_ in
                let timeTaken = Date().timeIntervalSince(initialTime)
                print ("time taken (\(compilationMode)):\t \(timeTaken)")
            })
    }
    
    
}
