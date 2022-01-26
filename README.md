# Desafio Dev - Cross Commerce

## Descrição
O projeto apresenta uma API, que faz o processo de ETL (Extract, transform, load), ou seja, extrai dados de uma API, passando por vários endpoints, os armazena em um arquivo de texto, aplica um algoritmo de ordenação (quick sort) aos dados, e os apresenta no formato json através de uma chamada HTTP.


## Software e versões
- Phoenix installer v1.6.6
- Elixir 1.13.0 (compiled with Erlang/OTP 24)

## Como utilizar
Para iniciar o servidor local:

- Fazer instalação das dependências com ```mix deps.get```
- Criar e migrar o banco de dados com: ```mix ecto.setup```
- Para iniciar o servidor local, simplesmente digite ``` mix phx.server ```
É necessário ter um cluster do postgresql ativo (você pode consultar com o comando ``` pg_lsclusters ``` no caso de máquinas unix)
Caso o cluster esteja com status down, você pode o ativar com os comandos. 
``` 
#format is pg_ctlcluster <version> <cluster> <action>
sudo pg_ctlcluster 12 main start
#restart PostgreSQL service
sudo service postgresql restart
```
Talvez seja necessário também atualizar o seu banco de dados local, essa configuração é feita no arquivo config/dev.exs

## Rotas e exemplos
Com o servidor rodando, já podemos fazer as chamadas, no curl ou em um programa como o Postman. A porta padrão é a 4000, ou seja, nosso host vai ser: http://localhost:4000 existem duas rotas (endpoints) disponíveis:

**GET host/api/ ou GET host/api/all**
- Acessa todas as páginas disponíveis, até receber um valor vazio, ordena todos os valores e apresenta como resposta. (essa chamada pode demorar)
- Exemplo: GET http://localhost:4000/api
![image](https://user-images.githubusercontent.com/31492509/151220915-613994dd-d1c7-44e5-853a-b0350fd79a4f.png)


**GET host/api/sample/:quantidade**
- Mesma coisa da chamada descrita anteriormente, porém até onde o usuário indicar na quantidade.
- Exemplo: GET http://localhost:4000/api/sample/10 vai fazer a chamada da página 1 a 10 e retornar os 1.000 valores ordenados.
![image](https://user-images.githubusercontent.com/31492509/151221389-01d2ec70-2dca-4e08-a304-63d8df55e634.png)


## Testes
Para executar os testes, utilize o comando ```mix test```
