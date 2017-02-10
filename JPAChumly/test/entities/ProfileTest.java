package entities;

import static org.junit.Assert.*;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class ProfileTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private Profile profile = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		profile = em.find(Profile.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		profile = null;
	}
	
	@Test
	public void test_location_mapping() {
		Profile profile = em.find(Profile.class, 1);
		
		assertNotNull(profile);
		
		Location location = profile.getLocation();
		assertNotNull(location);
		assertEquals("Chicago", location.getCity());
	}
	
	@Test
	public void test_profile_mappings() {
		
		Profile profile = em.find(Profile.class, 1);
		
		assertNotNull(profile);
		assertEquals("Geoff", profile.getFirstName());
		assertEquals("Edwards", profile.getLastName());
		assertEquals("I am the best", profile.getDescription());
		assertEquals("", profile.getImageURL());
	}

}
