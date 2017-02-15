package data;

import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entities.Message;
import entities.User;


@Transactional
@Repository
public class MessageDAOImpl implements MessageDAO {

	@PersistenceContext
	private EntityManager em;

	
	@Override
	public Message show(int id) {
		Message message = em.find(Message.class, id);
		return message;
	}

	@Override
	public Message create(Message message) {
		
		em.persist(message);
		em.flush();
		
		return message;
	}

	@Override
	public Message update(int id, Message message) {
		
		Message m = em.find(Message.class, id);
		m.setRecipients(message.getRecipients());
		m.setSender(message.getSender());
		m.setText(message.getText());
		
		em.flush();
			
		return m;
	}

	@Override
	public boolean destroy(int id) {
		Message m = (em.find(Message.class, id));
		
		try{
			em.remove(m);
			em.flush();
			return true;
		}
		catch(Exception e){
			return false;
			
		}
	}

	@Override
	public List<Message> indexBySender(User sender) {
		List<Message> results = null;
		try {
			String queryString = "SELECT m FROM Message m WHERE m.sender.id = :sender";
			results = em.createQuery(queryString, Message.class).setParameter("sender", sender.getId()).getResultList();
		} 
		catch (Exception e) {
			e.printStackTrace(System.err);
			return results;
		}
		return results;
	}

	@Override
	public List<Message> indexByRecipient(User recipient) {
		List<Message> results = null;
		try {
			
			String queryString = 
					"SELECT m "+
					"FROM Message m JOIN FETCH m.recipients r "+
					"WHERE r.id = :recipient"
					;
			
			results = em.createQuery(queryString, Message.class)
			            .setParameter("recipient", recipient.getId())
			            .getResultList();
			
		} 
		catch (Exception e) {
			e.printStackTrace(System.err);
			return results;
		}
		return results;
	}

	@Override
	public List<Message> indexByConversation(User recipient, User sender) {
		List<Message> results = null;

		try {
			
			String queryString = 
					"SELECT m "+
			        "FROM Message m JOIN m.recipients r " +
			        "WHERE (m.sender.id = :senderId    AND r.id = :recipientId) " +
					"   OR (m.sender.id = :recipientId AND r.id = :senderId) " +
					"ORDER BY m.id";
			
			results = em.createQuery(queryString, Message.class)
			            .setParameter("senderId", sender.getId())
			            .setParameter("recipientId", recipient.getId())
			            .getResultList();
			
		} 
		catch (Exception e) {
			e.printStackTrace(System.err);
			return results;
		}
		
		return results;
	}
	
	@Override
	public List<Message> indexByDateRange(Date beginDate, Date endDate) {
		List<Message> results = null;
		try {
			
			String queryString = 
					"SELECT m "+
			        "FROM Message m "+
			        "WHERE m.timeStamp BETWEEN :begin AND :end";
			
			results = em.createQuery(queryString, Message.class)
			            .setParameter("begin", beginDate)
			            .setParameter("end", endDate)
			            .getResultList();
			
		} 
		catch (Exception e) {
			e.printStackTrace(System.err);
			return results;
		}
		
		return results;
	}

	@Override
	public List<Message> indexByContainsText(String text) {
		List<Message> results = null;
		try {
			String queryString = "SELECT m FROM Message m WHERE m.text LIKE :text";
			results = em.createQuery(queryString, Message.class).setParameter("text", ("%"+text+"%"))
					.getResultList();
		} 
		catch (Exception e) {
			e.printStackTrace(System.err);
			return results;
		}
		return results;
	}

}
