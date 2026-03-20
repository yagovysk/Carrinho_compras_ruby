# Carrinho de Compras em Ruby on Rails

Projeto de estudo para praticar boas praticas de Ruby on Rails com foco em:

- modelagem de dominio (produto, carrinho, item e pedido)
- fluxo de checkout com tipos de pagamento
- Turbo/Hotwire para atualizacao da UI
- testes com Minitest
- jobs assincronos para processamento de pagamento

## Stack

- Ruby 3.1.6
- Rails 7.0.8
- SQLite3
- Turbo + Stimulus
- Tailwind CSS
- Active Job

## Funcionalidades atuais

- catalogo de produtos
- carrinho com soma de quantidades por produto
- checkout com tres tipos de pagamento:
	- Check
	- Credit card
	- Purchase order
- envio de email apos pagamento aprovado
- administracao basica de produtos, pedidos, itens e usuarios

## Melhorias aplicadas nesta iteracao

- robustez do modelo de pedido:
	- adicao do metodo add_line_items_from_cart no modelo
	- validacao e normalizacao de data de expiracao do cartao
	- validacao de campos obrigatorios por tipo de pagamento
- melhoria de resiliencia no job:
	- ChargeOrderJob passou a receber order_id em vez de objeto
	- tratamento de pedido inexistente com log seguro
- fluxo de checkout mais consistente:
	- bloqueio de criacao de pedido quando carrinho esta vazio
- correcoes de bugs visuais e de fluxo:
	- subtotal de item voltando a ser exibido no carrinho
	- remocao de logs de depuracao em controllers
	- ajuste de redirecionamento ao remover item sem carrinho associado
	- estado vazio do carrinho sem botoes invalidos
- integridade de dados:
	- validacao de nome unico e obrigatorio em usuario
	- fixtures corrigidas (enum, campos invalidos e caracteres invisiveis)

## Setup local

1. Instale Ruby 3.1.6
2. Instale dependencias:

```bash
bundle install
```

3. Prepare banco de dados:

```bash
bin/rails db:prepare
```

4. Suba a aplicacao:

```bash
bin/dev
```

Se preferir sem Procfile:

```bash
bin/rails server
```

## Testes

Execute a suite completa:

```bash
bundle exec rails test
```

Executar apenas modelos:

```bash
bundle exec rails test test/models
```

## Estrutura relevante

- app/models: regras de dominio
- app/controllers: fluxo web e parametros permitidos
- app/jobs: processamento assincrono
- app/views: interface e Turbo Stream
- test: testes e fixtures

## Observacoes de ambiente

Este projeto esta fixado em Ruby 3.1.6 no Gemfile. Se estiver com outra versao ativa, o Bundler vai bloquear instalacao/execucao.

## Proximos passos recomendados

- adicionar autenticacao/autorizacao para area administrativa
- adicionar validacao de email mais estrita
- cobrir Order#charge! com testes unitarios por tipo de pagamento
- adicionar RuboCop e pipeline de CI para padrao continuo
