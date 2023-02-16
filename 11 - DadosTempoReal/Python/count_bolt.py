from collections import Counter
from heronpy.api.bolt.bolt import Bolt

class CountBolt(Bolt):
    def initialize(self, config, context):
       self.counter = Counter()

    def process(self, tup):
       nome = tup.values[0]
       self.counter[nome] += 1
       self.log(nome + " - " + str(self.counter[nome]))
