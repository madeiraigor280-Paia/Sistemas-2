

function Funcoes(){

}


///@function desenha_sombra(sprite, escala, [cor], [alpha])
function desenha_sombra(_sprite, _escala, _cor = c_white, _alpha)
{
	//Desenhando a minha sombra
	draw_sprite_ext(_sprite, 0, x, y, _escala, _escala, 0, _cor, _alpha);
	
	
}

function ajusta_depth()
{
	depth = -y;
	
	
}

///@function cria_arma
function cria_arma(_nome, _desc, _spr, _dano, _vel, _esp) constructor // Se eu personalizo eu coloco aqui
{
	//Criando o ID das armas	
	//Variavel controlar todas as armas foram criadas
	tipo = item_tipo.armas;
	static qtd_armas = 0;
	meu_id = qtd_armas++;
	//Passando primeiro o ++ antes, exemplo ++qtd_armas ele cria antes da ação, fazendo ele ficar com o numero 1
	nome = _nome;
	desc = _desc;
	spr = _spr;
	dano = _dano;
	vel = _vel;
	esp = _esp;


	
	static usa_item = function()
	{
		//Testando
		//Equipando a arma
		//Ja sabemos que arma estamos usando no global.armas
		global.arma_player = global.armas[| meu_id];
		
	}
	
	pega_item = function()
	{	
		var _cols = ds_grid_width(global.inventario);
		var _lins = ds_grid_height(global.inventario);
		//Checar se tem espaço vazio no inventário
		for (var i = 0; i < _lins; i++)
		//Andando pelas linhas do invetario
		{
			for (var j = 0; j < _cols; j++)
			{
				//Olhando se tem
				//Se o slot atual ta vazio, eu entro nele
				var _atual = global.inventario[# j, i];
				if (!_atual)
				{
					//Eu vou para este slot
					//j, i é igual o item que eu sou
					global.inventario[# j, i] = global.armas[| meu_id];
					
					//Consegui me equipar, eu aviso que deu certo
					return true
				}
				
				
			}
			
		}
		
		//Terminou o laço de repetição e eu não consegui nada
		//Eu retorno falso
		return false
		
	}
	
}

//Que informações eu preciso de um item construtivo
//A ação dele é para fazer ele não equipar a pocao, e sim usar ela
function cria_consumivel(_nome, _desc, _spr, _acao) constructor
{
	tipo	=	item_tipo.consumiveis;
	static _id		= 0;
	meu_id			= _id++;
	nome			= _nome;
	desc			= _desc;
	spr				= _spr;
	acao			= _acao;
	
	usa_item = acao;
	
	//O meu pega item static 
	//O quer dizer ? ele inicia uma vez só
	//O pega item todo item funciona de toda maneira
	static pega_item = function()
	{	
		var _cols = ds_grid_width(global.inventario);
		var _lins = ds_grid_height(global.inventario);
		//Checar se tem espaço vazio no inventário
		for (var i = 0; i < _lins; i++)
		//Andando pelas linhas do invetario
		{
			for (var j = 0; j < _cols; j++)
			{
				//Olhando se tem
				//Se o slot atual ta vazio, eu entro nele
				var _atual = global.inventario[# j, i];
				if (!_atual)
				{
					//Eu vou para este slot
					//j, i é igual o item que eu sou
					global.inventario[# j, i] = global.consumiveis[| meu_id];
					
					//Consegui me equipar, eu aviso que deu certo
					return true
				}
				
				
			}
			
		}
		
		//Terminou o laço de repetição e eu não consegui nada
		//Eu retorno falso
		return false
		
	}
	
}

enum item_tipo
{
	armas,
	consumiveis
}


enum consumiveis
{
	pocao_vermelha,
	pocao_coracao
}

//Vamos dar um jeito de nomear todas as armas
enum armas
{
	espada_madeira,
	espada_comum,
	espada_sangue
	
}

enum saves
{
	save_01,
	save_02,
	save_03
	
}

//show_message(armas.espada_madeira)

global.pause = false;

global.inventario = ds_grid_create(4, 4);
ds_grid_clear(global.inventario, 0);

function pega_sequencia(_nome)
{
		var _lay = layer_get_id(_nome);
		var _seq = layer_get_all_elements(_lay);
		
			
		//Encontrando dentro do array o elemento que é a sequence
		//Rodando pelo vetor
		for (var i = 0; i < array_length(_seq); i++)
		{
				//Checando se o elemento atual é uma sequencia
			var _atual = _seq[i];
			if (layer_get_element_type(_atual) == layerelementtype_sequence)
			{
				//Se o elemento atual for minha sequencia, eu salvo ele na 
				//Variavel sq e termino o loop
				return _atual;
			
					
			}
				
		}
	return false;
}


global.iniciou = false;

//Variável para saber qual o save do jogo
global.save = saves.save_02;


//Estrutura com os itens consumiveis
global.consumiveis = ds_list_create();

//Criando a minha lista de armas
global.armas	= ds_list_create();
global.arma_player = noone;

////Variáveis de vida do player
global.max_vida_player = 6;
global.vida_player = 6;


//Criando a minha arma
var _a = new cria_arma("Espada de madeira", "Uma espada simples feita de madeira que no maximo vai machucar um pouco",
				spr_espada2, 1, 1, ataque_especial_madeira);
var _b = new cria_arma("Espada comum", "Uma espada comum com uma lamina muito afiada", spr_espada2, 2, 1, especial_espada_comum);
var _c = new cria_arma("Espada de sangue", "Espada criada com as visceras de todos os monstros que foram executados por ela", spr_espada2, 4, .5, ataque_especial_sangue);



//Salvando as minhas armas na minha lista de armas
ds_list_add(global.armas, _a, _b, _c);

#region acoes dos consumiveis
function acao_pocao_vermelho()
{
	//Usando a poção vermelha
	
	
	global.vida_player += 2;
	//Limitando a vida do player
	global.vida_player = clamp(global.vida_player, 0, global.max_vida_player);
	//Removendo ela do invetário
	//Me procurando no inventário
}

function acao_pocao_coracao()
{
	//Aumentando a quantidade do coração
	global.max_vida_player += 2;
	
	
}

#endregion


var _a = new cria_consumivel("Poção vermelha", "Uma poção vermelha estranha, que cura 1 coração", spr_item, acao_pocao_vermelho);
var _b = new cria_consumivel("Poção de coração", "Aumenta em 1 a quantidade máxima de corações", spr_item, acao_pocao_coracao)

//Salvando os itens criados na lista
ds_list_add(global.consumiveis, _a, _b);

//Criando a função do ataque especial da espada comum
function especial_espada_comum()
{
	if (instance_exists(obj_player))
	{
		with(obj_player)
		{
				//////Criando a layer da sequência
				//var _nova_seq = sequence_get(sq_ataque_1)
			
				//////Inicio da animação (track debaix)
				//_nova_seq.tracks[0].keyframes[0].channels[0].spriteIndex = sprite;
				////Final da animação (track de cima)
				//_nova_seq.tracks[1].keyframes[0].channels[0].spriteIndex = sprites[2, face];
		
			var _nova_seq = ajusta_sprite_sequencia([sprite, sprites[2, face]], sq_ataque_1);
		
			//Criar no lugar do player, na profundidade dele
			var _layer = layer_create(depth, "ataque_especial");
			var _seq = layer_sequence_create(_layer, x, y, sq_ataque_1);
			
			//Devolvo a sequencia criada para quem chamou a função
			return _seq;
		}
	}
	
	return false;
}

//Função para ajustar as sprites na sequencia
function ajusta_sprite_sequencia(_sprites, _sequencia)
{
	//Pegando a sequencia
	var _nova_seq = sequence_get(_sequencia);
	
	//Checando o tamanho do vetor
	var _qtd = array_length(_sprites);
	
	for (var i = 0; i < _qtd; i ++)
	//Indo da track zero até a track equivalente ao tamanho do array
	{
		//Pegando o valor atual do array
		var _atual = _sprites[i];
		
		//Só vou mexer na track que tem um valor
		if (_atual)
		{
			_nova_seq.tracks[i].keyframes[0].channels[0].spriteIndex = _atual;
		}
	}
	
	//Retornando a sequencia modificada
	
	return _nova_seq;
	
}


function ataque_especial_madeira()
{
	if (instance_exists(obj_player))
	{
		with(obj_player)
		{
			//Modificando e pegando a sequencia
			
			var _nova_seq = ajusta_sprite_sequencia([sprites[2, face]], sq_ataque_2);
			
			var _layer		= layer_create(depth, "ataque_especial");
			var _seq		= layer_sequence_create(_layer, x, y, _nova_seq);
			
			//Fazendo a sequência olhar para o lado certo
			layer_sequence_xscale(_seq, xscale);
			
			//Criar o projetil
			var _tiro = instance_create_depth(x, y - sprite_height / 2, depth, obj_projetil);
			_tiro.image_speed	=	 0;
			_tiro.image_index	=	 0;
			_tiro.speed			=	 5;
			_tiro.direction		=	 face * 90;
			_tiro.image_angle	=	face  * 90 - 90;
			
			return _seq
		
		}
		
	}
	return false;
}

function ataque_especial_sangue()
{
	if (instance_exists(obj_player))
	{
		with(obj_player)
		{
			var _layer		= layer_create(-10000, "ataque_especial");
			var _seq		= layer_sequence_create(_layer, x, y, sq_ataque_3);
			
			
			
			
			return _seq;
		}
	
	
	}
	return false;	
}

function cria_screenshake()
{
	var _shake = fx_create("_filter_screenshake");
	
	//Criando a layer dele
	var _layer = layer_create(-10000, "shake");
	
	layer_set_fx(_layer, _shake);
	
}

function termina_screenshake()
{
	layer_destroy("shake");	
	
}



function ataque_nenehum()
{
	show_message("Puff");
}