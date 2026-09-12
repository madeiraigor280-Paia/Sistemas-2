

room_destino = noone;
destino_x	 = 0;
destino_y	 = 0;
player		 = 0;

//Ativando o meu alarme 
alarm[0] = room_speed / 2;

//Criando a transição na posição correta
//lay			 = layer_create(depth, "transicao");
//layer_sequence_create(lay, obj_player.x, obj_player.y, sq_transicao1);

cria_sequencia = function(_sequencia)
{
	lay = layer_create(depth, "transicao");
	if (player)
	{
		layer_sequence_create(lay, player.x, player.y, _sequencia);
	}
	else
	{
		layer_sequence_create(lay, x, y, _sequencia);
		
	}
	
}

cria_sequencia(sq_transicao1)