(define (problem problem1) (:domain robot-chef)
(:objects 
    sushi1 - Dish
    fish1 seaweed1 rice1 - Ingredient
    knife - TCut
    gloves - TMix
    pot - TCook

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

    (item-at fish1 sa) (item-at seaweed1 sa) (item-at rice1 sa)
    (item-at knife cta) (item-at gloves mixa) (item-at pot ca)
    (initial-tool-pos knife cta) (initial-tool-pos gloves pa) (initial-tool-pos pot ca)

    (adjacent ca sva) (adjacent sva ca) (adjacent ca dwa) (adjacent dwa ca)
    (adjacent ca pa) (adjacent pa ca) (adjacent pa dwa) (adjacent dwa pa)
    (adjacent pa mixa) (adjacent mixa pa) (adjacent mixa cta) (adjacent cta mixa)
    (adjacent sa cta) (adjacent cta sa) (adjacent mixa sa) (adjacent sa mixa); ???? (adjacent sa sva) (adjacent sva sa)

    (tool-clean knife) (tool-clean gloves) (tool-clean pot)

    (ingredient-in-dish sushi1 fish1)
    (ingredient-in-dish sushi1 seaweed1)
    (ingredient-in-dish sushi1 rice1)

    (needs-cutting fish1)
    (needs-cutting seaweed1)
    (needs-mixing rice1)
    (needs-cooking rice1)
)

(:goal (forall (?d - Dish) (order-processed ?d)))

;(:metric minimize (???))
)