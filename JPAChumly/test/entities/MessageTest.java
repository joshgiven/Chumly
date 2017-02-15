package entities;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.sql.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class MessageTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private Message message = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		message = em.find(Message.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		message = null;
	}
	
	@Test
	public void test_message_mapping() {
		int id = 1;
		Message msg = em.find(Message.class, id);
		
		assertNotNull(msg);
		assertEquals(1, msg.getId());
		assertEquals("first test message", msg.getText());
		
		Date ts = msg.getTimeStamp();
//		assertNotNull(ts);
//		assertNotNull("", ts.toString());

		User sender = msg.getSender();
		assertNotNull(sender);
		assertEquals("Geoff", sender.getUsername());
		
	}

	@Test
	public void test_recipients_mapping() {
		int id = 1;
		Message msg = em.find(Message.class, id);
		assertNotNull(msg);

		List<User> recips = msg.getRecipients();
		//List<User> recips = null;
		assertNotNull(recips);
		assertEquals(1, recips.size());
		
		User recip = recips.get(0);
		assertNotNull(recip);
		assertEquals("Matt", recip.getUsername());

	}
	

	
}
