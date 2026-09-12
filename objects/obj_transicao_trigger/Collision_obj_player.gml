//Se eu ainda não criei o objeto transicao
//Eu crio ele
if (!transicao)
{
	//Destruindo a transição se alguma outra já existir
	//Pode ter alguns erros
	if (instance_exists(obj_transicao)) instance_destroy(obj_transicao);
	
	transicao = instance_create_depth(other.x, other.y, -10000, obj_transicao);
	transicao.room_destino = room_destino;
	transicao.destino_x = destino_x;
	transicao.destino_y = destino_y;
	transicao.player = other;
	
}

