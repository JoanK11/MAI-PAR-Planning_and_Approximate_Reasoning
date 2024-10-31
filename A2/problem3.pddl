(define (problem problem3) (:domain robot-chef)
(:objects 
    sushi ramen curry_rice - Dish
    fish seaweed rice1 rice2 chicken curry noodles broth vegetables meat milk eggs - Ingredient
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
    (robot-at ca)

    (adjacent ca sva) (adjacent sva ca) (adjacent ca dwa) (adjacent dwa ca)
    (adjacent ca pa) (adjacent pa ca) (adjacent pa dwa) (adjacent dwa pa)
    (adjacent pa mixa) (adjacent mixa pa) (adjacent mixa cta) (adjacent cta mixa)
    (adjacent sa cta) (adjacent cta sa) (adjacent mixa sa) (adjacent sa mixa)

    ; -- Tools --
    (item-at knife1 cta) (item-at knife2 cta) (item-at gloves mixa) (item-at pot1 ca) (item-at pot2 ca)
    (initial-tool-loc knife1 cta) (initial-tool-loc knife2 cta) (initial-tool-loc gloves mixa) (initial-tool-loc pot1 ca) (initial-tool-loc pot2 ca)
    (tool-clean knife1) (tool-clean knife2) (tool-clean gloves) (tool-clean pot1) (tool-clean pot2)

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