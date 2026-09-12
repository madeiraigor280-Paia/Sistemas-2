//Save 1
//Save 2
//Save 3

//Controlando se eu fui ativado


//Salvando a posição inicial do meu y
meu_y_inicial = 81;

meus_dados = 0

image_alpha = .2;

//Para ficar branco, todas as cores terem que estar no 255
blue	 = 255;
red		 = 255;
green	 = 255



global.iniciou = false;

//Primeiro que é criado é 1, o segundo é 2, e o terceiro é 3
meu_save = instance_number(obj_save);

meu_efeito = function()
{
	image_blend = make_color_rgb(red, green, blue);
	//Pegar se o mouse está em cima
	var _mouse_sobre = position_meeting(mouse_x, mouse_y, id)
	var _mouse_click = mouse_check_button_released(mb_left);
	
	if (_mouse_sobre)
	{
		
		y			 = lerp(y, meu_y_inicial - 20, .1);
		image_alpha	 = lerp(image_alpha, .8, .1);
		red 		 = lerp(red, 80, .1)	
		blue		 = lerp(blue, 80, .1);
		green		 = lerp(green, 200, .1)
		
		//Checando se a pessoa clicou em mim
		if (_mouse_click && global.iniciou == false)
		{
			//show_message("kkkkk")
			global.iniciou = true;
			
			//Definindo o save do jogo
			global.save = meu_save-1;
			
			var _seq = pega_sequencia("Inicio");
			
			layer_sequence_play(_seq);
			
			//Passando os meus dados para o objeto jogo
			if (instance_exists(obj_jogo))
			{
				obj_jogo.dados = meus_dados;
			}
		}
	}
	else
	{
		y = lerp(y, meu_y_inicial, .1);
		image_alpha = lerp(image_alpha, .2, .1);
		red 		 = lerp(red, 255, .1)	
		blue		 = lerp(blue, 255, .1);
		green		 = lerp(green, 255, .1)
	}
}

//Pega save
pega_save = function(_save)
{
	//Tentar abrir o arquivo do jogo
	//Se ele conseguir ele retorna o arquivo
	//Se não conseguir ele retorna false
	
	//Pegando o nome do arquivo
	var _meu_arquivo = "Meu save" + string(_save) + ".json";
	
	//Tentando abrir o arquivo
	var _arquivo		= file_text_open_read(_meu_arquivo)
	
	//Se o arquivo for inválido eu retorno false
	if (_arquivo == -1) return false;
	
	//Salvando a informação em algum lugar
	var _string = file_text_read_string(_arquivo)
	
	//Convertendo a string em uma struct
	var _dados = json_parse(_string)
	
	//Retornando os dados
	return _dados;
}

//Pegando o meu save
meus_dados = pega_save(meu_save);