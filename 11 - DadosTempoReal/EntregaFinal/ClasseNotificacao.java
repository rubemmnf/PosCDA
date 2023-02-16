import com.espertech.esper.client.EventBean;
import com.espertech.esper.client.UpdateListener;

public class ClasseNotificacao implements UpdateListener {

	@Override
	public void update(EventBean[] arg0, EventBean[] arg1) {
		System.err.println("CHEGOU = " + arg0[0].getUnderlying());
		
	}

}
