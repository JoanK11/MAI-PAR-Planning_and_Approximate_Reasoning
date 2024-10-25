(define (problem problem4) ; 3x3 Example
(:domain rescue-drone)

(:objects 
    d1 d2 d3 d4 d5 d6 d7 d8 d9 - Location
    p1 p2 p3 p4 p5 - Person
)

(:init
    (= (safe-zone-capacity) 0)
    (= (max-safe-zone-capacity) 2)

    (adjacent d1 d2) (adjacent d1 d4)
    (adjacent d2 d1) (adjacent d2 d3) (adjacent d2 d5)
    (adjacent d3 d2) (adjacent d3 d6)
    (adjacent d4 d1) (adjacent d4 d5) (adjacent d4 d7)
    (adjacent d5 d2) (adjacent d5 d4) (adjacent d5 d6) (adjacent d5 d8)
    (adjacent d6 d3) (adjacent d6 d5) (adjacent d6 d9)
    (adjacent d7 d4) (adjacent d7 d8)
    (adjacent d8 d5) (adjacent d8 d7) (adjacent d8 d9)
    (adjacent d9 d6) (adjacent d9 d8)

    (drone-location d1)

    (person-location p1 d2) (person-location p2 d3)
    (person-location p3 d6) (person-location p4 d9)
    (person-location p5 d8)

    (obstacle d4) (obstacle d5)

    (safe-zone d7)
)

(:goal (forall (?p - Person) (rescued ?p)))
)