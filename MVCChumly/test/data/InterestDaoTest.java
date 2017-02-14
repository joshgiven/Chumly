package data;

import static org.junit.Assert.fail;

import java.util.List;
import java.util.function.Predicate;

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

import entities.Location;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "../WEB-INF/Test-context.xml" })
@WebAppConfiguration
@Transactional
public class InterestDaoTest {

	@Autowired
	private WebApplicationContext wac;

	//@Autowired
	private InterestDAO dao = null;

	@PersistenceContext
	private EntityManager em;

	@Before
	public void setUp() {
		dao = (InterestDAO)wac.getBean("idao");
	}

	@After
	public void tearDown() {
		dao = null;
		em = null;
		wac = null;
	}
	
	@Test
	public void test_show() {
//		User user = dao.show(2);
//		assertNotNull(user);
//		assertEquals("wryan", user.getUsername());
//		
//		Profile profile = user.getProfile();
//		assertNotNull(profile);
//		assertEquals("William", profile.getFirstName());
	}
	
	@Test
	public void test_destroy() {
//		User user = dao.show(2);
//		assertNotNull(user);
//		assertEquals("wryan", user.getUsername());
//		
//		dao.destroy(2);
//		user = dao.show(2);
//		assertNull(user);
	}

	@Test
	public void test_update() {
		fail("Not yet implemented");
	}
	
	@Test
	public void test_create() {
		fail("Not yet implemented");
	}
		
	 @Test
	 public void test_index() {
		 fail("Not yet implemented");
	 }
	 
	@Test
	public void test_indexByPredicate() {
		fail("Not yet implemented");
	}

}
