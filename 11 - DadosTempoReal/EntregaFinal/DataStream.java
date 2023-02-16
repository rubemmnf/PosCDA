import com.espertech.esper.client.EPRuntime;

public class DataStream extends Thread {

	String[] dados = {"Helder Andrade", "Thiago Almeida", "Monique Fonseca", "Dayvson Silva", "Janine Loureiro",
            "Hugo Correia", "Eduardo Oliveira", "Saulo Pereira", "Pablo Arcelino", "Lucember Pedrosa", 
            "Ana Santos", "Felipe Monteiro", "Renata Santos","Augusto Cesar", "Janine Loureiro", "Tarsis Siqueira", "Humberto Felipe",
            "Andrey Peres", "Matheus Henrique", "Arimateia Junior", "Rubem Novellino"
            };
	
	EPRuntime cep;
	public DataStream(EPRuntime c) {
		this.cep = c;
	}

	int indice = 0;
	int contador = 1;
	public void run() {
		while(true) {
			
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
			}
			
			String proxDado = dados[indice];
			indice = indice + 1;
			
			if(indice >= dados.length) {
				indice = 0;
			}
			
			Pessoa p = new Pessoa();
			p.setNome(proxDado);
			p.setId(contador);
			
			System.out.println("[Stream 1] Enviando " + proxDado);
			
			contador = contador + 1;
			
			
			
			//enviar o DADO para o CEP
			cep.sendEvent(p);
			
		}

	}
}
