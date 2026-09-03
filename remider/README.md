# Simple server — muhsin/todo

A minimal Spring Boot 3 application (Java 17) with one GET endpoint.

Build & run
- Build: mvn -q package
- Run: mvn -q spring-boot:run
- Or: java -jar target/todo-0.0.1-SNAPSHOT.jar

Endpoint
- GET /health -> 200 OK, JSON: {"status":"success"}

Notes
- Java 17 is required.
- Uses Spring Boot 3.x.