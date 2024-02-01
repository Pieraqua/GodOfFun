extends CanvasLayer

func _ready():
	$ContainerPontos/HPContainer/HPCircle.frame = 4

func _on_update_combo(current_combo : int):
	$ContainerPontos/TexturaCombo/TextoCombo.text = str(int(current_combo))
	
func _on_update_points(current_points : int):
	$ContainerPontos/TextoPontos.text = "Pontos: " + str(int(current_points))

func update_hp(current_hp : float):
	$ContainerPontos/HPContainer/HPCircle.frame = int(current_hp/20)

func update_timer(time_left : float):
	$ContainerPontos/TextoTempo.text = str(time_left)
