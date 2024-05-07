package partyrobot

import (
	"fmt"
	"strings"
)

// Welcome greets a person by name.
func Welcome(name string) string {
	return fmt.Sprintf("Welcome to my party, %s!", name)
}

// HappyBirthday wishes happy birthday to the birthday person and exclaims their age.
func HappyBirthday(name string, age int) string {
	return fmt.Sprintf("Happy birthday %s! You are now %d years old!", name, age)
}

// AssignTable assigns a table to each guest.
func AssignTable(name string, table int, neighbor, direction string, distance float64) string {
	var line1 = Welcome(name)
	var line2 = fmt.Sprintf("You have been assigned to table %03d. Your table is %s, exactly %.1f meters from here.", table, direction, distance)
	var line3 = fmt.Sprint("You will be sitting next to ", neighbor, ".")
	return strings.Join([]string{line1, line2, line3}, "\n")

}


"Welcome to my party, Chihiro!\nYou have been assigned to table 022. Your table is on the straight ahead, exactly 9.2 meters from here.\nYou will be sitting next to Akachi Chikondi."


"Welcome to my party, Chihiro!\nYou have been assigned to table 022. Your table is straight ahead, exactly 9.2 meters from here.\nYou will be sitting next to Akachi Chikondi."
