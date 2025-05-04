extends ProgressBar



@export var variable_name_1: String
@export var variable_name_2: String

@onready var reggie = get_tree().get_nodes_in_group("player")[0]
@onready var target_node = reggie
var value1: Variant = null
var value2: Variant = null

func _ready():
	print("Target name: ", target_node.name)
	update_values()

func update_values():
	if target_node:
		if variable_name_1 != "" and has_variable(target_node, variable_name_1):
			value1 = target_node.get(variable_name_1)
			print("Value of Variable '%s': %s" % [variable_name_1, str(value1)])
		else:
			value1 = null
			print("Variable '%s' not found" % variable_name_1)
		
		if variable_name_2 != "" and has_variable(target_node, variable_name_2):
			value2 = target_node.get(variable_name_2)
			print("Value of Variable '%s': %s" % [variable_name_2, str(value2)])
		else:
			value2 = null
			print("Variable '%s' not found" % variable_name_2)

func has_variable(node: Object, var_name: String) -> bool:
	return var_name in node.get_property_list().map(func(p): return p.name)
	

func _physics_process(_delta) -> void:
	update_values()
	if variable_name_1 == "timesinceshot":
		var reggiegun = reggie.get_node("gun")
		
		var timesinceshot = reggiegun.timesinceshot
		var outof = reggiegun.reloadtime
		value = 100 * timesinceshot / outof
		print("Reload Time: ", value)
	else:
		if value1 and value2 != null: value = 100 * value1 / value2
		
