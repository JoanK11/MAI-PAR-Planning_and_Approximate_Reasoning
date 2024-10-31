(define (problem problem1) (:domain robot-chef)
(:objects 
    sushi - Dish
    fish seaweed rice - Ingredient
    knife - Cutter
    gloves - Mixer
    pot - Cooker

    ca - CA
    sva - SVA
    dwa - DWA
    pa - PA
    mixa - MIXA
    cta - CTA
    sa - SA
)

(:init
    (robot-at ca)

    (adjacent ca sva) (adjacent sva ca) (adjacent ca dwa) (adjacent dwa ca)
    (adjacent ca pa) (adjacent pa ca) (adjacent pa dwa) (adjacent dwa pa)
    (adjacent pa mixa) (adjacent mixa pa) (adjacent mixa cta) (adjacent cta mixa)
    (adjacent sa cta) (adjacent cta sa) (adjacent mixa sa) (adjacent sa mixa)

    ; -- Tools --
    (item-at knife cta) (item-at gloves mixa) (item-at pot ca)
    (initial-tool-loc knife cta) (initial-tool-loc gloves mixa) (initial-tool-loc pot ca)
    (tool-clean knife) (tool-clean gloves) (tool-clean pot)

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