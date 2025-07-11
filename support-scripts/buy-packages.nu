#!/usr/bin/env nu
def polstrength [wealth] { 
    if $wealth <= 10 {
        $wealth * 0.03
    } else if $wealth <= 25 {
        ($wealth - 10) ** 1 * 0.48 + 0.3
    } else if $wealth <= 45 {
        ($wealth - 15) ** 2 + 8
    } else { 
        ($wealth - 45) ** 3 * 2 + 70
    }
    | math floor
}

def popneed_basic_food [wealth] {
    if $wealth > 0 and $wealth <= 18 {
        5 * $wealth + 90
    } else if $wealth > 18 and $wealth <= 25 {
        180
    } else if $wealth > 24 and $wealth <= 29 {
        -5 * $wealth + 305
    } else {
        0
    }
    | math round
}

def popneed_crude_items [wealth] {
    if $wealth > 4 and $wealth <= 14 {
        -1.5 * (($wealth - 9) ** 2) + 50
    } else {
        0
    }
    | math round
}

def popneed_simple_clothing [wealth] {
    if ($wealth > 0 and $wealth <= 14) {
        -0.33 * (($wealth - 8) ** 2) + 50
    } else {
        0
    }
    | math round
}

def popneed_heating [wealth] {
    if ($wealth > 0 and $wealth < 9) {
        $wealth + 17
    } else if ($wealth >= 9) {
        26
    } else {
        0
    }
    | math round
}

def popneed_household_items [wealth] {
    if ($wealth > 10 and $wealth < 30) {
        12 * $wealth - 113
    } else if ($wealth >= 30 and $wealth < 45) {
        247
    } else {
        0
    }
    | math round
}

def popneed_standard_clothing [wealth] {
    if ($wealth > 10 and $wealth < 24) {
        12 * $wealth - 113
    } else if ($wealth >= 24 and $wealth < 39) {
        175
    } else {
        0
    }
    | math round
}

def popneed_services [wealth] {
    if ($wealth >= 10) {
        (1.158 ** $wealth) + 20
    } else {
        0
    }
    | math round
}

def popneed_intoxicants [wealth] {
    if ($wealth > 0 and $wealth < 30) {
        7 * $wealth
    } else if ($wealth >= 30) {
        210
    } else {
        0
    }
    | math round
}

def popneed_luxury_drinks [wealth] {
    if ($wealth >= 15) {
        (1.145 ** $wealth) + 20
    } else {
        0
    }
    | math round
}

def popneed_free_movement [wealth] {
    if ($wealth >= 10) {
        1.145 ** $wealth
    } else {
        0
    }
    | math round
}

def popneed_communication [wealth] {
    if ($wealth >= 20) {
        (1.145 ** $wealth) + 20
    } else {
        0
    }
    | math round
}

def popneed_luxury_food [wealth] {
    if ($wealth >= 20) {
        (1.145 ** $wealth) + 20
    } else {
        0
    }
    | math round
}

def popneed_luxury_items [wealth] {
    if ($wealth >= 15) {
        (1.165 ** $wealth) + 20
    } else {
        0
    }
    | math round
}

def popneed_leisure [wealth] {
    if ($wealth >= 20) {
        (1.165 ** $wealth) + 20
    } else {
        0
    }
    | math round
}

def goods [wealth] {
    {
        popneed_basic_food: (popneed_basic_food $wealth)
        popneed_crude_items: (popneed_crude_items $wealth)
        popneed_simple_clothing: (popneed_simple_clothing $wealth)
        popneed_heating: (popneed_heating $wealth)
        popneed_household_items: (popneed_household_items $wealth)
        popneed_standard_clothing: (popneed_standard_clothing $wealth)
        popneed_services: (popneed_services $wealth)
        popneed_intoxicants: (popneed_intoxicants $wealth)
        popneed_luxury_drinks: (popneed_luxury_drinks $wealth)
        popneed_free_movement: (popneed_free_movement $wealth)
        popneed_communication: (popneed_communication $wealth)
        popneed_luxury_food: (popneed_luxury_food $wealth)
        popneed_luxury_items: (popneed_luxury_items $wealth)
        popneed_leisure: (popneed_leisure $wealth)
    }
}

def 'to pdxscript' []: record -> string {
  to json -t 1 
| str replace -a "\"" "" 
| str replace -a "," "" 
| str replace -a ":" " =" 
| str substring 2..-2 
| lines 
| each {|| str substring 1..} 
| str join "\n"
}

1..99 | reduce --fold {} {|i| insert $"wealth_($i)" {political_strength: (polstrength $i), goods: (goods $i)}} | to pdxscript 
| save -f "../better-economy-mod/common/buy_packages/00_buy_packages.txt"
