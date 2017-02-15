package mock;

import java.util.List;
import java.util.function.Function;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.Message;
import entities.User;

public class MockAddConnections {

	public static void main(String[] args) {
		persist( (em) -> {
//			User u1 = null;
//			User u2 = null;
//			
//			u1 = em.find(User.class, 2);
//			
//			//em.remove(u1.getConnections());
//			em.remove(u1);
//			em.flush();
//			
//			u2 = em.find(User.class, 3);
//			if(u2 != null)
//				System.out.println(u2);
			
			List<Message> messages = 
				em.createQuery("SELECT m FROM Message m", Message.class)
				  .getResultList();
			
			for(Message message : messages) {
				System.out.println("\nmsg #" + message.getId());
				
				User sender = em.find(User.class, message.getSender().getId());
				User recip = em.find(User.class, message.getRecipients().get(0).getId());
				System.out.println(sender);
				System.out.println(recip);
				
				if(!sender.getConnections().contains(recip))
					sender.getConnections().add(recip);

				if(!recip.getConnections().contains(sender))
					recip.getConnections().add(sender);
				
				em.persist(sender);
				em.persist(recip);
				em.flush();
			}
			
			return null;
		});
		
		System.out.println("bye.");
	}

	public static <R> R persist(Function<EntityManager,R> func) {
		R retVal = null;
		EntityManagerFactory emf = null;
		EntityManager em = null;

		try {
			emf = Persistence.createEntityManagerFactory("JPAChumly");
			em = emf.createEntityManager();
			em.getTransaction().begin();
			
			retVal = func.apply(em);
			
			em.getTransaction().commit();
		}
		finally {
			if (em != null) {
				if(em.getTransaction().isActive())
					em.getTransaction().rollback();
				
				em.close();
			}
			
			if (emf != null) {
				emf.close();
			}
		}
		
		return retVal;
	}
	
}
