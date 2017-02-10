package entities;

import static org.junit.Assert.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class InterestTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private Interest interest = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		interest = em.find(Interest.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		interest = null;
	}
	
	@Test
	public void test_interest_mapping() {
		Interest interest = em.find(Interest.class, 1);
		
		assertNotNull(interest);
		assertEquals("Quidditch", interest.getName());
		
		InterestCategory cat =interest.getCategory();
		assertNotNull(cat);
		assertEquals("Sports", cat.getName());
	}

}
