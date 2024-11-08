(define (problem problem9) (:domain robot-chef-plus) ; 3 robots, 2 dishes
(:objects 
    r1 r2 r3 - Robot
    sushi ramen - Dish
    fish seaweed rice1 noodles broth vegetables meat milk eggs - Ingredient
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
    (robot-at r1 ca) (robot-at r2 pa) (robot-at r3 sa)

    (adjacent ca sva) (adjacent sva ca) (adjacent ca dwa) (adjacent dwa ca)
    (adjacent ca pa) (adjacent pa ca) (adjacent pa dwa) (adjacent dwa pa)
    (adjacent pa mixa) (adjacent mixa pa) (adjacent mixa cta) (adjacent cta mixa)
    (adjacent sa cta) (adjacent cta sa) (adjacent mixa sa) (adjacent sa mixa)

    ; -- Tools --
    (item-at knife cta) (item-at gloves mixa) (item-at pot ca)
    (initial-tool-loc knife cta) (initial-tool-loc gloves mixa) (initial-tool-loc pot ca)
    (tool-clean knife) (tool-clean gloves) (tool-clean pot)

    (= (tool-durability knife) 20)
    (= (tool-durability gloves) 20)
    (= (tool-durability pot) 40)

    ; -- Sushi --
    (item-at fish sa) (item-at seaweed sa) (item-at rice1 sa)

    (ingredient-in-dish sushi fish)
    (ingredient-in-dish sushi seaweed)
    (ingredient-in-dish sushi rice1)

    (needs-cutting fish)
    (needs-cutting seaweed)
    (needs-mixing rice1) (needs-cooking rice1)

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