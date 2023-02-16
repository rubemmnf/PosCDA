from itertools import cycle
from heronpy.api.spout.spout import Spout
import time

class ArraySpout(Spout):
    outputs = ['nome']

   
    def initialize(self, config, context):
        self.dados = cycle(["Helder Andrade", "Thiago Almeida", "Monique Fonseca", "Dayvson Silva", "Janine Loureiro",
	                  "Hugo Correia", "Eduardo Oliveira", "Saulo Pereira", "Pablo Arcelino", "Lucember Pedrosa", 
	                  "Ana Santos", "Felipe Monteiro", "Renata Santos","Augusto Cesar", "Tarsis Siqueira", "Humberto Felipe",
	                  "Andrey Peres", "Matheus Henrique", "Arimateia Junior", "Rubem Novellino"
	                  ])

    def next_tuple(self):
        time.sleep(2)
        nome_q_vamos_enviar = next(self.dados)
        self.emit([nome_q_vamos_enviar])
