class_name RollingTextEffect extends RichTextEffect


# Syntax: [roll][/roll]
var bbcode = "roll"


func _process_custom_fx(char_fx):
	var c = char_fx.glyph_index
	
	var t = char_fx.elapsed_time + char_fx.glyph_index * 10.2 + char_fx.range.x * 2
	t *= 75
	if sin(t) > 0.0:
		char_fx.glyph_index =  randi() % 10 + 48 
	
	return true
