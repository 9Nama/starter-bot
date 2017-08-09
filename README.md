# Starter-Bot 🤖

Ola eu sou o bot inicial para quem esta aprendendo N.A.I.L, o framework de chat-bots da [nama.ai](http://www.nama.ai), para começar precisamos de algumas coisinhas:

-- Ruby 2.2.2

Clone este projeto e siga os passos abaixo:

- Renomeie o arquivo .env-default para .env e substitua pelas suas configurações (se você não tem acesso ao beta e as keys, peça o seu [aqui](http://www.nama.ai/beta) )

-  Execute a instalação do bundler e das dependências do projeto:

```
$ gem install bundler
$ bundle install
```
### Conteúdo de exemplo:
nesse bot encontramos 2 intenções, 2 fluxos aiml e um fluxo default, alem de uma entidade e uma associação intenção com entidade.

DISCLAIMER: este bot é para ser usado como exemplo inicial na aula de introdução a N.A.I.L, caso queira participar do beta ou participar de uma dessas aulas por favor entre em contato em hi@nama.ai

### Comandos básicos:

- preparar zip do bot e enviar para a pasta compartilhada 
```
$ bundle exec ruby scripts/zip_bot.rb prepare
```
- atualizar intenções e preparar treinamento
```
$ bundle exec ruby scripts/intent_manager.rb update_and_train
```
- atualizar e associar as entidades
```
$ bundle exec ruby scripts/entities_manager.rb update_and_associate
```
### Ferramentas de debug:

- debugar intenções
```
$ bundle exec ruby scripts/intent_manager.rb predict
> im.predict "texto a ser testado"
```
- debugar entidades
```
$ bundle exec ruby scripts/entities_manager.rb parse INTENT_ASSOCIADA "TEXTO A SER TESTADO"
```
