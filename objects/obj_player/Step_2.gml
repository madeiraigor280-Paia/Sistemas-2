event_inherited();

////Colisão horizontal
//if (place_meeting(x + velh, y, obj_chao))
//{
//	//Pegando os dados do chão que eu vou bater
//	var _chao = instance_place(x + velh, y, obj_chao);
	
//	if (_chao)
//	{
//		//Checando se eu estou indo para a direita ou para a esquerda
//		if (velh > 0)
//		{
//			//Estou indo para a direita

//				//Eu vou grudar na esquerda do chao
//				x = _chao.bbox_left - sprite_width / 2;
//			}
//		}
//		else if (velh < 0) //Para a esquerda
//		{
//			x = _chao.bbox_right + sprite_width / 2;
		
		
//		}
//		//Zerar a minha velocidade horizontal
//		velh = 0;
//}

//x += velh;

//var _chao = instance_place(x, y + velv, obj_chao);

//if (_chao) //Se eu colidi com o chão
//{
//		//Checando se eu estou descendo ou subindo
//		if (velv > 0) //Descendo
//		{
//			y = _chao.bbox_top;
//		}
//		else if (velv < 0)
//		{
//			y = _chao.bbox_bottom + (y - bbox_top);
			
//		}
//		velv = 0;
		
//}
	
//y += velv;