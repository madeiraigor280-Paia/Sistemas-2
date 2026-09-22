if (other.vida_atual <= 0) exit;

if (other.barra_fogo > 0)
{
    other.barra_fogo -= dano_agua;
    other.barra_fogo = max(other.barra_fogo, 0);
}
else
{
    other.dano = dano_normal;
    other.estado = "dano";
}

instance_destroy();