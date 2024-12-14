(define (domain robot-chef)

(:requirements :typing :strips :fluents :adl)

(:types
    Location Item - Object
    Ingredient Tool Dish - Item
    Cutter Mixer Cooker - Tool
    CA SVA DWA PA MIXA CTA SA - Location
)

(:predicates
    ;; Robot Status
    (robot-at ?l - Location) ; Robot is at location ?l
    (holding ?i - Item) ; Robot is holding item ?i
    (holding-any) ; Robot is holding something

    ;; Item Locations
    (item-at ?i - Item ?l - Location) ; Item ?i is at location ?l

    ;; Tool Status & Locations
    (tool-clean ?t - Tool) ; Tool ?t is clean
    (initial-tool-loc ?t - Tool ?l - Location) ; Initial location of tool ?t is ?l

    ;; Order Status
    (processing-order ?d - Dish) ; Order for dish ?d is being processed
    (processing-any-order) ; Any order is being processed
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
    :parameters (?from - Location ?to - Location)
    :precondition (and (robot-at ?from) (adjacent ?from ?to))
    :effect (and (not (robot-at ?from)) (robot-at ?to))
)

(:action pick-up-item
    :parameters (?i - Item ?l - Location)
    :precondition (and (robot-at ?l) (item-at ?i ?l) (not (holding-any)))
    :effect (and (not (item-at ?i ?l)) (holding ?i) (holding-any))
)

(:action drop-item
    :parameters (?i - Item ?l - Location)
    :precondition (and (robot-at ?l) (holding ?i))
    :effect (and (item-at ?i ?l) (not (holding ?i)) (not (holding-any)))
)

(:action clean-tool
    :parameters (?t - Tool ?l - DWA)
    :precondition (and (robot-at ?l) (item-at ?t ?l))
    :effect (tool-clean ?t)
)

(:action cut-ingredient
    :parameters (?i - Ingredient ?t - Cutter ?d - Dish ?l - CTA)
    :precondition (and (robot-at ?l) (holding ?t) (item-at ?i ?l) (needs-cutting ?i) (processing-order ?d) (ingredient-in-dish ?d ?i))
    :effect (and (ingredient-cut ?i) (not (needs-cutting ?i)) (not (tool-clean ?t)))
)

(:action mix-ingredient
    :parameters (?i - Ingredient ?t - Mixer ?d - Dish ?l - MIXA)
    :precondition (and (robot-at ?l) (holding ?t) (item-at ?i ?l) (needs-mixing ?i) (processing-order ?d) (ingredient-in-dish ?d ?i))
    :effect (and (ingredient-mixed ?i) (not (needs-mixing ?i)) (not (tool-clean ?t)))
)

(:action cook-ingredient
    :parameters (?i - Ingredient ?t - Cooker ?d - Dish ?l - CA)
    :precondition (and (robot-at ?l) (not (holding-any)) (item-at ?i ?l) (item-at ?t ?l) (needs-cooking ?i) (processing-order ?d) (ingredient-in-dish ?d ?i))
    :effect (and (ingredient-cooked ?i) (not (needs-cooking ?i)) (not (tool-clean ?t)))
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
    :parameters (?d - Dish ?l - PA)
    :precondition (and (robot-at ?l) (not (holding-any))
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
    :parameters (?d - Dish ?l - SVA)
    :precondition (and (robot-at ?l) (holding ?d) (dish-prepared ?d))
    :effect (and (dish-served ?d) (not (holding ?d)) (not (holding-any)))
)

(:action start-order
    :parameters (?d - Dish)
    :precondition (and (not (processing-any-order)))
    :effect (and (processing-any-order) (processing-order ?d))
)

(:action end-order
    :parameters (?d - Dish)
    :precondition (and (processing-order ?d) (dish-served ?d)
        (forall (?t - Tool)
            (and (tool-clean ?t)
                (exists (?l - Location)
                    (and (initial-tool-loc ?t ?l) (item-at ?t ?l))
                )
            )
        )
    )
    :effect (and (not (processing-order ?d)) (not (processing-any-order)) (order-processed ?d))
)
)