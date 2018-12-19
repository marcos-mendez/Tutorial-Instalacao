#! /bin/bash

ODOO_VERSION='11'

echo "Esse script é focado na instalação do odoo V.$ODOO_VERSION"
echo "com o foco em desenvolvimento."

echo "Atualizando cache do sistema"
sudo apt-get update

echo "Instalando git"
sudo apt-get install git -y
echo "Pacote git instalado"

echo "Instalando postgresql"
sudo apt install postgresql -y
echo "Pacote postgreql instalado"

echo "Instalando pgadmin"
sudo apt install pgadmin3 -y
echo "pgAdmin instalado"

echo "Instalando python-dev"
sudo apt install python-dev -y
echo "Pacote python-dev instalado"

echo "Instalando gcc"
sudo apt install gcc -y
echo "Pacote gcc instalado"

echo "Criando usuário postgreSQL ..."
sudo -u postgres -- psql -c "ALTER USER postgres WITH PASSWORD '123';"
sudo -u postgres -- psql -c "DROP ROLE odoo;"
sudo -u postgres -- psql -c "CREATE ROLE odoo LOGIN ENCRYPTED PASSWORD 'md5f7b7bca97b76afe46de6631ff9f7175c' NOSUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION"

echo "==== Instalando dependências Odoo ===="
sudo apt-get install --no-install-recommends python-pip -y
sudo apt-get install --no-install-recommends libxml2-dev -y
sudo apt-get install --no-install-recommends libxslt-dev -y
sudo apt-get install --no-install-recommends libsasl2-dev -y
sudo apt-get install --no-install-recommends libldap2-dev -y
sudo apt-get install --no-install-recommends libpq-dev -y
sudo apt-get install --no-install-recommends libjpeg-dev -y
sudo apt-get install --no-install-recommends nodejs -y
sudo apt-get install --no-install-recommends npm -y
sudo apt-get install node-less -y
sudo npm install -g less
sudo ln -s /usr/bin/nodejs /usr/bin/node


echo "==== Instalando dependências da Localização Brasileira ===="
sudo apt-get install --no-install-recommends python-libxml2 -y
sudo apt-get install --no-install-recommends libxmlsec1-dev -y
sudo apt-get install --no-install-recommends python-openssl -y
sudo apt-get install --no-install-recommends python-cffi -y
sudo apt-get install --no-install-recommends libxmlsec1-opensslopenssl
echo "==== Instalando dependências do WKHTMLTOX ===="
sudo apt-get install --no-install-recommends zlib1g-dev -y
sudo apt-get install --no-install-recommends fontconfig -y
sudo apt-get install --no-install-recommends libfreetype6 -y
sudo apt-get install --no-install-recommends libx11-6 -y
sudo apt-get install --no-install-recommends libxext6 -y
sudo apt-get install --no-install-recommends libxrender1 -y
sudo apt-get install --no-install-recommends libjpeg-turbo8 -y

wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.1/wkhtmltox-0.12.1_linux-trusty-amd64.deb -P ~/
sudo dpkg -i ~/wkhtmltox-0.12.1_linux-trusty-amd64.deb

echo "==== Instalação dependências pip para os módulos ===="

if [ $ODOO_VERSION == '11' ]
then
    echo "======== Caso a versão a versão seja odoo 11 ========"
    echo "============= Virtualenv 3.5 será criado ============"

    mkdir ~/odooenv35
    sudo apt install python3-pip -y
    sudo pip3 install virtualenv
    cd ~/odooenv35
    mkdir envpacks
    cd envpacks

    virtualenv -p /usr/bin/python3.5 ve
    source ve/bin/activate
    pip3 install --upgrade pip
    pip3 install --upgrade setuptools
    pip3 install Babel==1.3
    pip3 install Jinja2==2.7.3
    pip3 install Mako==1.0.1
    pip3 install MarkupSafe==0.23
    pip3 install Pillow==2.7.0
    pip3 install Python-Chart==1.39
    pip3 install PyYAML==3.11
    pip3 install Werkzeug==0.9.6
    pip3 install argparse==1.2.1
    pip3 install decorator==3.4.0
    pip3 install docutils==0.12
    pip3 install feedparser==5.1.3
    pip3 install gdata==2.0.18
    pip3 install gevent==1.0.2
    pip3 install greenlet==0.4.7
    #pip3 install jcconv==0.2.3
    #Versão que roda em python3 não está no repo oficial. Git it
    git clone https://github.com/ghyde/jcconv
    cd jcconv
    python setup.py install
    cd ..
    pip3 install lxml==3.4.1
    pip3 install mock==1.0.1
    pip3 install ofxparse==0.14
    pip3 install passlib==1.6.2
    pip3 install psutil==2.2.0
    pip3 install psycogreen==1.0
    pip3 install psycopg2==2.5.4
    pip3 install pyPdf==1.13
    pip3 install pydot==1.2.4
    pip3 install PyPDF2==1.26.0
    pip3 install pyparsing==2.0.3
    pip3 install pyserial==2.7
    pip3 install python-dateutil==2.4.0
    pip3 install python-ldap==3.0.0b4
    pip3 install python-openid==2.2.5
    pip3 install html2text==2018.1.9
    pip3 install pytz==2014.10
    pip3 install pyusb==1.0.0b2
    pip3 install qrcode==5.1
    pip3 install reportlab==3.1.44
    pip3 install requests==2.6.0
    pip3 install six==1.9.0
    pip3 install suds-jurko==0.6
    pip3 install vobject==0.9.5
    #pip3 install wsgiref==0.1.2 Already included by default(python 3)
    pip3 install XlsxWriter==0.7.7
    pip3 install xlwt==1.3.0
    pip3 install openpyxl==2.4.0-b1
    pip3 install boto==2.38.0
    pip3 install odoorpc
    #pip3 install suds_requests
    git clone https://github.com/armooo/suds_requests
    cd suds_requests/
    python setup.py install
    cd ..
    pip3 install urllib3
    #pip3 install pytrustnfe
    git clone https://github.com/danimaribeiro/PyTrustNFe
    cd PyTrustNFe/
    python setup.py install
    cd ..
    pip3 install python3-boleto
    pip3 install python3-cnab
    pip3 install wheel

fi



echo ">>> pip e seus requerimentos estão instalados. <<<"

echo "Clonando repositório oficial Odoo no GitHub. Isso pode demorar um bom tempo."
echo "Se sua internet é lenta, recomenda-se tomar um café enquanto aguarda."
git clone --depth 1 -b  $ODOO_VERSION.0 https://github.com/odoo/odoo.git ~/odoo

echo "Terminando o arquivo de configuração, quase lá."
rm ~/odoo/odoo-config
echo ""
echo "[options]" >> ~/odoo/odoo-config
echo "addons_path = addons,odoo/addons,~/odoo-brasil" >> ~/odoo/odoo-config
echo "admin_passwd = admin" >> ~/odoo/odoo-config
echo "auto_reload = False" >> ~/odoo/odoo-config
echo "csv_internal_sep = ," >> ~/odoo/odoo-config
echo "db_host = localhost" >> ~/odoo/odoo-config
echo "db_maxconn = 64" >> ~/odoo/odoo-config
echo "db_name = False" >> ~/odoo/odoo-config
echo "db_port = False" >> ~/odoo/odoo-config
echo "db_template = template0" >> ~/odoo/odoo-config
echo "db_user = odoo" >> ~/odoo/odoo-config
echo "db_password = 123" >> ~/odoo/odoo-config

echo "Clonando repositório oficial dos módulos Odoo Brasil no GitHub."
echo "Agora falta pouco."
git clone -b $ODOO_VERSION.0 https://github.com/Trust-Code/odoo-brasil.git ~/odoo-brasil

echo "==== Instalação e configuração Odoo Brasil completa ===="
echo "---- PostgreSQL ---- "
echo ">> Usuário: odoo -- Senha: 123"
echo ">> Usuário: postgres -- Senha = 123"
echo "---- Instância Odoo ----"
echo "Pasta de instalação: ~/odoo"
echo "Pasta de Addons: addons, ~/odoo/addons, ~/odoo-brasil"
echo "========================================================"
echo "A instalação está completa !"
echo "Obrigado por usar este script !!!"
echo "iniciar o sistema com os comandos"
if [ $ODOO_VERSION == '11' ]
then
    echo "source ~/odooenv35/ve/bin/activate"
    echo "cd ~/odoo"
    echo "git checkout $ODOO_VERSION.0"
    echo "./odoo-bin --config=odoo-config"
fi
