extends Control

# Define the pools of words to generate placeholder text
var nouns = ["knight", "dragon", "forest", "castle", "moon", "star", "adventure", "treasure", "storm"]
var verbs = ["seeks", "fights", "journeys", "discovers", "challenges", "protects", "defends", "questions"]
var adjectives = ["brave", "mysterious", "ancient", "glowing", "forgotten", "fearsome", "legendary", "hidden"]
var adverbs = ["boldly", "mysteriously", "bravely", "fiercely", "quickly", "cautiously", "silently", "relentlessly"]


func set_number(value):
	$Background/Number.text =  "- "+str(value) + " -"
	$Background/Text.text = generate_placeholder_text(value)

# Function to generate random placeholder text
func generate_placeholder_text(seed : int):
	var random_noun = nouns[seed % nouns.size()]
	var random_verb = verbs[seed % verbs.size()]
	var random_adjective = adjectives[seed % adjectives.size()]
	var random_adverb = adverbs[seed % adverbs.size()]

	# Combine the randomly selected words into a sentence
	var sentence = "The " + random_adjective + " " + random_noun + " " + random_verb + " " + random_adverb + "."
	return sentence
