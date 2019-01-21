# Suitability Chat Challenge

## In English

### Challenge Goal
This challenge was developed to create all the suitability flow presented in Warren Brasil app (https://itunes.apple.com/br/app/warren-brasil/id1114394063?mt=8). 

When developing this challenge, I had no idea about how this flow was implemented.

### Dependencies
* SwiftLint
* Alamofire

### Architecture
It was used MVC. The model communicates with API, while controller converts API data into user's legible data, and the view presents these data in an interactive way.

It follows a basic description of the structures created.

### Model
#### Enums

**MessageAction:** Represents a bot action that will be made in a message balloon. This action can be the written or deletion of a sentence. MessageActions are created based at *messages* received from API.

### Typealias
**Sentence:** It's a pair `(waitingTime: TimeInterval, text: String)`. It represents each sentence written, by the bot, in a message balloon. The waitingTime is the waiting time before starting to write the text. These information comes from API as string and it is converted into a sentence using `MessageTextParser`.

#### Extensions
**Array<MessageAction>:** It was created an extension to obtain only the sentence texts. It is useful in UI to define the size of message balloon according to the text length.

#### Singletons
**ChatManager:** It is the model level manager. It's responsibilities include keeping the user's answer and communicate with API. It uses an internal struct called `APICommunicator`. This struct is internal because only ChatManager should be used to communicate, otherwise state inconsistence problems may occur.

**MessageTextParser:** Responsible for analysing the messages received from API and convert them into `MessageAction`. It reads the time (^) and erase message (<erase>) string tokens.

#### APIAccess
It was created a set of structs adopting the `Codable` protocol. They were created thinking about mapping 1 to 1 with the JSON received from API.

#### Others
**MessagesViewManager:** It is a property in `ChatViewController`. It manages the messages sent by bot. It is useful to guarantee that next message will only be sent after the last one has been totally displayed. It has a delegate used for  communication with `ChatViewController`.

### Controllers
**ChatViewController:** It is the main `ViewController`. It keeps the architecture in UI to simulate a chat. It calls the `ChatManager` to receive API data and adapts it's view according to the data received.

**FinishViewController:** This is the end view that presents the user's profile, defined according to it's answers.

### Views
**UserInputView:** Protocol that must be adopted by views that handle users data input.

**TextUserInputView:** View for user text input.

**ButtonsUserInputView:** View with buttons interface for user input.

**MessageTextView:** This is the message balloon. It handles the typing effect (both the waiting time between sentences and between characters).

**BotMessageView:** It is the container view for messages sent by bot. It includes a `MessageTextView` and an icon. This is the view to be added into `ChatViewController` always when the bot sends a message.

**UserMessageView:** Equivalent to `BotMessageView`, but for messages sent by user.

### Protocolos
**MessageView:** Protocol to be adopted by views that serve as messages. Useful to implement (using extensions) the shared code between `BotMessageView` and `UserMessageView`.

## In Portuguese

### Dependências
* SwiftLint
* Alamofire

### Arquitetura
Foi utilizado MVC. O model se comunica com a API, enquanto o controller transforma os dados da API em dados legíveis pelo usuário, e a view apresenta esses dados de uma maneira interativa.

Segue abaixo uma descrição básica das estruturas criadas.

### Model
#### Enums

**MessageAction:** Representa uma ação, do bot, que será realizada num balão de mensagem. Pode ser a escrita de uma sentença, ou apagar o que já foi escrito. MessageActions são geradas baseada nas *messages* recebidas da API.

### Typealias
**Sentence:** É uma dupla `(waitingTime: TimeInterval, text: String)`. Representa cada frase escrita, pelo bot, em um balão de mensagem. O waitingTime é o tempo de espera antes de começar a escrever o text. Essa informação vem da API como string e é convertida em uma Sentence usando `MessageTextParser`.

#### Extensions
**Array<MessageAction>:** foi criada uma extensão para obter apenas o texto das sentenças. Útil na interface para determinar o tamanho do balão de mensagem de acordo com o tamanho do texto.

#### Singletons
**ChatManager:** Gerenciador do chat no nível do modelo. Responsável por manter as respostas do usuário e fazer o contato com a API. Utiliza um struct interno chamado `APICommunicator` . Ele é interno pois o ChatManager deve ser usado pra fazer a comunicação com a API, caso contrário pode haver inconsistência de estado.

**MessageTextParser:** Responsável por analisar as messages recebidas pela API e convertê-las em `MessageAction`. Interpreta os tokens de tempo (^) e de apagar mensagem (<erase>).

#### APIAccess
Foi criado um conjunto de structs que adotam o protocolo `Codable`. Elas foram criadas para fazer um mapeamento 1 pra 1 com o JSON recebido da API.

#### Outros
**MessagesViewManager:** É uma propriedade no `ChatViewController`. Gerencia o envio de mensagens por parte do bot. Útil para garantir que a próxima mensagem só será enviada após a última ter sido totalmente escrita. Possui um delegate, pelo qual se comunica com o `ChatViewController`.

### Controllers
**ChatViewController:** É a `ViewController` principal. Mantém arquitetura na interface para simular o chat. Chama o `ChatManager` para receber dados da API e adapta a view de acordo com os dados recebidos.

**FinishViewController:** A tela final que apresenta o resultado do perfil do usuário.

### Views
**UserInputView:** protocolo que deve ser adotado por views que servem como entrada de dados pelo usuário.

**TextUserInputView:** view para entrada de texto pelo usuário

**ButtonsUserInputView:** view com interface de botões para entrada de dados pelo usuário.

**MessageTextView:** é o balão de mensagem. Responsável por fazer o “efeito” de digitação (tanto o tempo de espera entre sentenças quanto o tempo de espera entre cada caractere).

**BotMessageView:** é a view container das mensagens enviadas pelo bot. Inclui um `MessageTextView` e um ícone. Esta é a view que será adicionada no `ChatViewController` sempre que o bot enviar uma mensagem.

**UserMessageView:** equivalente ao `BotMessageView`, mas para mensagens enviadas pelo usuário.

### Protocolos
**MessageView:** protocolo que deve ser adotado por views que servirão como mensagens. Útil para fazer implementação (através de extensions) de código que será compartilhado pelo `BotMessageView` e `UserMessageView`.

