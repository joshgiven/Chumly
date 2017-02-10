package entities;

import static org.junit.Assert.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class LocationTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private Location location = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		location = em.find(Location.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		location = null;
	}
	
	@Test
	public void test_location_mapping() {
		Location location = em.find(Location.class, 1);
		
		assertNotNull(location);
		assertEquals("Chicago", location.getCity());
		assertEquals("IL", location.getState());
	}

}
