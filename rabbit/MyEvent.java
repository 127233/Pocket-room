package rabbit;
/**
 * @author: rabbit
 * @Desc:
 * @create: 2023-07-21 13:02
 **/
import java.awt.event.ActionEvent;

public abstract class MyEvent {
	public abstract void invoke(ActionEvent e);
}