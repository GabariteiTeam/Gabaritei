Projeto Gabaritei
=====================


1. Apresentação

Plataforma educacional online voltada para escolas e cursinhos. Flexível e adaptável, tem como objetivo suprir
de ser utilizado em diversos ambientes, com diversas combinações de hardware e software.

2. Tecnologia utilizada

    - Ruby on Rails
    - Bootstrap
    - Capybara
    - Selenium Web Driver
    
3. Sobre os testes

    Os testes foram criados sobre a base do rake, Capybara e Selenium. Devido a algumas limitações do SQLLite, tivemos que criar
    um novo environment chamdo "Selenium". Basicamente o que acontece é que rodar os testes usando o rake test:integration levanta
    um servidor no environment de testes padrão (acessando o banco de dados de teste). No entando, o Selenium necessita acessar uma
    url no servidor, fazendo com que nós tenhamos que subir um novo servidor usando o comando rails -s. Com dois servidores acessando
    o mesmo banco de dados, não é possível fazer com que as alterações feitas sejam gravadas efetivamente no arquivo sqlite.
    
    A solução adotada foi rodar o servidor em outro banco de dados usando outro environment. Dessa forma, toda a codificação foi
    jogada para dentro do método de inicialização do rake e é transparente ao desenvolvedor. Para rodar os testes, as gems do
    capybara e selenium web driver devem estar instaladas e o sistema deve ser Linux, Max OS X ou similar.
    
    Comandos:
    
    $ bundle install
    $ bundle exec rake test:integration
