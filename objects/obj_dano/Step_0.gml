//criar a lista no meu x e y, com quem vai ser a lista, qual a lista ? nesse caso a colisões e se vai ser ordenada
var _colisoes = ds_list_create();
var _qtd = instance_place_list(x, y, obj_inimigo_pai, _colisoes, 0 );

//Checar se quem eu colidi NÃO esta na lista dos atacados
for (var i = 0; i <_qtd; i++)
{
	//Salvando o cara atual
	var _outro = _colisoes[| i];
	//Checando se o outro NÃO esta na lista de atacados
	if (ds_list_find_index(lista_atacados, _outro) == -1)
	{
		if (_outro != meu_pai)
		{
			//Adicionei ele na lista
			ds_list_add(lista_atacados, _outro);
			//Aplico o dano
			 var _dano = global.arma_player != noone ? global.arma_player.dano : 0;
			_outro.toma_dano(_dano);
			_outro.dano_dir = point_direction(x, y, _outro.x, _outro.y);
			
		}
	}
	
}


/*
//Aplicando o dano SE eu acertei alguém
if (_qtd)
{
	for (var i = 0; i < _qtd; i++)
	{
		var _outro = _colisoes[| i]
		_outro.toma_dano();
		//_colisoes[| i].knockback(x, y);
		_outro.dano_dir = point_direction(x, y, _outro.x, _outro.y);
		
	}
	
}

*/
//Destruindo a estrutura de dados
ds_list_destroy(_colisoes);