(define (problem problem2) (:domain robot-chef)
(:objects 
    sushi ramen - Dish
    fish seaweed rice noodles broth vegetables meat milk eggs - Ingredient
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

    ; -- Ramen --
    (item-at noodles sa) (item-at broth sa) (item-at vegetables sa)

    (ingredient-in-dish ramen noodles)
    (ingredient-in-dish ramen broth)
    (ingredient-in-dish ramen vegetables)

    (needs-cooking noodles)
    (needs-cooking broth)
    (needs-cutting vegetables)

    ; -- Other Ingredients --
    (item-at meat sa) (item-at milk sa) (item-at eggs sa)
)

(:goal (forall (?d - Dish) (order-processed ?d)))
)