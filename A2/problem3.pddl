(define (problem problem3) (:domain robot-chef)
(:objects 
    sushi ramen curry_rice - Dish
    fish seaweed rice1 rice2 chicken curry noodles broth vegetables meat milk eggs - Ingredient
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

    ; -- Curry Rice --
    (item-at chicken sa) (item-at rice2 sa) (item-at curry sa)

    (ingredient-in-dish curry_rice chicken)
    (ingredient-in-dish curry_rice rice2)
    (ingredient-in-dish curry_rice curry)

    (needs-cutting chicken) (needs-cooking chicken)
    (needs-mixing rice2) (needs-cooking rice2)
    (needs-cooking curry)

    ; -- Other Ingredients --
    (item-at meat sa) (item-at milk sa) (item-at eggs sa)
)

(:goal (forall (?d - Dish) (order-processed ?d)))
)