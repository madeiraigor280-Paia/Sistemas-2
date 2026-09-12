//Pausando o jogo ao apertar o esc
if (keyboard_check_released(vk_escape)) global.pause = !global.pause;

//Testando o meu save
if (keyboard_check_released(vk_numpad0)) salva_jogo(global.save);
if (keyboard_check_released(vk_numpad1)) carrega_jogo(global.save);

////Perdendo vida ao apertar o backspace
//if (keyboard_check_released(vk_backspace))
//{
//	global.vida_player--;
//	global.vida_player = clamp(global.vida_player, 0, global.max_vida_player);
//}

if (!iniciei)
{
	inicia_jogo(dados);
}
//Se o jogo esta pausado, eu vou para todas as entidades
if (global.pause)
{
	if (instance_exists(obj_entidade))
	{		
		with(obj_entidade)
		{
			velh = 0;
			velv = 0;
			image_speed = 0;
		}
	}
	

}

