(define (problem problem8) (:domain robot-chef-plus) ; 3 robots, 1 dish
(:objects 
    r1 r2 r3 - Robot
    sushi - Dish
    fish seaweed rice - Ingredient
    knife1 knife2 - Cutter
    gloves - Mixer
    pot1 pot2 - Cooker

    ca - CA
    sva - SVA
    dwa - DWA
    pa - PA
    mixa - MIXA
    cta - CTA
    sa - SA
)

(:init
    (robot-at r1 ca) (robot-at r2 pa) (robot-at r3 sa)

    (adjacent ca sva) (adjacent sva ca) (adjacent ca dwa) (adjacent dwa ca)
    (adjacent ca pa) (adjacent pa ca) (adjacent pa dwa) (adjacent dwa pa)
    (adjacent pa mixa) (adjacent mixa pa) (adjacent mixa cta) (adjacent cta mixa)
    (adjacent sa cta) (adjacent cta sa) (adjacent mixa sa) (adjacent sa mixa)

    ; -- Tools --
    (item-at knife1 cta) (item-at knife2 cta) (item-at gloves mixa) (item-at pot1 ca) (item-at pot2 ca)
    (initial-tool-loc knife1 cta) (initial-tool-loc knife2 cta) (initial-tool-loc gloves mixa) (initial-tool-loc pot1 ca) (initial-tool-loc pot2 ca)
    (tool-clean knife1) (tool-clean knife2) (tool-clean gloves) (tool-clean pot1) (tool-clean pot2)
    
    (= (tool-durability knife1) 2) (= (tool-durability knife2) 2) (= (tool-durability gloves) 3)
    (= (tool-durability pot1) 2) (= (tool-durability pot2) 2)

    ; -- Sushi --
    (item-at fish sa) (item-at seaweed sa) (item-at rice sa)

    (ingredient-in-dish sushi fish)
    (ingredient-in-dish sushi seaweed)
    (ingredient-in-dish sushi rice)

    (needs-cutting fish)
    (needs-cutting seaweed)
    (needs-mixing rice) (needs-cooking rice)
)

(:goal (forall (?d - Dish) (order-processed ?d)))
)