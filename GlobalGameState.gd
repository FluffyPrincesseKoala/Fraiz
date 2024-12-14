extends Node

@export var trap_inventory = {};

func removeTrap(name: String) -> bool:
	assert(trap_inventory.find_key(name), "Trap does not exists")
	if trap_inventory[name] == 0:
		print("Trying to get a trap that have 0 left")
		return false
	trap_inventory[name] -= 1;
	return true


func addTrap(name: String):
	assert(trap_inventory.find_key(name), "Trap does not exists")
	trap_inventory[name] += 1;
	
func trap_count(name: String) -> int:
	assert(trap_inventory.find_key(name), "Trap does not exists")
	return trap_inventory[name]

@export var number_of_coin: int = 0;
