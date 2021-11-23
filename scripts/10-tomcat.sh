#!/bin/bash
# Autor: Robson Vaamonde
# Site: www.procedimentosemti.com.br
# Facebook: facebook.com/ProcedimentosEmTI
# Facebook: facebook.com/BoraParaPratica
# YouTube: youtube.com/BoraParaPratica
# Linkedin: https://www.linkedin.com/in/robson-vaamonde-0b029028/
# Instagram: https://www.instagram.com/procedimentoem/?hl=pt-br
# Data de criação: 19/10/2021
# Data de atualização: 24/10/2021
# Versão: 0.03
# Testado e homologado para a versão do Ubuntu Server 20.04.x LTS x64x
# Testado e homologado para a versão do Tomcat 9.0.x, OpenJDK 11.x, OpenJRE 11.x
#
# O software Tomcat, desenvolvido pela Fundação Apache, permite a execução de aplicações para 
# web. Sua principal característica técnica é estar centrada na linguagem de programação Java, 
# mais especificamente nas tecnologias de Servlets e de Java Server Pages (JSP).
#
# OpenJDK é uma implementação livre e gratuita da plataforma Java, Edição Standard. É o resultado 
# dos esforços da Comunidade Java para a evolução atemporal da linguagem. Serve como incubadora 
# de novas ideias que normalmente são implementadas no JDK comercial da Oracle para serem 
# rentabilizadas posteriormente.
#
# Site Oficial do Tomcat: http://tomcat.apache.org/
# Site Oficial do OpenJDK: https://openjdk.java.net/
#
# Arquivo de configuração dos parâmetros utilizados nesse script
source 00-parametros.sh
#
# Configuração da variável de Log utilizado nesse script
LOG=$LOGSCRIPT
#
# Verificando se o usuário é Root e se a Distribuição é >= 20.04.x 
# [ ] = teste de expressão, && = operador lógico AND, == comparação de string, exit 1 = A maioria 
# dos erros comuns na execução
clear
if [ "$USUARIO" == "0" ] && [ "$UBUNTU" == "20.04" ]
	then
		echo -e "O usuário é Root, continuando com o script..."
		echo -e "Distribuição é >= 20.04.x, continuando com o script..."
		sleep 5
	else
		echo -e "Usuário não é Root ($USUARIO) ou a Distribuição não é >= 20.04.x ($UBUNTU)"
		echo -e "Caso você não tenha executado o script com o comando: sudo -i"
		echo -e "Execute novamente o script para verificar o ambiente."
		exit 1
fi
#
# Script de instalação e configuração do Tomcat9 no GNU/Linux Ubuntu Server 20.04.x
# opção do comando echo: -e (enable interpretation of backslash escapes), \n (new line)
# opção do comando hostname: -I (all IP address)
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
# opção do comando cut: -d (delimiter), -f (fields)
echo -e "Início do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG
clear
echo
#
echo -e "Instalação e Configuração do Tomcat9 no GNU/Linux Ubuntu Server 20.04.x\n"
echo -e "Porta padrão utilizada pelo Tomcat9.: TCP 8080"
echo -e "Após a instalação do Tomcat acessar a URL: http://$(hostname -I | cut -d ' ' -f1):8080/\n"
echo -e "Aguarde, esse processo demora um pouco dependendo do seu Link de Internet...\n"
sleep 5
#
echo -e "Adicionando o Repositório Universal do Apt, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	add-apt-repository universe &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Adicionando o Repositório Multiversão do Apt, aguarde..."
	# opção do comando: &>> (redirecionar a saída padrão)
	add-apt-repository multiverse &>> $LOG
echo -e "Repositório adicionado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando as listas do Apt, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	apt update &>> $LOG
echo -e "Listas atualizadas com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando todo o sistema, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando apt: -y (yes)
	apt -y upgrade &>> $LOG
	apt -y dist-upgrade &>> $LOG
	apt -y full-upgrade &>> $LOG
echo -e "Sistema atualizado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Removendo software desnecessários, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando apt: -y (yes)
	apt -y autoremove &>> $LOG
	apt -y autoclean &>> $LOG
echo -e "Software removidos com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Iniciando a Instalação e Configurando o Servidor Web Tomcat9, aguarde...\n"
sleep 5
#
echo -e "Instalando as dependências do Tomcat9, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando apt: -y (yes)
	apt -y install openjdk-11-jdk openjdk-11-jre default-jdk &>> $LOG
echo -e "Instalação das dependências feita com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando a versão do Java instalada, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando update-java-alternatives: -l (list)
	java -version &>> $LOG
	update-java-alternatives -l &>> $LOG
echo -e "Versão verificada com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Instalando o Servidor Web Tomcat9, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando apt: -y (yes)
	apt -y install tomcat9 tomcat9-admin tomcat9-common tomcat9-docs tomcat9-examples \
	tomcat9-user &>> $LOG
echo -e "Servidor Web Tomcat9 instalado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Atualizando os arquivos de configuração do Tomcat, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando mv: -v (verbose)
	# opção do comando cp: -v (verbose)
	# opção do bloco e agrupamentos {}: (Agrupa comandos em um bloco)
	mv -v /etc/tomcat9/tomcat-users.xml /etc/tomcat9/tomcat-users.xml.old &>> $LOG
	mv -v /etc/tomcat9/server.xml /etc/tomcat9/server.xml.old &>> $LOG
	cp -v conf/{tomcat-users.xml,server.xml} /etc/tomcat9/ &>> $LOG
	#cp -v conf/{tomcat-users.xml,server.xml} /etc/tomcat9/ &>> $LOG
echo -e "Arquivos atualizados com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração tomcat-users.xml, pressione <Enter> para continuar"
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando cp: -v (verbose)
	read
	vim /etc/tomcat9/tomcat-users.xml
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Editando o arquivo de configuração server.xml, pressione <Enter> para continuar"
	# opção do comando: &>> (redirecionar de saída padrão)
	# opção do comando cp: -v (verbose)
	read
	vim /etc/tomcat9/server.xml
echo -e "Arquivo editado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Reinicializando o serviço do Tomcat9, aguarde..."
	# opção do comando: &>> (redirecionar de saída padrão)
	systemctl restart tomcat9 &>> $LOG
echo -e "Serviço reinicializado com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Verificando a porta de conexão do Tomcat9, aguarde..."
	# opção do comando lsof: -n (inhibits the conversion of network numbers to host names for 
	# network files), -P (inhibits the conversion of port numbers to port names for network files), 
	# -i (selects the listing of files any of whose Internet address matches the address specified 
	# in i), -s (alone directs lsof to display file size at all times)
	lsof -nP -iTCP:"8080" -sTCP:LISTEN
echo -e "Porta verificada com sucesso!!!, continuando com o script...\n"
sleep 5
#
echo -e "Instalação e Configuração do Tomcat9 feita com Sucesso!!!"
	# script para calcular o tempo gasto (SCRIPT MELHORADO, CORRIGIDO FALHA DE HORA:MINUTO:SEGUNDOS)
	# opção do comando date: +%T (Time)
	HORAFINAL=$(date +%T)
	# opção do comando date: -u (utc), -d (date), +%s (second since 1970)
	HORAINICIAL01=$(date -u -d "$HORAINICIAL" +"%s")
	HORAFINAL01=$(date -u -d "$HORAFINAL" +"%s")
	# opção do comando date: -u (utc), -d (date), 0 (string command), sec (force second), +%H (hour), %M (minute), %S (second), 
	TEMPO=$(date -u -d "0 $HORAFINAL01 sec - $HORAINICIAL01 sec" +"%H:%M:%S")
	# $0 (variável de ambiente do nome do comando)
	echo -e "Tempo gasto para execução do script $0: $TEMPO"
echo -e "Pressione <Enter> para concluir o processo."
# opção do comando date: + (format), %d (day), %m (month), %Y (year 1970), %H (hour 24), %M (minute 60)
echo -e "Fim do script $0 em: $(date +%d/%m/%Y-"("%H:%M")")\n" &>> $LOG
read
exit 1
