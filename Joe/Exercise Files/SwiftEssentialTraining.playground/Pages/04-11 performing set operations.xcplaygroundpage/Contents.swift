//: [Table of Contents](table%20of%20contents)

//: [Previous](@previous)

//: ## Performing Set Operations

let campAttendees: Set = ["Charlotte", "Laura", "Lilli", "Carlee", "Nathan"]

var students: Set = ["Charlotte", "Laura", "Kayleigh", "Kayla", "Boz", "Jake"]

print(students.intersect(campAttendees))

print(students.exclusiveOr(campAttendees))

print(students.union(campAttendees))

print(students.subtract(campAttendees))

//: [Next](@next)
