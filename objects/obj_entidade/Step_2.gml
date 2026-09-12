////Usar as variáveis de movimento, para mover e colidir
//x += velh;
//y += velv;

ajusta_depth();

//Colisão horizontal
if (place_meeting(x + velh, y, obj_chao))
{
	//Pegando os dados do chão que eu vou bater
	var _chao = instance_place(x + velh, y, obj_chao);
	
	if (_chao)
	{
		//Checando se eu estou indo para a direita ou para a esquerda
		if (velh > 0)
		{
			//Estou indo para a direita

				//Eu vou grudar na esquerda do chao
				x = _chao.bbox_left + (x - bbox_right);
			}
		}
		else if (velv < 0) //Para a esquerda
		{
			x = _chao.bbox_right + (x - bbox_left);
		
		
		}
		//Zerar a minha velocidade horizontal
		velh = 0;
}

x += velh;

var _chao = instance_place(x, y + velv, obj_chao);

if (_chao) //Se eu colidi com o chão
{
		//Checando se eu estou descendo ou subindo
		if (velv > 0) //Descendo
		{
			y = _chao.bbox_top + (y - bbox_bottom);
		}
		else if (velv < 0)
		{
			y = _chao.bbox_bottom + (y - bbox_top);
			
		}
		velv = 0;
		
}
	
y += velv;