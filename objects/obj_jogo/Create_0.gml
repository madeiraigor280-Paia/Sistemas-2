

//Me dando uma arma
//global.inventario[# 2,2] = global.armas[| armas.espada_madeira];
//global.inventario[# 0, 1] = global.armas[| armas.espada_comum];
//global.inventario[# 0, 0] = global.armas[| armas.espada_sangue];


//global.inventario[# 1, 0] = global.consumiveis[| consumiveis.pocao_vermelha];
//global.inventario[# 1, 1] = global.consumiveis[| consumiveis.pocao_coracao];
 

display_set_gui_size(512, 288);

dados = noone;

iniciei = false;

inicia_jogo = function(_dados)
{
	//Se eu estou na room inicial
	//Vou ver se a sequencia foi terminada
	var _seq = pega_sequencia("Inicio");
	
	//Checando se a sequencia terminou
	if (layer_sequence_is_finished(_seq))
	{
		//Rodei a função
		iniciei = true;
		
		//Se os dados foram inválidos (false)
		//Ele inicial o jogo normalmente da tela inicial
		if (room == rm_inicio)
		{
			if (!_dados)
			{
			room_goto(rm_modelo);	
			var _player		= instance_create_layer(896, 400, "Player", obj_player);
			var _transicao = instance_create_depth(989, 400, -10000, obj_transicao);
			}
			else
			{
				//Se eu tenho dados, eu vou fazer um pouco diferente
				//Ir para correta,e arruma todo o resto		
				//Criando ele na room e posição correta
				room_goto(_dados.player.rm)
				var _player			= instance_create_layer(0, 0, "Player", obj_player)
				with(_player)
				{
					x = _dados.player.meu_x;
					y = _dados.player.meu_y
					
				}
				
				global.max_vida_player = _dados.player.m_vida;
				global.vida_player = _dados.player.vida
				global.arma_player  = _dados.player.arma;
				
			for (var i = 0; i < ds_grid_height(global.inventario); i++)
			{
				for (var j = 0; j < ds_grid_width(global.inventario); j++)
				{
					//global.inventario[# j, i] = _dados.inventario[j][i];
			
					//Ele não consegue salvar a estrutura completa com as funções
					//Porém eu consigo saber QUAL ITEM eu tenho lá
					//Então eu vou mandar ele recriar dentro do inventario o item que 
					//Deveria estar lá
					//Checando qual é o tipo do item
					//Checando o ID do item
					var _item_atual = _dados.inventario[j][i];
					if (_item_atual)
					{
						//Checar qual o tipo de item
						switch(_item_atual.tipo)
						{
							//Caseo ele seja uma arma
				
							case item_tipo.armas:
					
								//Colocando a arma correta no slot	
								//Como eu sei qual é a arma correta ?
								//Usando _item_atual.meu_id
								global.inventario[# j, i] = global.armas[|  _item_atual.meu_id];
								break;
						
								//Caseo seja 1 consumivel
								case item_tipo.consumiveis:
									global.inventario[# j, i] = global.consumiveis[| _item_atual.meu_id];
								break;
					
					
					
						}
				
					}
				}
		
			}

				
				
				
				var _transicao = instance_create_depth(_player.x, _player.y, -10000, obj_transicao);
			}
		}
	}
	
	
	
	//Se os dados forem válidos
	//Ele inicia o jogo com as informações dos dados
	
}

//Sistema de save usando JSON
//A posição do player
salva_jogo = function(_save)
{
	var _arquivo = "Meu save" + string(_save+1) + ".json";
	//Meu save1
	//Alterando o nome do arquivo
	
	

	
	//Convertendo o inventario em array
	var _inv;
	
	for (var i = 0; i < ds_grid_height(global.inventario); i++)
	{
		for (var j = 0; j < ds_grid_width(global.inventario); j++)
		{
			_inv[j][i] = global.inventario[# j, i]
		}
		
	}
	
	
	//Criando  a struct com os meus dados
	var _dados		= 
	{
		//Criando uma struct com os dados do player
		//Criando a struct do player, assim facilitar salvar varias coisas
		player :
		{
			meu_x	: obj_player.x,
			meu_y	: obj_player.y,
			rm		: room,
			vida	: global.vida_player,
			m_vida  : global.max_vida_player,
			arma    : global.arma_player
			
		},
		
		inventario : _inv
		
	}
	
	//Converter os dados em um json
	//Converte uma struct e uma array em um JSON
	var _string = json_stringify(_dados);
	
	//Abrindo o meu arquivo
	//Abrir para escrever no arquivo
	var _file = file_text_open_write(_arquivo);
	
	//Gravando as informações nele
	file_text_write_string(_file, _string);
	
	//Fechando o arquivo
	file_text_close(_file);
	
	
}

//Carregando o jogo do json
carrega_jogo = function(_save)
{
	var _arquivo = "Meu save" + string(_save+1) + ".json";
	
	
	var _file		= file_text_open_read(_arquivo);
	
	//Pegando os dados do arquvivo
	var _string = file_text_read_string(_file);
	
	
	//Fechando o arquivo
	file_text_close(_file);
	
	//Converter a string em um struct novamente
	var _dados = json_parse(_string);
	
	//Passando as informações para o player
	obj_player.x				= _dados.player.meu_x;
	obj_player.y				= _dados.player.meu_y;
	room						= _dados.player.rm;
	global.max_vida_player		= _dados.player.m_vida;
	global.vida_player			= _dados.player.vida;
	global.arma_player			= _dados.player.arma;
	
	//Limpando o meu inventario
	ds_grid_clear(global.inventario, 0)
	
	//Passando os dados do vetor do inventario para  ds grid de inventario
	for (var i = 0; i < ds_grid_height(global.inventario); i++)
	{
		for (var j = 0; j < ds_grid_width(global.inventario); j++)
		{
			//global.inventario[# j, i] = _dados.inventario[j][i];
			
			//Ele não consegue salvar a estrutura completa com as funções
			//Porém eu consigo saber QUAL ITEM eu tenho lá
			//Então eu vou mandar ele recriar dentro do inventario o item que 
			//Deveria estar lá
			//Checando qual é o tipo do item
			//Checando o ID do item
			var _item_atual = _dados.inventario[j][i];
			if (_item_atual)
			{
				//Checar qual o tipo de item
				switch(_item_atual.tipo)
				{
					//Caseo ele seja uma arma
				
					case item_tipo.armas:
					
						//Colocando a arma correta no slot	
						//Como eu sei qual é a arma correta ?
						//Usando _item_atual.meu_id
						global.inventario[# j, i] = global.armas[|  _item_atual.meu_id];
						break;
						
						//Caseo seja 1 consumivel
						case item_tipo.consumiveis:
							global.inventario[# j, i] = global.consumiveis[| _item_atual.meu_id];
						break;
					
					
					
				}
				
			}
		}
		
	}
}
	
	

//Desenhando a vida do player
///@function desenha_coracoes(x, y)
desenha_coracoes = function(_x, _y)
{
	//Desenhando 3 corações vazios
	//Desenhando a quantidade de vida total dividido por 2 de corações
	//Temos que saber a vida maxima
	//Por ser global, podemos acessar ela
	//Cada coração conta dois de vida
	//Começa em 0, faz o que tem que fazer, sobe em dois
	//Depois faz o que tem que fazer, sobe em dois
	//Faz o que tem que fazer
	//Para em 6 pela vida_max
	var _w =  sprite_get_width(spr_coracao);
	for (var i = 0; i < global.max_vida_player; i += 2)
	{
		draw_sprite(spr_coracao, 0,  _x + i * _w , _y)
		
	}
	
	//Desenhando os corações preenchidos
	for (var i = 0; i < global.vida_player; i += 2)
	{
		
		
		//Eu só tenho que aplicar essa regra na ultima repetição
		//Garantindo que o img vai ficar com o valor de 1 se
		//A ultima vida for um numero impar
		var _img = ((global.vida_player - i) != 1) + 1;
		
		draw_sprite(spr_coracao, _img ,  _x + i * _w, _y);
		
	}
}


desenha_pause = function()
{
	var _w = display_get_gui_width();
	var _h	= display_get_gui_height();
	draw_set_alpha(.5);
	draw_rectangle_color(0, 0, _w, _h, c_black, c_black, c_black, c_black, false);	
	draw_set_alpha(1);
	

	
	//Criando uma layer SE ela não existe
	if (!layer_exists("efeito_pause"))
	{
		//Criar uma camada de efeito
		var _blur = fx_create("_filter_linear_blur");
		//Descobrindo qual o valor que eu devo usar
		//var _nome = fx_get_parameter(_blur, _nome[0]);
		//var _par = fx_get_parameter(_blur, _nome[0]);
		//show_message(_par);
	
		fx_set_parameter(_blur, "g_LinearBlurVector", [5, 5]);
		
		
		
		layer_create(-10000, "efeito_pause");
		//Criei a minha layer, eu aplico o efeito
		layer_set_fx("efeito_pause", _blur);
	}
	//Se a camada existe, eu aplico o efeito nela
		
	//Criar um efeito de blur
	
	//Configurar o feito de blue
}

///Desenha inventario
desenha_inventario = function()
{
	static _item_mouse = 0;
	//Variáveis para saber a seleção X e Y
	static	_sel_x = 0, _sel_y = 0;
	//Pegando as dimensões da minha tela
	
	var _gui_w			= display_get_gui_width();
	var _gui_h			 = display_get_gui_height();
	var _spr_w			= sprite_get_width(spr_inventario_fundo);
	var _spr_h			= sprite_get_width(spr_inventario_fundo);
	var _inv_w			= _gui_w * .6;
	var _inv_h			= _gui_h * .6;
	var _inv_x			= _gui_w/2 - _inv_w  / 2;
	var _inv_y			= _gui_h/2 - _inv_h / 2
	var _marg_x			= _inv_w * 0.04;
	var _marg_y			= _inv_h * .05;
	var _item_x			= _inv_x + _marg_x;
	var _item_y			= _inv_y + _marg_y;
	var _item_w			= _inv_w * .7 - _marg_x;
	var _item_h			= _inv_h - _marg_y * 2;
	var _desc_x			= _item_x + _item_w + _marg_x;
	var _desc_y			= _item_y;
	var _desc_w		    = _inv_w * .3 - _marg_x * 2;
	var _desc_h			= _item_h;
	var _cols			= ds_grid_width(global.inventario);
	var _lins			= ds_grid_height(global.inventario);
	var _grid_marg_x	= _item_w * .02;
	var _grid_marg_y	= _item_h * .02;
	//Preciso checar o tamanho total, subtraindo  dele as margens que eu criei
	var _grid_w			= (_item_w - _cols * _grid_marg_x) div _cols;
	var _grid_h			= (_item_h - _lins * _grid_marg_y) div _lins;
	var _mouse_x		= device_mouse_x_to_gui(0)
	var _mouse_y		= device_mouse_y_to_gui(0)
	
	//Para determinar o tamanho de cada quadrado eu preciso
	//Levar em conta o tamanho de cada quadrado, com as margens também
	
//	//Desenhando a caixa no meio
//	//draw_sprite(spr_inventario_fundo, 0, _gui_w/2 - _spr_w/2, _gui_h/2 - _spr_h/2);
	
	
	
	
//	//Desenhando a caixa com dimensões especificas
	draw_sprite_stretched(spr_inventario_fundo, 0, _inv_x, _inv_y , _inv_w, _inv_h);
	
//	//Desenhando o quadrado na parte da grid
	draw_rectangle(_item_x, _item_y, _item_x + _item_w, _item_y + _item_h, 1);
	
//	//Desenhando o retangulo na parte das informações do item	
	draw_rectangle(_desc_x, _desc_y, _desc_x + _desc_w, _desc_y + _desc_h, true);
	

	//Fazer o X e o Y junto para salvar a seleção
	//Testando no X primeiro, o clamp retorna o valor dentro do intervalo e nunca vai ser diferente do intervalo
	
	//Se for verdade ele é true
	
	var _mouse_na_area = _mouse_x == clamp(_mouse_x, _item_x, _item_x + _item_w) &&
						_mouse_y == clamp(_mouse_y, _item_y, _item_y + _item_h);
	
	//Usando o item quando eu apertar o botão direito do mouse apenas se eu
	//Estiver na área correta
	if (_mouse_na_area)
	{
		var _item_sel = global.inventario[# _sel_x, _sel_y]
		//Usando o item com o botão direito do mouse
		if (mouse_check_button_released(mb_right))
		{
				//Se existe um item nessa posição
				if (_item_sel)
				{
					_item_sel.usa_item();
					
					//Checando se este item é consumivel
					if (_item_sel.tipo == item_tipo.consumiveis)
					{
						//Apagando o item
						global.inventario[# _sel_x, _sel_y] = 0;
					}
				}
				
					
		}
			if (mouse_check_button_released(mb_left))
				{
					//Se eu cliquei com o botão esquerdo, eu quero poder mover o item
					_item_mouse = troca_item(_sel_x, _sel_y, _item_mouse);
			
		}
		
		
	}
	else //Mouse não esta na area do inventario
	{
		//Se eu cliquei fora dele e estou com item, eu jogo fora o item
		if (_item_mouse)
		{
			if (mouse_check_button_released(mb_left))
			//Eu quero jogar o item dentro da room, por isso o mouse_x não ser o da gui
			{
				//Checando quantas armas iguais eu tenho
				var _qtd_armas = conta_armas(global.arma_player);
				
				if (_item_mouse != global.arma_player or _qtd_armas > 0)
				{
					var _novo_item = instance_create_layer(mouse_x, mouse_y, "player", obj_item);
				
					//Avisando ao item, qual item ele é
					_novo_item.item = _item_mouse;
					//Apagando o item do mouse
					_item_mouse = 0;
				}
			}
			
		}
		
	}
	
	
	var _equip_x = _inv_x + _inv_w / 2 - _grid_w / 2;
	var _equip_y = _inv_y - _grid_h;
	//Desenhando a caixa do item equipado
	//O espaço inteiro é o _inv_x que é o começo
	draw_sprite_stretched(spr_inventario_caixa, 0, _equip_x, _equip_y, _grid_w, _grid_h);
	//Desenhando o equipamento atual
	if (global.arma_player)
	{
		var _equip_w = _grid_w * .5;
		var _equip_h = _grid_h * .5;
		draw_sprite_stretched(global.arma_player.spr, global.arma_player.meu_id, _equip_x + _equip_w / 2, _equip_y + _equip_h / 2, _equip_w, _equip_h);
	}
	//Desenhando os itens no espaço dos itens
	for(var i = 0; i < _lins; i++)
	{
		for(var j = 0; j < _cols; j++)
		{
			//Garantir que esse códico só vai rodar SE eu estiver com o mouse
			//Na area de seleção
			//Checando a posição do mouse dentro do espaço dos itens
			//Tenho que subtrair o espaço que eu tenho a mais, ele ajusta
			//Criando o espaço inicial e levando em conta a margem dos itens
			//Tirei o espaço que tinha no item_x, subtraindo eles com o item
			
			
			if (_mouse_na_area)
			{
				_sel_y	= (_mouse_y - _item_y - (_grid_marg_y * i))	div _grid_h;
			
				_sel_x	= (_mouse_x - _item_x - (_grid_marg_x * j))	div _grid_w;
			}
			//Garantindo que o _sel x e y não passem dos limites da minha grid
			_sel_x = clamp(_sel_x, 0, _cols-1);
			_sel_y = clamp(_sel_y, 0, _lins-1);
			
			//Levar a margem da grid em conta em relação ao J e o I
			var _x1		= _item_x + _grid_w * j + (_grid_marg_x * j) + _grid_marg_x;
			var _y1		= _item_y  + _grid_h * i + (_grid_marg_y * i) + _grid_marg_y;
			
			//Checando se a caixa que eu to desenhando agora é da seleção atual
			var _selecionado = (_sel_x == j && _sel_y == i);
			
			draw_sprite_stretched(spr_inventario_caixa, _selecionado, _x1, _y1, _grid_w, _grid_h);
			
			//Checando se na minha seleção atual existe algum item
			//Como eu sei se tem um item ?
			//Seleção atual ou o valor é zero, ou ela tem item
			var _item_atual = encontra_item(j, i)
			//Se a seleção atual possui um valor que não seja nulo (0, -1, -2 ou qualquer negativo
			if (_item_atual)
			{
				
				//Melhor multiplicar do que dividir
				var _item_atual_w = _grid_w * .5;
				var _item_atual_h = _grid_h * .5;
				
				//Criar depois que eu saber o tamanho dele
				var _item_atual_x = _x1 + _item_atual_w / 2;
				var _item_atual_y = _y1 + _item_atual_h / 2;
				//Desenhar a SPRITE do item	
				//draw_text(_x1, _y1, "Tenho item");
				//Ele pega o sprite, o id do item 
				draw_sprite_stretched(_item_atual.spr, _item_atual.meu_id,
										_item_atual_x, _item_atual_y, _item_atual_w, _item_atual_h
						);
				
			}
			
			//Pegando o item que o cursor esta por cima
			var _sel_atual = encontra_item(_sel_x, _sel_y);
			
			//Se eu tenho algum item na seleção atual, eu desenho ele no espaço de descrição
			if (_sel_atual)
			{
				var _sel_atual_spr_w	= sprite_get_width(_sel_atual.spr);
				//Melhor multiplicar do que dividir
				var _sel_atual_w		 = _grid_w * .5;
				var _sel_atual_h		 = _grid_h * .5;
				
				//Ajustando a escala da sprite da seleção atual
				var _sel_atual_escala	= _sel_atual_w / _sel_atual_spr_w;
				//Avancei metade		 do espaço e voltei metade da sprite
				var _sel_atual_x			= _desc_x + _desc_w / 2;
				var _sel_atual_y		 = _desc_y + _sel_atual_h;
				var _efeito_x			= sin(2 * get_timer() / 1000000);
				
				//Desenhando a sprite
				//draw_sprite_stretched(_sel_atual.spr, _sel_atual.meu_id, _sel_atual_x, _sel_atual_y,
				//_sel_atual_w * _efeito_x, _sel_atual_h);
				
				draw_sprite_ext(_sel_atual.spr, _sel_atual.meu_id, _sel_atual_x, _sel_atual_y, _sel_atual_escala * _efeito_x, _sel_atual_escala, 0, c_white, 1);
				draw_set_font(fnt_inventario);
				
				//Desenhando a minha fonte em escala
				
				
				draw_set_halign(1);
				//Desenhando o texto
				//Desenhando a minha fonte em escala
				var _sep = string_height("I");
				draw_set_color(c_black);
				//Fazer a sombra
				draw_text_ext_transformed(_sel_atual_x + 1, _sel_atual_y + _sel_atual_h + 1, _sel_atual.desc, _sep, _desc_w * 10, .1, .1, 0);
				draw_set_color(c_white);
				//Aqui desenha atras
				draw_text_ext_transformed(_sel_atual_x, _sel_atual_y + _sel_atual_h, _sel_atual.desc, _sep, _desc_w * 10, .1, .1, 0);
				//draw_text_ext(_sel_atual_x, _sel_atual_y + _sel_atual_h,_sel_atual.desc, 20, _desc_w);
				draw_set_halign(-1);
				draw_set_font(-1);
				
			}
		
		
		}	
		
	//Desenhando o item do mouse no mouse
	//Desenhar depois do laço de repetição
	if (_item_mouse)
	{
		draw_sprite_stretched(_item_mouse.spr, _item_mouse.meu_id, _mouse_x, _mouse_y, _grid_w / 2, _grid_h /2);
	}
		
	}
}
//Encontra item
encontra_item = function(_x, _y)
{
	//Na pratica ele funciona que nem o outro
	return global.inventario[# _x, _y]
	
}

troca_item = function(_x, _y, _item)
{
	//Pegando o item na posição do inventario	
	//Salvei o item que está no inventario na posição passada
	var _item_guardado = global.inventario[# _x, _y];
	//Colocando o item que ele me deu, na posição do inventario
	global.inventario[# _x, _y] = _item;
	//O item que ele tinha, ele passou pra ele
	
	return _item_guardado;
}

conta_armas = function(_arma)
{
	var _qtd = 0;
	for (var i = 0; i < ds_grid_height(global.inventario); i++)
	{
		for (var j	= 0; j < ds_grid_width(global.inventario); j++)
		{
			if (global.inventario[# j, i] == _arma) _qtd++;
			
			
		}
		
		
		
	}
	return _qtd;
	
	
}

//desenha_inventario = function()
//{
//	//Pegando as dimensões da minha tela
//	var _gui_w = display_get_gui_width();
//	var _gui_h = display_get_gui_height();
	
//	//Desenhando a caixa no meio
//	draw_sprite(spr_inventario_fundo, 0, _gui_w/2, _gui_h/2);
	
	
	
	
//}