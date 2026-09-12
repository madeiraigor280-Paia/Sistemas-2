//Eu vou "ouvir" a sequence
var _evento = event_data[? "event_type"];

//Se eu recei qualquer broadcast da sequencia
if (_evento == "sequence event")
{
	//Salvando a mensagem
	var _mensagem = event_data[? "message"];
	//Quando a mensagem for terminei, ele muda de room
	switch(_mensagem)
	{
		case "terminei":
		
		//Mude de room
		room_goto(room_destino);
		//Destruindo a layer
		layer_destroy(lay);
	
		//Posicionando o player
		player.x = destino_x;
		player.y = destino_y;
		
		//Ativando novamente o meu alarme
		alarm[0] = room_speed / 1.5;
		
		break;
		
		case "finalizou":
		
		layer_destroy(lay)
		instance_destroy();
		
		break;
	}
	
	
	
	//Quando a mensagem for finalizou, ele se mata e limpa tudo
	
}

