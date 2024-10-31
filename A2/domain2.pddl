(define (domain robot-chef-plus)

(:requirements :typing :strips :fluents :adl)

(:types
    Location Item Robot - Object
    Ingredient Tool Dish - Item
    Cutter Mixer Cooker - Tool
    CA SVA DWA PA MIXA CTA SA - Location
)

(:functions
    (tool-durability ?t - Tool) ; Number of uses remaining for tool ?t
)

(:predicates
    ;; Robot Status
    (robot-at ?r - Robot ?l - Location) ; Robot ?r is at location ?l
    (holding ?r - Robot ?i - Item) ; Robot ?r is holding item ?i
    (holding-any ?r - Robot) ; Robot ?r is holding something

    ;; Item Locations
    (item-at ?i - Item ?l - Location) ; Item ?i is at location ?l

    ;; Tool Status & Locations
    (tool-clean ?t - Tool) ; Tool ?t is clean
    (initial-tool-loc ?t - Tool ?l - Location) ; Initial location of tool ?t is ?l
    (tool-discarded ?t - Tool) ; Tool ?t has been discarded
    (tool-used-by ?t - Tool ?d - Dish) ; Tool ?t has been used by dish ?d

    ;; Order Status
    (processing-order ?d - Dish) ; Order for dish ?d is being processed
    (order-processed ?d - Dish) ; Order for dish ?d has been processed
    
    ;; Dish Status & Requirements
    (dish-prepared ?d - Dish) ; Dish ?d is prepared (ready to be served)
    (dish-served ?d - Dish) ; Dish ?d is served
    (ingredient-in-dish ?d - Dish ?i - Ingredient) ; Ingredient ?i is part of dish ?d

    ;; Adjacent Locations
    (adjacent ?l1 - Location ?l2 - Location) ; Locations ?l1 and ?l2 are adjacent
    
    ;; Ingredient States
    (ingredient-cut ?i - Ingredient)    ; Ingredient ?i is cut
    (ingredient-mixed ?i - Ingredient)  ; Ingredient ?i is mixed
    (ingredient-cooked ?i - Ingredient) ; Ingredient ?i is cooked
    (ingredient-ready ?i - Ingredient)  ; Ingredient ?i is ready

    ;; Ingredient Needs
    (needs-cutting ?i - Ingredient) ; Ingredient ?i needs cutting
    (needs-mixing ?i - Ingredient)  ; Ingredient ?i needs mixing
    (needs-cooking ?i - Ingredient) ; Ingredient ?i needs cooking
)

(:action move
    :parameters (?r - Robot ?from - Location ?to - Location)
    :precondition (and (robot-at ?r ?from) (adjacent ?from ?to))
    :effect (and (not (robot-at ?r ?from)) (robot-at ?r ?to))
)

(:action pick-up-item
    :parameters (?r - Robot ?i - Item ?l - Location)
    :precondition (and (robot-at ?r ?l) (item-at ?i ?l) (not (holding-any ?r)))
    :effect (and (not (item-at ?i ?l)) (holding ?r ?i) (holding-any ?r))
)

(:action drop-item
    :parameters (?r - Robot ?i - Item ?l - Location)
    :precondition (and (robot-at ?r ?l) (holding ?r ?i))
    :effect (and (item-at ?i ?l) (not (holding ?r ?i)) (not (holding-any ?r)))
)

(:action clean-tool
    :parameters (?r - Robot ?t - Tool ?l - DWA)
    :precondition (and (robot-at ?r ?l) (item-at ?t ?l))
    :effect (and (tool-clean ?t) (forall (?d - Dish) (not (tool-used-by ?t ?d))))
)

(:action cut-ingredient
    :parameters (?r - Robot ?i - Ingredient ?t - Cutter ?d - Dish ?l - CTA)
    :precondition (and (robot-at ?r ?l) (holding ?r ?t) (item-at ?i ?l) (needs-cutting ?i) (> (tool-durability ?t) 0) (ingredient-in-dish ?d ?i) (or (tool-clean ?t) (tool-used-by ?t ?d)))
    :effect (and (ingredient-cut ?i) (not (needs-cutting ?i)) (not (tool-clean ?t)) (tool-used-by ?t ?d) (decrease (tool-durability ?t) 1))
)

(:action mix-ingredient
    :parameters (?r - Robot ?i - Ingredient ?t - Mixer ?d - Dish ?l - MIXA)
    :precondition (and (robot-at ?r ?l) (holding ?r ?t) (item-at ?i ?l) (needs-mixing ?i) (> (tool-durability ?t) 0) (ingredient-in-dish ?d ?i) (or (tool-clean ?t) (tool-used-by ?t ?d)))
    :effect (and (ingredient-mixed ?i) (not (needs-mixing ?i)) (not (tool-clean ?t)) (tool-used-by ?t ?d) (decrease (tool-durability ?t) 1))
)

(:action cook-ingredient
    :parameters (?r - Robot ?i - Ingredient ?t - Cooker ?d - Dish ?l - CA)
    :precondition (and (robot-at ?r ?l) (not (holding-any ?r)) (item-at ?i ?l) (item-at ?t ?l) (needs-cooking ?i) (> (tool-durability ?t) 0) (ingredient-in-dish ?d ?i) (or (tool-clean ?t) (tool-used-by ?t ?d)))
    :effect (and (ingredient-cooked ?i) (not (needs-cooking ?i)) (not (tool-clean ?t)) (tool-used-by ?t ?d) (decrease (tool-durability ?t) 1))
)

(:action check-prepared
    :parameters (?i - Ingredient ?d - Dish)
    :precondition (and (ingredient-in-dish ?d ?i)
        (or (not (needs-cutting ?i)) (ingredient-cut ?i))
        (or (not (needs-mixing ?i)) (ingredient-mixed ?i))
        (or (not (needs-cooking ?i)) (ingredient-cooked ?i))
    )
    :effect (ingredient-ready ?i)
)

(:action assemble-dish
    :parameters (?r - Robot ?d - Dish ?l - PA)
    :precondition (and (robot-at ?r ?l) (not (holding-any ?r))
                    (forall (?i - Ingredient)
                        (imply
                            (ingredient-in-dish ?d ?i)
                            (and (ingredient-ready ?i) (item-at ?i ?l))
                        )
                    )
    )
    :effect (and (dish-prepared ?d) (item-at ?d ?l)
            (forall (?i - Ingredient)
                (when
                    (ingredient-in-dish ?d ?i)
                    (not (item-at ?i ?l))
                )
            )
    )
)

(:action serve-dish
    :parameters (?r - Robot ?d - Dish ?l - SVA)
    :precondition (and (robot-at ?r ?l) (holding ?r ?d) (dish-prepared ?d))
    :effect (and (dish-served ?d) (not (holding ?r ?d)) (not (holding-any ?r)))
)

(:action start-order
    :parameters (?d - Dish)
    :effect (processing-order ?d)
)

(:action end-order
    :parameters (?d - Dish)
    :precondition (and (processing-order ?d) (dish-served ?d)
        (forall (?t - Tool)
            (or (tool-discarded ?t)
                (and (tool-clean ?t)
                    (exists (?l - Location)
                        (and (initial-tool-loc ?t ?l) (item-at ?t ?l))
                    )
                )
            )
        )
    )
    :effect (and (not (processing-order ?d)) (order-processed ?d))
)

(:action throw-tool
    :parameters (?r - Robot ?t - Tool)
    :precondition (and (holding ?r ?t) (= (tool-durability ?t) 0))
    :effect (and (not (holding ?r ?t)) (not (holding-any ?r)) (tool-discarded ?t))
)
)