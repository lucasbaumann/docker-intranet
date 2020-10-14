# Documentação Intranet SCI

##GERAL

 - Para achar os arquivos que devem ser alterados é baseado na url
	Cada tela tem seus 4 links, geralmente:
 	-arquivoIndex.php (Tela de listagem e filtro, a que tem o grid)
 	-arquivoForm.php (Tela de inclusão ou alteração de registro)
 	-arquivoFormDo.php, (arquivo que executa a inclusão ou alteração)
 	-arquivoDelete.php (arquivo que executa a deleção)

##Menus

 -  O menu basicamente é a leitura da tabela de menu do banco. 
Mais algumas alterações no arquivo /var/www/html/intranet/inc/funcao/html.php

 - No menu de atendimento no site da intranet dentro de suporte/atendimento tem os sistemas.
esses sistemas são inseridos por um array naquele arquivo html.php

 - Sempre depois de inserir um novo menu tem que adicionar a permissão para poder disponibilizar ele na tela.

 - A ordem como os menus são exibidos é definida pela sci.menu, dentro da tabela pelas colunas ordemShow e categioria.
Onde: OrdemShow = define a sequência de exibição (números menores são exibidos primeiro)
Categoria = define a pasta na qual o menu vai estar inserido

##Permissões

 - Para dar permissão é no menu Administrador / Grupo de usuários. 
Selecionar o tipo de grupo de usuário que tu ta usando e marca o checkbox do novo menu.


##Filtros 

 - Quando adicionar um filtro em tela tem que adicionar esse campo no arquivo /var/www/html/intranet/setFilter.php