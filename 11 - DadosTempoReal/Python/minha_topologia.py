from components.array_spout import ArraySpout
from components.count_bolt import CountBolt

from heronpy.api.topology import TopologyBuilder
from heronpy.api.stream import Grouping

if __name__ == "__main__":
   builder = TopologyBuilder("Topologia_Dados_2020_1")
   meu_spout = builder.add_spout("array_spout", ArraySpout, par=1)   
   meu_bolt = builder.add_bolt("count_bolt", CountBolt,par=1, inputs={meu_spout: Grouping.SHUFFLE})
   

   builder.build_and_submit()



