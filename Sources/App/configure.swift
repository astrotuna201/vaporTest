import Fluent
import FluentPostgresDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //app.logger.logLevel = .trace

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        port: Int(Environment.get("DATABASE_PORT") ?? "15432") ?? 5432,
        username: Environment.get("DATABASE_USERNAME") ?? "vaporTestOwner",
        password: Environment.get("DATABASE_PASSWORD") ?? "XXXXXXXXXXXX",
        database: Environment.get("DATABASE_NAME") ?? "vaporTestStore",
        tlsConfiguration: nil,
        maxConnectionsPerEventLoop: 1
    ), as: .psql)

    app.migrations.add(PersonMigration())
    app.migrations.add(ExpeditionMigration())
    app.migrations.add(ExpeditionCoChiefMigration())
    app.migrations.add(ExpeditionLoggingStaffScientistMigration())
    app.migrations.add(ExpeditionStaffScientistMigration())
    
    app.migrations.add(PersonSeed())
    app.migrations.add(ExpeditionSeed())
    app.migrations.add(PivotSeeds())

    // register routes
    try routes(app)
}
