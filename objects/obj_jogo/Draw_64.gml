//draw_text(20, 20, global.pause);

if (room != rm_inicio && !instance_exists (obj_transicao))
desenha_coracoes(20, 40);

//Desenhando o nome do equipamento atual
if (global.arma_player)
{
	//draw_text(20, 40, global.arma_player.nome)
}

//Escurecendo a tela se o jogo ta pausado
if (global.pause)
{
	desenha_pause();

    
	//Desenha_inventario
	desenha_inventario();
	
}
else
{
	//Destruindo a cama do efeito se o jogo não esta pausado
	if (layer_exists("efeito_pause"))
	{
		layer_destroy("efeito_pause");
	}
	
	
}
