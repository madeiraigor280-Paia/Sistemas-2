transicao = false;

// Inherit the parent event
event_inherited();




global.debug = false

max_vel = 3;
meu_acel = .2;
roll_vel = 5;

somb_xscale = .6;
somb_alpha = .2;
dano_dir	 = 0;
defendi		 = false;
seq_especial	= noone;


tempo_invencivel = room_speed * 2;
timer_invencivel = tempo_invencivel;

acel	= meu_acel;
face = 0;
sprite	= sprite_index;
xscale = 1;


estado	 = noone;
estado_txt = "parado";

debug = false;

npc_dialogo = noone;

attack =	false;
shield = false;
roll = false;

//Imagem atual da animação
image_ind = 0;
//Velocidade da animação
image_spd = 8 / room_speed;
//Quantidade de imagens na minha sprite
image_numb = 1;

//Criando a camera
var _cam = instance_create_layer(x, y, layer, obj_camera);

sprites		=	[

					
					//Sprites parado
					[spr_player_pobre_idle_direita, spr_player_pobre_idle_up, spr_player_pobre_idle_direita, spr_player_pobre_idle_down],
					//Sprites Correndo
					[spr_player_pobre_andando_direita, spr_player_pobre_andando_up, spr_player_pobre_andando_direita, spr_player_pobre_andando_down],
					//Ataque
					[spr_player_pobre_ataque_direita, spr_player_pobre_ataque_up, spr_player_pobre_ataque_direita, spr_player_pobre_ataque_down],
					//Defesa
					[spr_player_pobre_shield_direita, spr_player_pobre_shield_up, spr_player_pobre_shield_direita, spr_player_pobre_shield_down],
					//Rolando
					[spr_player_pobre_roll_direita, spr_player_pobre_roll_up, spr_player_pobre_roll_direita, spr_player_pobre_roll_down],
					//Dano
					[spr_player_hurt_right, spr_player_hurt_up, spr_player_hurt_right, spr_player_hurt_down]
					];
					
					
sprites_atacando = [
	//Sprites no soco
	[spr_player_pobre_ataque_direita, spr_player_pobre_ataque_up, spr_player_pobre_ataque_direita, spr_player_pobre_ataque_down],
	//Espada
	[spr_player_pobre_espada_direita, spr_player_pobre_espada_up, spr_player_pobre_espada_direita, spr_player_pobre_espada_down]
	




		];
sprites_index = 0;

//Mapeando a esquerda
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("D"), vk_right);
keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("J"), ord ("C"));
keyboard_set_map(ord("L"), ord ("Z"));
keyboard_set_map(ord("K"), ord ("X"));
keyboard_set_map(vk_enter, vk_space);


ajusta_sprite = function(_indice_array)
{
	//Checando se a sprite que eu estou usando é a que eu deveria estar usando
	//Sprite de parado
	//Sprite de ataque
	//Isso quer dizer que eu acabei de chegar nesse estado (se a minha sprite esta errada)
	if (sprite != sprites[_indice_array][face])
	{
		//Acabei de entrar no estado
		//Garantindo que a animação começa do começo
		image_ind = 0;
		
	}
	
	//Aplicando a sprite correta
	sprite = sprites[_indice_array][face];
	
	//Descobrindo o image number da sprite que eu to usando
	image_numb = sprite_get_number(sprite);
	
	//Aumentando o valor do image ind com base na image spd
	image_ind += image_spd;
	
	//Zerando o image ind  depois da animação acabar
	image_ind %= image_numb;
}

ajusta_spr_ataque = function(_indice_array)
{
	//Checando se a sprite que eu estou usando é a que eu deveria estar usando
	//Sprite de parado
	//Sprite de ataque
	//Isso quer dizer que eu acabei de chegar nesse estado (se a minha sprite esta errada)
	if (sprite != sprites_atacando[_indice_array][face])
	{
		//Acabei de entrar no estado
		//Garantindo que a animação começa do começo
		image_ind = 0;
		
	}
	
	//Aplicando a sprite correta
	sprite = sprites_atacando[_indice_array][face];
	
	//Descobrindo o image number da sprite que eu to usando
	image_numb = sprite_get_number(sprite);
	
	//Aumentando o valor do image ind com base na image spd
	image_ind += image_spd;
	
	//Zerando o image ind  depois da animação acabar
	image_ind %= image_numb;
}

controla_player = function()
{
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	attack		= keyboard_check_pressed(ord("C"));
	shield = keyboard_check(ord("Z"));
	roll = keyboard_check_pressed(ord("X"));
	
	if (keyboard_check_pressed(vk_control) && global.arma_player)
	{
		estado = estado_ataque_especial;
	}
	
	//ajustando a face
	if (_up) face = 1;
	if (_down) face = 3;
	if (_left) { face = 2; xscale = -1; }
	if (_right) { face = 0; xscale = 1; }
	
	if ((_up xor _down) or (_left xor _right))
{
	//Descobrindo a direção que o player ta indo
	//Point direction
	var _dir = point_direction(0, 0, ( _right - _left), (_down - _up));

	//Pegando o valor do velh
	var _max_velh = lengthdir_x(max_vel, _dir);
	velh = lerp(velh, _max_velh, acel);
	
	//Pegando o valor do velv
	var _max_velv = lengthdir_y(max_vel, _dir);
	velv = lerp(velv, _max_velv, acel);
	
}
else	//Não estou apertando nenhuma tecla de movimento
{
	//Perdendo velocidade
	velh = lerp(velh, 0, acel);
	velv = lerp(velv, 0, acel);
	
	
	
}
	
	
}


estado_parado = function()
{
	controla_player();
	
	estado_txt = "parado";
	sprites_index = 0;
	//Ficando parado
	velh = 0;
	velv = 0;
	
	var _up = keyboard_check(vk_up);
	var _down = keyboard_check(vk_down);
	var _left = keyboard_check(vk_left);
	var _right = keyboard_check(vk_right);
	
	ajusta_sprite(sprites_index);
	
	
	
	//Saindo do estado de parado
	if ((_up xor _down) or (_left xor _right))
	{
		estado = estado_movendo;
	}
	
	//Indo para o estado de ataque
	if (attack && global.arma_player)
	{
		estado = estado_ataque;
	}
	if (shield)
	{
		estado = estado_defesa;
	}
	if (roll)
	{
		estado = estado_rolando;
	}
	
}

estado_movendo = function()
{
	controla_player();
	estado_txt = "movendo";
	sprites_index = 1;
	//Definindo a sprite correta
	//Indo para baixo
	ajusta_sprite(sprites_index);
	
	//Ajustando a sombra
	//Checar se a imagem ta no chão
	if (clamp(image_ind, 1, 3) == image_ind)
	{
		//Estou no chão
		somb_xscale = lerp(somb_xscale, .6, .1);
	}
	else
	{
		somb_xscale = lerp(somb_xscale, .4, .1);
	}
		
	
	//Saindo do estado de movendo
	if (abs(velv) <= 0.1 && abs(velh) <= 0.1)
	{
		estado = estado_parado;
		somb_xscale = .6;
		
	}

	 if (attack && global.arma_player)
	 {
		 estado = estado_ataque;
		somb_xscale = .6;
	 }
	if (shield)
	{
		estado = estado_defesa;
		somb_xscale = .6;
	}
	
	if (roll)
	 {
		 estado = estado_rolando;
		 somb_xscale = .6;
	 }
	
}

estado_ataque = function()
{
	static _meu_dano = noone;
	estado_txt = "Ataque";
	
	//Ajustando a sprite
	//ajusta_sprite(2);
	ajusta_spr_ataque(global.spr_ind_arma-1)
	
	//Eu fico parado nesse estado
	velh = 0;
	velv = 0;
	
	
	
	//Preciso criar o dano!
	//Só crio o dano se eu ainda não tenho um dano
	if (!_meu_dano)
	{
		var _dano_x = x + lengthdir_x(sprite_width, face * 90)
		var _dano_y = y +  lengthdir_y(sprite_height, face * 90)
		//Adicionar um espaço se a face é 1
		//A face esta olhando para cima ? Se sim, o valor de add é metade da sprite
		//Caso contrario o valor de add é zero
		var _add	= face == 1 ? sprite_height / 2 : 0
	
		_meu_dano = instance_create_depth( _dano_x, _dano_y - sprite_height / 2 + _add, depth, obj_dano);
		_meu_dano.meu_pai = id;
	}
	
	//Saindo do estado de ataque
	if (image_ind + image_spd >= image_numb)
	{
		estado = estado_parado;
		
		//Resetando o meu dano
		instance_destroy(_meu_dano);
		_meu_dano = noone;
	}
}

estado_ataque_especial = function()
{
	image_alpha = 0;
	velh = 0;
	velv = 0;
	
	
	
	estado_txt = "Ataque especial";
	//Preciso ver se eu tenho uma espada
	if (global.arma_player)
	{
		if (!seq_especial)
		{
			//Usando o ataque especial dessa espada
			seq_especial = global.arma_player.esp();
			
		}
	}
	else
	{
		estado = estado_parado;
	}
	
	//Checando se a animação acabou
	//Retorna true ou false se a animação acabou
	if (seq_especial)
	{
		if (layer_sequence_is_finished(seq_especial))
		{
			estado = estado_parado;
			image_alpha = 1;
		
			//Destruindo a sequência
			layer_sequence_destroy(seq_especial);
			//Resetando a seq especial
			seq_especial = noone;
		
			//Se a layer especial existe, eu vou destruir ela
			if (layer_exists("ataque_especial"))
			{
		
				layer_destroy("ataque_especial");
			}

		}
		
	}
	else
	{
		estado = estado_parado;
		image_alpha = 1;
	}
}


estado_defesa = function()
{
	static _novo_velh = 0, _novo_velv = 0;
	estado_txt = "Defesa";
	
	ajusta_sprite(3);
	//Controla player
	controla_player();
	
	//Deixar ele parado
	velh = _novo_velh;
	velv = _novo_velv;
	
	_novo_velh = lerp(_novo_velh, 0, .1);
	_novo_velv = lerp(_novo_velv, 0, .1);
	
	if (defendi)
	{
		_novo_velh = lengthdir_x(2, dano_dir)
		_novo_velv = lengthdir_y(2, dano_dir)
		defendi = false;
	}
	
	//Saindo do estado
	if (!shield)
	{
		estado = estado_parado;
		_novo_velh = 0;
		_novo_velv = 0;
	}

}



estado_rolando = function()
{

	
	//Checando se eu ainda não entrei no meu estado
	if (estado_txt != "Rolando")
	{
		
		//Pegando as teclas
		var _up = keyboard_check(vk_up);
		var _down = keyboard_check(vk_down);
		var _left = keyboard_check(vk_left);
		var _right = keyboard_check(vk_right);
	
		
		
		//Se não é igual, é por que eu acabei de entrar no estado
		//Achando minha direção
		//Só faço isso, se o velh ou o velv for diferente de 0
		if ((_up xor _down) or (_right ^^_left)) // ^^ = xor
		{
			var _dir = point_direction(0, 0, _right - _left, _down - _up);
			velh	= lengthdir_x(roll_vel, _dir);
			velv	= lengthdir_y(roll_vel, _dir);
		}
		else //Caso contrário, role na direção que voce ta olhando
		{
			velh	= lengthdir_x(roll_vel, face * 90);
			velv	= lengthdir_y(roll_vel, face * 90);
			
		}
		//Pulando 1 frame
		image_ind++;
	}
	
	estado_txt = "Rolando";
	
	//Troquei a sprite de posição
	ajusta_sprite(4);
	
	
	//Vou definir um tempo para a animação
	//E com base nesse tempo ele vai ajustar o image_spd
	//30 frames
	//Sabendo quantos frames a sprite tem
	
	//Ajustando a velocidade da animação
	image_spd = sprite_get_number(sprite) / (room_speed / 3);
	
	//Saindo do estado de rolando
	if (image_ind + image_spd >= image_numb)
	{
		estado = estado_parado;
		

		//Resetando a velocidade da animação
		image_spd = 6 / room_speed;
	}
	
}

estado_dano = function()
{
	//Aumentar o tempo para ele começar no zero, subir até o 2 e zerar ele
	
	estado_txt	 = "Tomando dano";
	ajusta_sprite(5);
	
	velh = lengthdir_x(1, dano_dir);
	velv = lengthdir_y(1, dano_dir);
	
	//Saindo do estado depois do meio secundo
	//Como saber que ele ta maior que meio segundo ? Usando room speed
	if (timer_invencivel > room_speed / 2)
	{
		estado = estado_parado;
		velh = 0;
		velv = 0;
	}
}

efeito_dano = function()
{
	//Se o timer ainda não chegou no tempo de invencibilidade
	//Então aumento o valor dele
	//Faço ele piscar trasnparente 
	if (timer_invencivel < tempo_invencivel)
	{
		timer_invencivel++;
		image_alpha = abs(sin(get_timer() / 200000));
		
	}
	else
	{
		image_alpha = 1;
	}
}

estado_indo_dialogo = function()
{
	estado_txt = "Indo para o diálogo";
	velh = 0;
	velv = 0;
	
	ajusta_sprite(1)
	//Checando se eu estou na direita ou esquerda
	//Me movendo na horizontal SE eu não estou na posição correta
	if (npc_dialogo)
	{
		var _x = npc_dialogo.x;
		var _y = npc_dialogo.y + npc_dialogo.margem;
		if (bbox_top != _y)
		{
			//Ajustando o velv
			velv = sign(_y - bbox_top);
			
			//Ajustando a face
			face = velv < 0 ? 1 : 3;
			
			y = round(y);
			
			
			
		}
		else if (x != _x)
		{
			face = 0;
			//Me movo
			velh = sign(_x - x);
			
			//Eu mudo o xscale com base no velh
			xscale = velh;
			
			x = round(x);
		}
		else
		{	
			//Estou na posição correta, vou para o dialogo
			estado = estado_dialogo;
			
		}
	}
	
	
}

estado_dialogo = function()
{
	estado_txt = "Dialogo"
	velh = 0;
	velv = 0;
	face = 1;
	ajusta_sprite(0);
	
	//Criando o diálogo
	//Checando se ele ainda não existe
	if (!instance_exists(obj_dialogo))
	{
		var _obj_dialogo = instance_create_depth(0, 0, 0, obj_dialogo);
		_obj_dialogo.player = id;
		//Passando o diálogo do npc para o objeto dialogo
		with(npc_dialogo)
		{
			//Dialogo do objeto dialogo		Dialogo do npc
			_obj_dialogo.dialogo	=	 dialogo;
			
		}
	}
	
	
}

toma_dano = function(_dano = 1)
{
	//Só pode tomar se o timer invencivil não acabou
	if (timer_invencivel >= tempo_invencivel)
	{
		//Pegando a diferença entre o meu angulo e do inimigo
		//Primeiro eu pego o do meu angulo usando a minha face
		//Girando o angulo do player para facilitar
		var _ang_dif = abs(angle_difference((face * 90 - 180), dano_dir));
		
		//Se a diferença entre os nossos angulos for baixa (e eu estiver defendendo)
		var _defesa = _ang_dif < 90 && estado == estado_defesa;
		//abs(face - 2) == dano_dir div 90;
		//Ele sai do método
		//Só roda esse codico se a condição de cima não executar
		if (_defesa)
		{
			defendi = true;
			return
		}
		if (estado == estado_rolando) return;
		
		
		
			estado = estado_dano;
			timer_invencivel = 0;
			global.vida_player -= _dano;
			
	}
}

estado = estado_parado;
