import stomp
import time

try:
  conexao = stomp.Connection()
  conexao.connect('','', wait=True)

  conexao.send(body='TESTE', destination ='/queue/DIA-NAMORADOS', idade = 50)
  print('Enviou msg - ')
#  time.sleep(2)
  conexao.disconnect()

except Exception as e:
  print('error')


print('FIM DA EXECUCAO')
