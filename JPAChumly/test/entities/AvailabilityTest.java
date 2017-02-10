package entities;

import static org.junit.Assert.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class AvailabilityTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private Availability availability = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		availability = em.find(Availability.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		availability = null;
	}
	
	@Test
	public void test_availability_mapping() {
		Availability a = em.find(Availability.class, 1);
		
		assertNotNull(a);
		assertEquals(Availability.DayOfWeek.MONDAY, a.getDayOfWeek());
		assertEquals(true, a.isFreeAM());
		assertEquals(true, a.isFreePM());
	}

}
