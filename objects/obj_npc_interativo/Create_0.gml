event_inherited();
tempo_anda = 300;
timer_anda = tempo_anda;

tempo_parado = 200;
timer_parado = tempo_parado;

max_vel = 1;
destino_x = 0;
destino_y = 0;

//Variavel para mudar de sprite
mudei_sprites = false;

acao = 0; //Decidir a acao

face = 0;
quero_plantar = false;

estado = "parado"

sprites		=	[

					
					//Sprites parado
					[spr_npc1_interativo_idle_right, spr_npc1_interativo_idle_up, spr_npc1_interativo_idle_right, spr_npc1_interativo_idle_down],
					//Sprites Correndo
					[spr_npc1_interativo_walk_right, spr_npc1_interativo_walk_up, spr_npc1_interativo_walk_right, spr_npc1_interativo_walk_down],
					//Comendo
					[spr_npc1_interativo_eat_right, spr_npc1_interativo_eat_up, spr_npc1_interativo_eat_right, spr_npc1_interativo_eat_down],
					//Machado
					[spr_npc1_interativo_regando_right, spr_npc1_interativo_regando_up, spr_npc1_interativo_regando_right, spr_npc1_interativo_regando_down],
					//Lendo
					[spr_npc1_interativo_ready_right, spr_npc1_interativo_ready_right, spr_npc1_interativo_ready_right, spr_npc1_interativo_ready_down]
					//Dano
					//[spr_player_hurt_right, spr_player_hurt_up, spr_player_hurt_right, spr_player_hurt_down]
					];

//controla_sprite = function()
//{
	//var _dir = point_direction(0, 0, velh, velv);
	//
	////Se estou indo para a direita, eu olho para a direita
	////Direita
	//var _face = _dir div 90;
	////show_debug_message(_face);
	//switch(_face)
	//{
		//case 0:
		//{
			//sprite_index = sprites[0];
			 //image_xscale = 1;
			//break;
		//}
		//case 1:
		//{
			//sprite_index = sprites[1];
			//break;
		//}
		//case 2: sprite_index = sprites[2]; image_xscale = -1; break;
		//case 3: sprite_index = sprites[3]; break;
		//
	//}
	////Cima
	////Esquerda
	////Baixo
	//
//}

controla_sprite = function()
{
	// Só atualiza a direção se estiver se movendo
	if (velh != 0 or velv != 0)
	{
		var _dir = point_direction(0, 0, velh, velv);
		face = ((_dir + 45) mod 360) div 90; // 0 dir, 1 cima, 2 esq, 3 baixo
	}

	sprite_index = sprites[acao][face];
	image_xscale = (face == 2) ? -1 : 1;
}

controla_estado = function()
{
	
	var _comida = place_meeting(x, y, obj_plantacao);
	//Controlando os estados do inimigo
	switch(estado)
	{
		case "parado":
	       
            image_speed = 6 / room_speed;
    	image_blend = c_white;
    	velh = 0;
    	velv = 0;
    	timer_parado--;
    
    	if (!mudei_sprites)
    	{
    		acao = choose(0, 2, 4);
    		mudei_sprites = true;
            image_index = 0;
    	}
    
    	if (timer_parado < 0)
    	{
    		estado = choose("parado", "andando");
            //Definindo a chance dela regar
            quero_plantar = choose(false, false, true);
            
    		timer_parado = tempo_parado;
    		timer_anda = tempo_anda;
    		mudei_sprites = false;
            image_index = 0;
    	}
    break;
    
    case "andando":
    	acao = 1;
        
        
    	timer_anda--;
    	image_blend = c_white;
    	image_speed = 14 / room_speed;
    
    	var _dist = point_distance(x, y, destino_x, destino_y);
    	if (destino_x == 0 or destino_y == 0 or _dist < max_vel * 2)
    	{
    		destino_x = random_range(0, room_width);
    		destino_y = random_range(0, room_height);
    	}
    
    	var _dir = point_direction(x, y, destino_x, destino_y);
    	velh = lengthdir_x(max_vel, _dir);
    	velv = lengthdir_y(max_vel, _dir);
    
    	// Bateu na parede
    	if (place_meeting(x + velh, y + velv, obj_chao))
    	{
    		estado = "parado";
            quero_plantar = choose(false, false, true);
    		destino_x = 0;
    		destino_y = 0;
    		timer_parado = tempo_parado;
    		mudei_sprites = false;
            image_index = 0;
    	}
    
    	// Acabou o tempo de andar
    	if (timer_anda <= 0)
    	{
    		estado = "parado";
    		timer_anda = tempo_anda;
    		timer_parado = tempo_parado;
    		destino_x = 0;
    		destino_y = 0;
    		mudei_sprites = false;
            image_index = 0;
    	}
        
        if (_comida && quero_plantar)
        {
            estado = "plantacao";
    		timer_anda = tempo_anda;
    		timer_parado = tempo_parado;
    		destino_x = 0;
    		destino_y = 0;
    		mudei_sprites = false;
            image_index = 0;
            velh = 0;
            velv = 0;
        }
    break;
    	

    case "plantacao":
        acao = 3;
        velh = 0;
        velh = 0;
        if (image_index >= image_number-1)
        {
            estado = "parado";
            
            
        }
        
        break;
    }
}
	