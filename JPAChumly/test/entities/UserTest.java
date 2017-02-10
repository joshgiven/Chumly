package entities;

import static org.junit.Assert.*;

import java.sql.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class UserTest {
	private EntityManagerFactory emf = null;
	private EntityManager em = null;
	private User user = null;

	@Before
	public void setUp() throws Exception {
		emf = Persistence.createEntityManagerFactory("JPAChumly");
		em = emf.createEntityManager();

		user = em.find(User.class, 1);
	}

	@After
	public void tearDown() throws Exception {
		if (em != null)
			em.close();
		if (em != null)
			emf.close();
		
		user = null;
	}
	
	@Test
	public void test_user_mapping() {
		int id = 1;
		User user = em.find(User.class, id);
		
		assertNotNull(user);
		assertEquals(1, user.getId());
		assertEquals(User.Role.USER, user.getRole());
		assertEquals("Geoff", user.getUsername());
		assertEquals("Geoff", user.getPassword());
		assertEquals("ggg@Gmail.com", user.getEmail());
		
		Profile p = user.getProfile();
		assertNotNull(p);
		assertNotNull("Geoff", p.getFirstName());

	}

	
//	private List<User> connections;
//	private List<Group> groups;
//	private List<Interest> interests;
//	private List<Availability> availabilities;

	@Test
	public void test_interests_mapping() {
		int id = 1;
		User user = em.find(User.class, id);
		assertNotNull(user);

		List<Interest> interests = null;
		//List<Interest> interests = user.getInterests();
		assertNotNull(interests);
		assertEquals(2, interests.size());
		
		Interest i = interests.get(0);
		assertNotNull(i);
		assertEquals("Quidditch", i.getName());

	}
	
	@Test
	public void test_availabilities_mapping() {
		fail();
	}
	
	@Test
	public void test_connections_mapping() {
		fail();
	}
	
	@Test
	public void test_groups_mapping() {
		fail();
	}


	
}
