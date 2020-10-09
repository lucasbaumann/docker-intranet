<?php

	$diretorioEnv = '/var/www/html/config/.env';

    $env = file_get_contents($diretorioEnv);

    if(!$env) exit('Em manutenção.');

    foreach (array_filter(explode(chr(10), $env)) as $item) putenv(trim($item));

    $_DATABASE = 'sci';

    $conexao = mysql_connect(getenv('SCI_HOST'),getenv('SCI_USER'),getenv('SCI_PASS'));

    $bd   = mysql_select_db($_DATABASE, $conexao);

    if (!$conexao)  exit('Em manutenção');
    
    unset($bd);
    
    global $conexao;
