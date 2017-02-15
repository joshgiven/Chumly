package mock;

import java.util.Scanner;
import java.util.function.Function;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.User;

public class ConnectionTest {

	public static void main(String[] args) {
		persist( (em) -> {
			User u1 = null;
			User u2 = null;
			
			u1 = em.find(User.class, 2);
			u2 = em.find(User.class, 3);
			
			u1.getConnections().add(u2);
			em.persist(u1);
			
			return null;
		});
		
		System.out.println("<return> to continue...");
		new Scanner(System.in).nextLine();
	
		persist( (em) -> {
			User u1 = null;
			User u2 = null;
			
			u1 = em.find(User.class, 2);
			
			//em.remove(u1.getConnections());
			em.remove(u1);
			em.flush();
			
			u2 = em.find(User.class, 3);
			if(u2 != null)
				System.out.println(u2);
			return null;
		});
		
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
			
			if (em != null) {
				emf.close();
			}
		}
		
		return retVal;
	}
	
}
