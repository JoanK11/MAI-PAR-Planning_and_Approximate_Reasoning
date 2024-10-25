(define (domain rescue-drone)

(:requirements :strips :typing :fluents :adl)

(:types Location Person - object)

(:predicates
    (drone-location ?d - Location) ; The drone is at location d
    (person-location ?p - Person ?d - Location) ; Person is stranded at location d
    (obstacle ?d - Location) ; Location d contains an obstacle
    (safe-zone ?d - Location) ; Location d is the designated safe zone
    (adjacent ?d1 - Location ?d2 - Location) ; Locations d1 and d2 are adjacent
    (rescued ?p - Person) ; The person has been rescued (i.e., is in the safe zone)
    (carrying ?p - Person) ; The person is currently being carried by the drone
    (is-carrying-person) ; The drone is currently carrying someone
)

(:functions
    (safe-zone-capacity) ; Current capacity of people in the safe zone
    (max-safe-zone-capacity) ; Constant maximum capacity of the safe zone
)

(:action move ; Moves the drone from location d1 to adjacent location d2
    :parameters (?d1 - Location ?d2 - Location)
    :precondition (and (drone-location ?d1) (adjacent ?d1 ?d2) (not (obstacle ?d2)))
    :effect (and (not (drone-location ?d1)) (drone-location ?d2))
)

(:action pick-up ; Picks up person p from location d
    :parameters (?p - Person ?d - Location)
    :precondition (and (drone-location ?d) (person-location ?p ?d) (not (is-carrying-person)))
    :effect (and (not (person-location ?p ?d)) (carrying ?p) (is-carrying-person))
)

(:action drop-off ; Drops-off person p at the safe zone d
    :parameters (?p - Person ?d - Location)
    :precondition (and (drone-location ?d) (safe-zone ?d) (carrying ?p) (< (safe-zone-capacity) (max-safe-zone-capacity)))
    :effect (and (rescued ?p) (not (carrying ?p)) (not (is-carrying-person)) (increase (safe-zone-capacity) 1))
)

(:action clean-safe-zone ; Empties the safe zone
    :parameters (?d - Location)
    :precondition (and (drone-location ?d) (safe-zone ?d))
    :effect (and (assign (safe-zone-capacity) 0))
)
)