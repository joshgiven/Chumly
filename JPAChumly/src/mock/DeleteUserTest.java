package mock;

import java.util.List;
import java.util.Scanner;
import java.util.function.Function;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import entities.User;

public class DeleteUserTest {

	public static void main(String[] args) {
		List<User> users = 
			query( (em) -> {
				String s = 
						"SELECT u "+
				        "FROM User u";
				return em.createQuery(s, User.class)
				         .getResultList();
			});
		
		System.out.println("<return> to delete " + users.size() + " users...");
		try(Scanner kb = new Scanner(System.in)) { kb.nextLine(); }
	
		for(User user : users) {
			persist( (em) -> {
				System.out.println(user);
				User u = em.find(User.class, user.getId());
				em.remove(u);
				em.flush();
				
				return 0;
			});
		}
		
		System.out.println("bye.");
	}

	public static <R> R query(Function<EntityManager,R> func) {
		R retVal = null;
		EntityManagerFactory emf = null;
		EntityManager em = null;
		
		try {
			emf = Persistence.createEntityManagerFactory("JPAChumly");
			em = emf.createEntityManager();
//			em.getTransaction().begin();
			
			retVal = func.apply(em);
			
//			em.getTransaction().commit();
		}
		finally {
			if (em != null) {
//				if(em.getTransaction().isActive())
//					em.getTransaction().rollback();
				
				em.close();
			}
			
			if (emf != null) {
				emf.close();
			}
		}
		
		return retVal;
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
