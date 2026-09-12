//Iniciando variaveis

//Criando a base do meu dialogo
dialogo =
{
	texto : ["Testado 123 hahahaahahah testado 123 hahaha", "Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega, Bixin, da o rabo, na esquina e na adega"],
	retrato	: [spr_retrato_npc, spr_retrato_player],
	voz : [sound_npc1],
	txt_vel : .3,
}

larg = 30;
alt = 20;
margem = 5;

debug_aerea = function()
{
	var _y = bbox_bottom + margem;
	draw_rectangle(x - larg / 2, _y, x + larg / 2, _y + alt, true);
	
	
}

//Area do dialogo
dialogo_aerea = function()
{
	var _y = bbox_bottom + margem;
	var _player = collision_rectangle(x - larg /2, _y, x + larg/2, _y + alt, obj_player, 0, 1);
	//image_blend = c_white;
	//Se o player esta colidindo na area
	if (_player)
	{
		//image_blend = c_red;
		//Se eu apertar espaço ou enter
		//O player vai entrar no estado de dialogo
		if (keyboard_check_pressed(vk_space))
		{
			with(_player)
			{
				if (estado != estado_dialogo)
				{
					//Vai para o estado de dialogo
					estado = estado_indo_dialogo;
				
					//Passando quem é o npc desse dialogo
					npc_dialogo = other.id;
				}
			
			
			}
		}
		if (keyboard_check_pressed(vk_escape))
		{
			_player.estado = _player.estado_parado;
		}
	
	
	}
	
}