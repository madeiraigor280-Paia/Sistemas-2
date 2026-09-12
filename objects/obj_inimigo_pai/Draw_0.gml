//Desenhando a sombra
//No 0 eu quero a escala em .5, no 1, 2 e 3 ela fica em .7
somb_scale = .5;
if (image_index > 1)
{
	var somb_scale = .7;
	
	
}


if (timer_pisca)
{	
	shader_set(sh_pisca_branco);
	draw_self();
	shader_reset();
}
else
{
	draw_self()
}


draw_text(x, y - sprite_height, vida_atual);

//Debug do meu estado
if (global.debug)
{
	draw_set_halign(1);
	draw_set_halign(1);
	draw_text(x, y - sprite_height, estado);
	draw_set_halign(-1);
	draw_set_halign(-1);
	
	//Sabendo onde é o destino dele
	draw_circle(destino_x, destino_y, 16, false);
	
	//Desenhando o meu campo de visão
	draw_circle(x, y, campo_visao, true);
}