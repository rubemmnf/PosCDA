import stomp
import time

class msg_listener(stomp.ConnectionListener):
    def on_message(self, message):
        print(message.body)
   

conexao = stomp.Connection()
conexao.connect('','', wait=True)

listenerMq = msg_listener()
conexao.set_listener('classe_msg',listenerMq)

#Headers funciona como uma filtro baseado na propriedade
#headers1 = {}
#headers1['selector'] = "idade > 40"

#conexao.subscribe(destination='/queue/DIA-NAMORADOS', id=1, ack='auto', headers=headers1)
conexao.subscribe(destination='/queue/DIA-NAMORADOS', id=1, ack='auto', headers=headers1)

time.sleep(60)
