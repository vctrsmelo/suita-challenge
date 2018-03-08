# desafio-warren-suitability
Versão do chat "Descobrindo seu Perfil" com o bot Warren.

# Bot Messages
The bot messages, received from API at each request, are kept into botMessagesList, and are sent one by one. When the last message was fully typed into screen, the MessageViewDelegate will call didFinishTyping(). Inside that method, the recently typed message is removed by botMessageList. That remove will trigger to start typing the next message, if exists.
