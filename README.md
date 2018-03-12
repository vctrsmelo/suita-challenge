# Desafio Warren

## Dependencias
* SwiftLint
* Alamofire

## Arquitetura
Foi utilizado MVC. O model se comunica com a API, enquanto o controller transforma os dados da API em dados legíveis pelo usuário, e a view apresenta esses dados de uma maneira interativa.

Segue abaixo uma descrição básica das estruturas criadas.

## Model
### Enums

**MessageAction:** Representa uma ação, do bot, que será realizada num balão de mensagem. Pode ser a escrita de uma sentença, ou apagar o que já foi escrito. MessageActions são geradas baseada nas *messages* recebidas da API.

## Typealias
**Sentence:** É uma dupla `(waitingTime: TimeInterval, text: String)`. Representa cada frase escrita, pelo bot, em um balão de mensagem. O waitingTime é o tempo de espera antes de começar a escrever o text. Essa informação vem da API como string e é convertida em uma Sentence usando `MessageTextParser`.

### Extensions
**Array<MessageAction>:** foi criada uma extensão para obter apenas o texto das sentenças. Útil na interface para determinar o tamanho do balão de mensagem de acordo com o tamanho do texto.

### Singletons
**ChatManager:** Gerenciador do chat no nível do modelo. Responsável por manter as respostas do usuário e fazer o contato com a API. Utiliza um struct interno chamado `APICommunicator` . Ele é interno pois o ChatManager deve ser usado pra fazer a comunicação com a API, caso contrário pode haver inconsistência de estado.

**MessageTextParser:** Responsável por analisar as messages recebidas pela API e convertê-las em `MessageAction`. Interpreta os tokens de tempo (^) e de apagar mensagem (<erase>).

### APIAccess
Foi criado um conjunto de structs que adotam o protocolo `Codable`. Elas foram criadas para fazer um mapeamento 1 pra 1 com o JSON recebido da API.

### Outros
**MessagesViewManager:** É uma propriedade no `ChatViewController`. Gerencia o envio de mensagens por parte do bot. Útil para garantir que a próxima mensagem só será enviada após a última ter sido totalmente escrita. Possui um delegate, pelo qual se comunica com o `ChatViewController`.

## Controllers
**ChatViewController:** É a `ViewController` principal. Mantém arquitetura na interface para simular o chat. Chama o `ChatManager` para receber dados da API e adapta a view de acordo com os dados recebidos.

**FinishViewController:** A tela final que apresenta o resultado do perfil do usuário.

## Views
**UserInputView:** protocolo que deve ser adotado por views que servem como entrada de dados pelo usuário.

**TextUserInputView:** view para entrada de texto pelo usuário

**ButtonsUserInputView:** view com interface de botões para entrada de dados pelo usuário.

**MessageTextView:** é o balão de mensagem. Responsável por fazer o “efeito” de digitação (tanto o tempo de espera entre sentenças quanto o tempo de espera entre cada caractere).

**BotMessageView:** é a view container das mensagens enviadas pelo bot. Inclui um `MessageTextView` e um ícone. Esta é a view que será adicionada no `ChatViewController` sempre que o bot enviar uma mensagem.

**UserMessageView:** equivalente ao `BotMessageView`, mas para mensagens enviadas pelo usuário.

### Protocolos
**MessageView:** protocolo que deve ser adotado por views que servirão como mensagens. Útil para fazer implementação (através de extensions) de código que será compartilhado pelo `BotMessageView` e `UserMessageView`.

