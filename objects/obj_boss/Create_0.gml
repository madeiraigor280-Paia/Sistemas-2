// Inherit the parent event
event_inherited();

vida_max = 20;
vida_atual = vida_max;
dano = 0;
//Definindo as sprites
sprites = [spr_boss_queimando,spr_boss_queimando, spr_boss_queimando, spr_boss_queimando];

me_apaguei = true;
tempo_apagar = 600;

max_barra_fogo = 100;
barra_fogo = max_barra_fogo;



muda_estado = function()
{
			//Checando se eu estou com o mouse em cima do inimigo
	var _mouse_sobre = position_meeting(mouse_x, mouse_y, id);

	//Checando se clicaram com o botão do meio
	var _click = mouse_check_button_released(mb_middle);

	//Se a pessoa clicou enquanto o mouse estava sobre mim
	//ou seja, clicou em mim
	//Ele muda meu estado
	if (_mouse_sobre && _click)
	{
		estado = get_string("Digite o estado", "parado");
}
}
//Olhando o player
olhando = function()
{
	
	image_spd = 6 / room_speed;
	
	var _player = collision_circle(x, y, campo_visao, obj_player, false, true);
	
	//Se o player entrou no campo de visão, eu sigo ele
	if (_player && t_persegue <= 0)
	{
		estado = "persegue";
		alvo = _player;
		
	}
}


controla_estado = function()
{
	
	
	//Controlando os estados do inimigo
	switch(estado)
	{
		#region parado
		case "parado":
		
		image_speed = 6 / room_speed;
		
		
		//Diminuindo o tempo de persegue
		if (t_persegue > 0) t_persegue--;
		
		//Diminuindo o tempo
		tempo--;
		image_blend = c_white;
		//Ele deve ficar parado
		velh = 0;
		velv = 0;
		
		//Regra para sair deste estado
		if (tempo < 0)
		{
			//Mudando de estado
			estado = choose("parado", "andando");
			
			//Reseto o tempo
			tempo = tempo_estado;
			
		}
		olhando();
		
		
		break;
		#endregion
		
		#region andando
		case "andando":
			
			
			
			//Estado de andando
			tempo--;
			image_blend = c_white;
			
			image_speed = 8 / room_speed;
			
			//Diminuindo o tempo de persegue
			if (t_persegue > 0) t_persegue--;
			
			//Escolhendo um ponto aleatório da room
			//Checando se eu ainda não tenho destino
			//Só escolho um destino se eu ainda não tenho um
			//Quando ele chegar no destino, eu escolho outro destino
			
			//Checar a minha distancia para o destino
			var _dist = point_distance(x, y, destino_x, destino_y);
			
			if (destino_x == 0 or destino_y == 0 or _dist < max_vel * 2)
			{
				destino_x = random_range(0, room_width);
				destino_y = random_range(0, room_height);
			}
			
			//Andando em direção ao destino
			//Descobrindo a direção que eu devo ir
			var _dir = point_direction(x, y, destino_x, destino_y);
			
			
			
			//Dando o valor do meu velh 
			velh = lengthdir_x(max_vel, _dir);
			velv = lengthdir_y(max_vel, _dir);
			
			//Se eu bati em uma parede, eu paro
			if (place_meeting(x + velh, y + velv, obj_chao))
			{
				estado = "parado";
				destino_x = 0;
				destino_y = 0;
				tempo = tempo_estado;
				
			}
			
			//Regra para mudar de estado
			if (tempo <= 0)
			{
				tempo = tempo_estado;
				estado = choose("parado", "andando", "andando");
				
				//Resetando o meu destino
				destino_x = 0;
				destino_y = 0;
			}
			//Regra para ir no estado de persegue
			//Só posso perseguir o player SE meu tempo de espera acabou
			olhando();
		break;
		
		
		#endregion
	
		#region persegue
		case "persegue":
		
		
		
		//Uma cor diferente
		image_blend = c_orange;
		image_speed = 12 / room_speed;
		
		//Indo na direção do player
		if (alvo)
		{
			destino_x = alvo.x;
			destino_y = alvo.y;
		}
		else
		{
			//Vou para outro estado
			estado = choose("parado", "parado", "andando");
			destino_x = 0;
			destino_y = 0;
			tempo = tempo_estado;
		}
		
		var _dir = point_direction(x, y, destino_x, destino_y);
		velh = lengthdir_x(max_vel, _dir);
		velv = lengthdir_y(max_vel, _dir);
		
		//Regra para deixar de seguir o player
		var _dist = point_distance(x, y, destino_x, destino_y);
		
		//Player saiu do meu campo de visão + 50 pixels
		if (_dist > campo_visao * 1.5 )
		{
			alvo = noone;
			tempo = tempo_estado;
			destino_x = 0;
			destino_y = 0;
		
		
		}
		
		//Checando se eu estou muito proximo do player
		if (_dist < campo_visao / 2)
		{
			estado = "carrega_ataque";
			
			tempo = tempo_estado;
		
		
		}
		
		break;
		#endregion
		
		#region carrega_ataque
		case "carrega_ataque":
			
		
			t_ataque--;
			velh = 0;
			velv = 0;
			
			var _green = (t_ataque / tempo_ataque) * 115;
			var _blue = (t_ataque / tempo_ataque) * 96;
			
			//Alterando o image_blend
			image_blend = make_color_rgb(255, _green, _blue) ;
			if (t_ataque <= 0)
			{
				estado = "ataque";
				t_ataque = tempo_ataque;
			}
		
		
		break;
		#endregion
		
		
		#region ataque
		case "ataque":
		
			aplica_dano_player();
			
			//Ficando vermelho
			image_blend = c_red;
			
			//Ataquei o player, eu reseto o t_persegue
			//Dessa forma eu preciso esperar um tempo para perseguir o player e ficar de boa
			t_persegue = tempo_persegue
			
			//Ficando mais rapido
			var _dir = point_direction(x, y, destino_x, destino_y);
			
			velh = lengthdir_x(max_vel * 3, _dir);
			velv = lengthdir_y(max_vel * 3, _dir);
			
			//Se eu cheguei no meu destino, eu fico de boa
			var _dist = point_distance(x, y, destino_x, destino_y);
			if (_dist < 16)
			{
				estado = "parado";
			}
		
		
		break;
		#endregion
	
	#region dano
	case "dano":
		if (barra_fogo <= 0)
		{
			timer_dano--;
			timer_pisca--;
			velh = 0;
			velv = 0;
		
		
			//Checando se eu devo aplicar o dano
			if (dano > 0)
			{
				timer_pisca = tempo_pisca;
				vida_atual -= dano;
				dano = 0;
			
			}
		
			//Sendo empurrado
			velh  = lengthdir_x(1, dano_dir);
			velv = lengthdir_y(1, dano_dir);
		
		
			if (timer_dano <= 0)
			{
			
				timer_dano = tempo_dano;
			
				if (vida_atual <= 0)
				{
					estado = "morte";	
				
				
				}
				else
				{
					estado = "parado";	
				
				}
			}
		}
		
		break;
	#endregion
	
	
	#region Morte
	case "morte":
		velh = 0;
		velv = 0;
		image_speed = 0;
		//Se eu ainda estou visivel
		if (image_alpha > 0)
		{
			image_alpha -= .01;
			
		}
		else //Eu já sumi
		{
			instance_destroy();
			
		}
	
		break;
		#endregion
	
	
	case "bobao":
		
		velh = 0;
		velv = 0;
		image_speed = 6 / room_speed;
		
		break;
	
	}
	
	
}
	