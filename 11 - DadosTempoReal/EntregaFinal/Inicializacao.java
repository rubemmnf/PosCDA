import com.espertech.esper.client.Configuration;
import com.espertech.esper.client.EPAdministrator;
import com.espertech.esper.client.EPServiceProvider;
import com.espertech.esper.client.EPServiceProviderManager;
import com.espertech.esper.client.EPStatement;

public class Inicializacao {

	public static void main(String[] args) {
		try {
			
			//INICIAR CEP AQUI
			Configuration cepConfig = new Configuration();
			
			cepConfig.addEventType("Pessoa", Pessoa.class.getName());
			cepConfig.addEventType("Pessoa2", Pessoa2.class.getName());
			
			EPServiceProvider cep = EPServiceProviderManager.getProvider("myCEPEngine", cepConfig);
			
			EPAdministrator cepAdm = cep.getEPAdministrator();
			EPStatement cepStatement = cepAdm.createEPL("select * from pattern["+
					                                    "every p1=Pessoa -> p2=Pessoa2(p1.nome = nome)" +  
				                                        " where timer:within(12 seconds)]"
					                                    );	
			
			cepStatement.addListener(new ClasseNotificacao());
			
			new DataStream(cep.getEPRuntime()).start();
			new DataStream2(cep.getEPRuntime()).start();
			
		} catch (Exception e) {
			System.out.println("ERRO - " + e.getMessage());
		}
	}
}
