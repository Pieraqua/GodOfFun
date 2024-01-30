extends CanvasLayer

func _on_update_combo(current_combo : int):
	$ContainerPontos/TexturaCombo/TextoCombo.text = str(int(current_combo))
	
func _on_update_points(current_points : int):
	$ContainerPontos/TextoPontos.text = "Pontos: " + str(int(current_points))
