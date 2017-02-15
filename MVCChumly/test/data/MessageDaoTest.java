package data;

import static org.junit.Assert.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import entities.Message;
import entities.User;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "../WEB-INF/Test-context.xml" })
@WebAppConfiguration
@Transactional
public class MessageDaoTest {

	@Autowired
	private WebApplicationContext wac;

	//@Autowired
	private MessageDAO dao = null;

	@PersistenceContext
	private EntityManager em;

	@Before
	public void setUp() {
		dao = (MessageDAO)wac.getBean("mdao");
	}

	@After
	public void tearDown() {
		//em.getTransaction().rollback();
		
		dao = null;
		em = null;
		wac = null;
	}
	
	@Test
	public void test_show() {
		Message message = dao.show(1);
		assertNotNull(message);
		assertEquals("telliott", message.getSender().getUsername());
		
		List<User> recips = message.getRecipients();
		assertNotNull(recips);
		
		System.out.println(message.getText().length());
		
		assertEquals(1, recips.size());
		assertEquals("mmurray", recips.get(0).getUsername());
		
		Date ts = message.getTimeStamp();
		assertNotNull(ts);
		assertEquals("2016-02-11", ts.toString());
		
		String text = message.getText();
		assertNotNull(text);
		assertEquals(162, text.length());
	}
	
	@Test
	public void test_destroy() {
		Message message = dao.show(1);
		assertNotNull(message);
		assertEquals("telliott", message.getSender().getUsername());
		
		dao.destroy(1);
		message = dao.show(1);
		assertNull(message);
	}

	@Test
	public void test_update() {
		Message message = em.find(Message.class, 1);
		assertNotNull(message);
		assertEquals("telliott", message.getSender().getUsername());
		assertNotEquals("NEW TEXT", message.getText());
		
		message.setText("NEW TEXT");
		message.setSender(em.find(User.class, 1));
		
		message = dao.update(1, message);
		assertNotNull(message);
		assertEquals(1, message.getId());
		assertEquals("admin", message.getSender().getUsername());
		assertEquals("NEW TEXT", message.getText());
		
		Message dup = new Message();
		dup.setSender(message.getSender());
		dup.setText(message.getText());
		dup.setTimeStamp(message.getTimeStamp());
		dup.setRecipients(new ArrayList<User>(message.getRecipients()));
		
		message = dao.update(2, dup);
		assertNotNull(message);
		assertEquals(2, message.getId());
		assertEquals("admin", message.getSender().getUsername());
		assertEquals("NEW TEXT", message.getText());


	}
	
	@Test
	public void test_create() {
		Message newMessage = new Message();
		
		User sender = em.find(User.class, 2);
		List<User> recipients = Arrays.asList( em.find(User.class, 3) );
		java.sql.Date timeStamp = new java.sql.Date(new java.util.Date().toInstant().getEpochSecond());
		String text = "Howdy-Doody time";
		
		newMessage.setSender(sender);
		newMessage.setRecipients(recipients);
		newMessage.setTimeStamp(timeStamp);
		newMessage.setText(text);
		
		Message message = dao.create(newMessage);
		assertNotNull(message);
		int id = message.getId();
		
		message = em.find(Message.class, id);
		assertNotNull(message);
		assertEquals(sender.getUsername(), message.getSender().getUsername());
		assertEquals(timeStamp.toString(), message.getTimeStamp().toString());
		assertEquals(text, message.getText());
		assertArrayEquals(recipients.toArray(), message.getRecipients().toArray());
	}
		
	
	/*
	 * Message show(int id);
	 * Message create(Message message);
	 * Message update(int id, Message message);
	 * boolean destroy(int id);
	 * List<Message> indexByConversation(User recipient, User sender);
	 * List<Message> indexBySender(User sender);
	 * List<Message> indexByRecipient(User recipient);
	 * List<Message> indexByDateRange(Date beginDate, Date endDate);
	 * List<Message> indexByContainsText(String text);
	 */
	
	@Test
	public void test_indexByConversation() {
		User sender = em.find(User.class, 2);
		User recip = em.find(User.class, 479);
		List<Message> messages = dao.indexByConversation(sender, recip);
		assertNotNull(messages);
		assertEquals(1, messages.size());
		
		Message message = messages.get(0);
		assertNotNull(message);
		assertEquals(2, message.getSender().getId());
		
		List<User> recips = message.getRecipients();
		assertNotNull(recips);
		assertEquals(1, recips.size());
		
		recip = recips.get(0);
		assertNotNull(recip);
		assertEquals(479, recip.getId());
		
	}
	 
	@Test
	public void test_indexBySender() {
		int id = 3;
		User user = em.find(User.class, id);
		List<Message> messages = dao.indexBySender(user);
		assertNotNull(messages);
		assertEquals(2, messages.size());
		assertTrue( messages.stream()
		                    .allMatch( m -> m.getSender().getId() == id ) );

	}

	@Test
	public void test_indexByRecipient() {
		User recip = em.find(User.class, 5);
		List<Message> messages = dao.indexByRecipient(recip);
		assertNotNull(messages);
		assertEquals(2, messages.size());
		assertTrue( messages.stream()
		                    .allMatch( m -> m.getRecipients()
		                    	                 .stream()
		                    	                 .allMatch( r -> r.getId() == 5 )) );

	}
	
	@SuppressWarnings("deprecation")
	@Test
	public void test_indexByDateRange() {
		java.sql.Date d1, d2;

		d1 = new java.sql.Date(2016, 3, 22);
		d2 = new java.sql.Date(2016, 3, 23);
		
		List<Message> messages = dao.indexByDateRange(d1, d2);
		assertNotNull(messages);
		assertEquals(6, messages.size());
		assertTrue( messages.stream()
		                    .allMatch( m -> m.getTimeStamp().toString().equals("2016-03-22") ));

	}
	
	@Test
	public void test_indexByContainsText() {
		String text = "ipsum";
		List<Message> messages = dao.indexByContainsText(text);
		
		assertNotNull(messages);
		assertEquals(202, messages.size());
		assertTrue( messages.stream()
		                    .allMatch( m -> m.getText().toLowerCase().contains(text) ) );

	}
	
}
