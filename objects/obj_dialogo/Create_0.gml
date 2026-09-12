dialogo = noone;
indice = 1;
pag = 0;
player	= noone
escala_caixa = 0;


libera_player = function()
{
	if (player)
	{
		with(player)
		{
			estado = estado_parado
		}
	}
	instance_destroy();
}


cria_dialogo = function(_dialogo)
{
	static _gui_w			= display_get_gui_width();
	static _gui_h			= display_get_gui_height();
	static _spr_w			= sprite_get_width(spr_caixa_dialogo);
	static _spr_h			= sprite_get_height(spr_caixa_dialogo);
	
	//Definindo a fonte
	draw_set_font(fnt_dialogo);
	
	
	//Convertendo a escala da sprite da caixa de texto em pixels
	var _escala_x		= (_gui_w / _spr_w) * escala_caixa;
	var _escala_y		= (_gui_h * .3) / _spr_h;
	
	//Aumetando a escala da caixa
	escala_caixa = lerp(escala_caixa, 1, .05);
	
	var _txt			=	_dialogo.texto[pag];
	var _txt_atual		= string_copy(_txt, 1, indice);
	var _txt_tam		= string_length(_txt);
	var _txt_vel		= _dialogo.txt_vel
	var _yy				 = _gui_h - (_escala_y * _spr_h);
	var _margem			= string_height("I");
	var _retrato		= _dialogo.retrato[pag];
	var _ret_escala		= (_gui_h * .2) / sprite_get_height(_retrato);
	var _ret_y			= _yy + (sprite_get_height(_retrato) * _ret_escala / 4 ); 
	var _ret_larg		= _ret_escala * sprite_get_width(_retrato);
	var _qtd_pag		= array_length(_dialogo.texto) - 1;
	
	
	//Desenhando a caixa do texto
	draw_sprite_ext(spr_caixa_dialogo, 0, 0, _yy, _escala_x, _escala_y, 0, c_white, 1);


	
	
	if (escala_caixa > .99) escala_caixa = 1;
	
	//Só faço essas coisas Se eu já terminei de ajustar a escala da caixa
	if (escala_caixa >= 1)
	{
	
		//Sempre que eu apertar espaço, eu pulo de pagina
		if (keyboard_check_pressed(vk_space)) 
		{
			//Se eu ainda não terminei a pagina atual (as letras dela)
			//Eu vou para o final da página atual 
			if (indice < _txt_tam) indice = _txt_tam;
			//Caso contrario, eu pulo de página
			else if (pag < _qtd_pag)
			{
				indice = 0;	
				pag++;
			}
			else //Acabei a página atual e não tenho mais nenhuma pagina para ver
			{
				libera_player();
			}
		}
	
		//Aumentando o valor do indice se ele for menor que o tamanho da string final
		if (indice < _txt_tam) indice += _txt_vel;

	
		//Só faço isso se a escala ainda não chegou em 1
	

	
	
	
		//Desenhando o retrato
		draw_sprite_ext(_retrato, 0, _margem, _ret_y, _ret_escala, _ret_escala, 0, c_white, 1);
	
		draw_text_ext(_margem * 2 + _ret_larg, _yy + _margem, _txt_atual, _margem, _gui_w - _margem * 2- _ret_larg);
		draw_set_font(-1);
	}
}
