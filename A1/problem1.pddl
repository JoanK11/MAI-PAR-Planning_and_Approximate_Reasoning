(define (problem problem1)
(:domain rescue-drone)

(:objects 
    d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 d15 d16 - Location
    p1 p2 p3 - Person
)

(:init
    (= (safe-zone-capacity) 0)
    (= (max-safe-zone-capacity) 3)

    ; Row 1: d1 to d4
    (adjacent d1 d2) (adjacent d1 d5)
    (adjacent d2 d1) (adjacent d2 d3) (adjacent d2 d6)
    (adjacent d3 d2) (adjacent d3 d4) (adjacent d3 d7)
    (adjacent d4 d3) (adjacent d4 d8)

    ; Row 2: d5 to d8
    (adjacent d5 d1) (adjacent d5 d6) (adjacent d5 d9)
    (adjacent d6 d2) (adjacent d6 d5) (adjacent d6 d7) (adjacent d6 d10)
    (adjacent d7 d3) (adjacent d7 d6) (adjacent d7 d8) (adjacent d7 d11)
    (adjacent d8 d4) (adjacent d8 d7) (adjacent d8 d12)

    ; Row 3: d9 to d12
    (adjacent d9 d5) (adjacent d9 d10) (adjacent d9 d13)
    (adjacent d10 d6) (adjacent d10 d9) (adjacent d10 d11) (adjacent d10 d14)
    (adjacent d11 d7) (adjacent d11 d10) (adjacent d11 d12) (adjacent d11 d15)
    (adjacent d12 d8) (adjacent d12 d11) (adjacent d12 d16)

    ; Row 4: d13 to d16
    (adjacent d13 d9) (adjacent d13 d14)
    (adjacent d14 d10) (adjacent d14 d13) (adjacent d14 d15)
    (adjacent d15 d11) (adjacent d15 d14) (adjacent d15 d16)
    (adjacent d16 d12) (adjacent d16 d15)

    (drone-location d1)

    (person-location p1 d4)
    (person-location p2 d5)
    (person-location p3 d10)

    (obstacle d7) (obstacle d11) (obstacle d16)

    (safe-zone d14)
)

(:goal (forall (?p - Person) (rescued ?p)))
)