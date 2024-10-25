(define (problem problem5) ; 5x5 Unsat Example
(:domain rescue-drone)

(:objects 
    d1 d2 d3 d4 d5 d6 d7 d8 d9 d10 d11 d12 d13 d14 - Location
    d15 d16 d17 d18 d19 d20 d21 d22 d23 d24 d25 - Location
    p1 - Person
)

(:init
    (= (safe-zone-capacity) 0)
    (= (max-safe-zone-capacity) 1)

    (adjacent d1 d2) (adjacent d1 d6)
    (adjacent d2 d1) (adjacent d2 d3) (adjacent d2 d7)
    (adjacent d3 d2) (adjacent d3 d4) (adjacent d3 d8)
    (adjacent d4 d3) (adjacent d4 d5) (adjacent d4 d9)
    (adjacent d5 d4) (adjacent d5 d10)
    (adjacent d6 d1) (adjacent d6 d7) (adjacent d6 d11)
    (adjacent d7 d2) (adjacent d7 d6) (adjacent d7 d8) (adjacent d7 d12)
    (adjacent d8 d3) (adjacent d8 d7) (adjacent d8 d9) (adjacent d8 d13)
    (adjacent d9 d4) (adjacent d9 d8) (adjacent d9 d10) (adjacent d9 d14)
    (adjacent d10 d5) (adjacent d10 d9) (adjacent d10 d15)  
    (adjacent d11 d6) (adjacent d11 d12) (adjacent d11 d16)  
    (adjacent d12 d7) (adjacent d12 d11) (adjacent d12 d13) (adjacent d12 d17)
    (adjacent d13 d8) (adjacent d13 d12) (adjacent d13 d14) (adjacent d13 d18)
    (adjacent d14 d9) (adjacent d14 d13) (adjacent d14 d15) (adjacent d14 d19)
    (adjacent d15 d10) (adjacent d15 d14) (adjacent d15 d20)
    (adjacent d16 d11) (adjacent d16 d17) (adjacent d16 d21)
    (adjacent d17 d12) (adjacent d17 d16) (adjacent d17 d18) (adjacent d17 d22)
    (adjacent d18 d13) (adjacent d18 d17) (adjacent d18 d19) (adjacent d18 d23)
    (adjacent d19 d14) (adjacent d19 d18) (adjacent d19 d20) (adjacent d19 d24)
    (adjacent d20 d15) (adjacent d20 d19) (adjacent d20 d25)
    (adjacent d21 d16) (adjacent d21 d22)
    (adjacent d22 d17) (adjacent d22 d21) (adjacent d22 d23)
    (adjacent d23 d18) (adjacent d23 d22) (adjacent d23 d24)
    (adjacent d24 d19) (adjacent d24 d23) (adjacent d24 d25)
    (adjacent d25 d20) (adjacent d25 d24)

    (drone-location d11)

    (person-location p1 d13)

    (obstacle d8)  (obstacle d12)
    (obstacle d14) (obstacle d18)

    (safe-zone d15)
)

(:goal (forall (?p - Person) (rescued ?p)))
)