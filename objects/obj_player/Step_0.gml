//Se o jogo ta pausado, eu não rodo nada daqui
if (global.pause or transicao)
{
	velh = 0;
	velv = 0;
	
	exit;
}

if (keyboard_check_released(vk_shift)) toma_dano();

if (keyboard_check_released(vk_tab)) global.debug = !global.debug



//Checando se eu estou no gelo
//Vai retornar false (-4) se eu não estou colidindo
//Vai retornar o ID do gelo que colidiu comigo
var _gelo = instance_place(x, y, obj_gelo);

//Checando se eu estou no gelo
if (_gelo)
{
	acel = _gelo.meu_acel;	
	
}
//Se eu não colidi, o valor do acel é o meu acel
else
{
	acel = meu_acel;
}


//Só faço isso, se eu estou apertando alguma tecla
//Eu só quero que ele faça isso 
//Se eu estou apertando para a esquerda ou para a direita, mas não os dois


show_debug_message(image_ind);

efeito_dano();
estado();

