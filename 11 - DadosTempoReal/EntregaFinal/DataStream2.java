import com.espertech.esper.client.EPRuntime;

public class DataStream2 extends Thread {

	String[] dados = {"Helder Andrade 2", "Thiago Almeida 2", "Monique Fonseca 2", "Dayvson Silva 2", "Janine Loureiro 2",
            "Hugo Correia 2", "Eduardo Oliveira 2", "Saulo Pereira 2", "Pablo Arcelino 2", "Lucember Pedrosa 2", 
            "Ana Santos 2", "Felipe Monteiro 2", "Renata Santos 2","Augusto Cesar 2", "Janine Loureiro 2", "Tarsis Siqueira 2", "Humberto Felipe 2",
            "Andrey Peres 2", "Matheus Henrique 2", "Arimateia Junior", "Rubem Novellino 2"
            };
	
	EPRuntime cep;
	public DataStream2(EPRuntime c) {
		this.cep = c;
	}

	int indice = 0;
	int contador = 1;
	public void run() {
		while(true) {
			
			try {
				Thread.sleep(1100);
			} catch (InterruptedException e) {
			}
			
			String proxDado = dados[indice];
			indice = indice + 1;
			
			if(indice >= dados.length) {
				indice = 0;
			}
			
			Pessoa2 p = new Pessoa2();
			p.setNome(proxDado);
			p.setId(contador);
			
			System.out.println("[Stream 2] Enviando " + proxDado);
			
			contador = contador + 1;
			
			
			
			//enviar o DADO para o CEP
			cep.sendEvent(p);
			
		}

	}
}
