event_inherited();

if (global.pause or instance_exists(obj_transicao)) exit;


controla_sprite();
controla_estado();
muda_estado();