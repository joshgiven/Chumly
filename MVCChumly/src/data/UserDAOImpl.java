package data;

import java.util.ArrayList;
import java.util.List;
import java.util.function.Predicate;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import entities.Availability;
import entities.Interest;
import entities.InterestCategory;
import entities.Location;
import entities.Profile;
import entities.User;
import entities.User.Role;

@Transactional
@Repository
public class UserDAOImpl implements UserDAO {

	@PersistenceContext
	private EntityManager em;

	public UserDAOImpl () { }

	@Override
	public User show(int id) {
		User user = em.find(User.class, id);
		return user;
	}

	@Override
	public User create(User user) {
		
		user.setProfile(new Profile());
		user.getProfile().setDescription("  ");
		user.getProfile().setFirstName("  ");
		user.getProfile().setLastName("  ");
		user.getProfile().setImageURL("  ");
		user.getProfile().setLocation(null);
		
		em.persist(user);
		em.flush();
		return user;
	}

	@Override
	public User updateUser(int id, User user) {
		User u = em.find(User.class, id);

		u.setEmail(user.getEmail());
		u.setPassword(user.getPassword());

		return u;
	}

	@Override
	public User updateConnection(int id, User user) {

		User u = em.find(User.class, id);
		u.setConnections(user.getConnections());

		return u;
	}

	@Override
	public User updateInterest(int id, User user) {

		User u = em.find(User.class, id);
		u.setInterests(user.getInterests());

		return u;
	}

	@Override
	public User updateUserProfile(int id, User user) {
		User u = em.find(User.class, id);
		u.setProfile(user.getProfile());
		return u;
	}

	@Override
	public User updateUserProfileDescription(String description, Integer id) {
		User user = em.find(User.class, id);
		user.getProfile().setDescription(description);
		return user;
	}

	@Override
	public boolean destroy(int id) {
		User user = em.find(User.class, id);
		try {
			em.remove(user);
			em.flush();
			return true;
		} catch (Exception e) {
			return false;

		}
	}

	@Override
	public List<User> index() {
		List<User> results = null;
		try {
			String queryString = "SELECT u FROM User u";
			results = em.createQuery(queryString, User.class).getResultList();
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}
		return results;
	}

	@Override
	public List<User> indexByRole(Role role) {
		List<User> results = null;
		try {
			String queryString = "SELECT u FROM User u WHERE u.role = :role";
			results = em.createQuery(queryString, User.class).setParameter("role", role).getResultList();
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}
		return results;
	}

	@Override
	public List<User> indexByLocation(Location location) {
		List<User> results = null;
		try {
			String queryString = "SELECT u " + "FROM User u "
					+ "WHERE u.profile.location.city = :city AND u.profile.location.state = :state";

			results = em.createQuery(queryString, User.class)
					.setParameter("city", location.getCity()).setParameter("state", location.getState())
					.getResultList();

		} catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}
		return results;
	}


	@Override
	public List<User> indexByInterestId(int id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> indexByInterest(Interest interest) {
		// TODO Auto-generated method stub
		return null;
	}

	
	@Override
	public List<User> indexByInterest(String interestName) {
		// List<User> results = interest.getUsers();
		// return results;

		List<User> results = null;
		try {
//			String queryString = 
//					"SELECT i " +
//			        "FROM Interest i JOIN FETCH i.users " +
//					"WHERE i.name = :name";
//			
//			Interest i = em.createQuery(queryString, Interest.class)
//			               .setParameter("name", interestName)
//			               .getSingleResult();
//			
//			results = i.getUsers();
			
			String queryString = 
					"SELECT u " +
			        "FROM User u JOIN u.interests i " +
					"WHERE i.name = :name";
			
			results = em.createQuery(queryString, User.class)
			            .setParameter("name", interestName)
			            .getResultList();
			
			//results = i.getUsers();
			
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}
		return results;
	}

	// ICEBOXED
	@Override
	public List<User> indexByInterestCategory(InterestCategory category) {
		List<User> results = null;

		if(category == null || category.getId() < 1)
			throw new IllegalArgumentException();

		try {

			String queryString =
					"SELECT u "+
			        "FROM User u JOIN u.interests i "+
			        "WHERE i.category.id = :id";

			results = em.createQuery(queryString, User.class)
			            .setParameter("id", category.getId())
			            .getResultList();

		}
		catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}

		return results;
	}

	@Override
	public List<User> indexByAvailability(Availability availability) {
		List<User> results = null;
		try {
			String queryString = "SELECT u FROM User u JOIN u.availabilities a " + "WHERE a.dayOfWeek = :day ";
			if (availability.isFreeAM()) {
				queryString += "AND a.am = true ";
			}
			if (availability.isFreePM()) {
				queryString += "AND a.pm = true ";
			}
			results = em.createQuery(queryString, User.class).setParameter("day", availability.getDayOfWeek())
					.getResultList();

		} catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}
		return results;

	}

	@Override
	public List<User> indexBy(Predicate<User> filter) {
		List<User> results = new ArrayList<>();
		for (User user : index()) {
			if (filter.test(user)) {
				results.add(user);
			}
		}
		return results;
	}

	// ICEBOXED suggested connections
	@Override
	public List<Availability> commonAvailability(User user, User other) {
		// TODO Auto-generated method stub
		return null;
	}

	// ICEBOXED suggested connections
	@Override
	public List<Interest> commonInterests(User user, User other) {
		// TODO Auto-generated method stub
		return null;
	}

	// ICEBOXED suggested connections
	@Override
	public List<InterestCategory> commonInterestCategories(User user, User other) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> indexByConnection(User connection) {
		List<User> results = null;
		try {
			String queryString = "SELECT u.connections FROM User u JOIN u.connections WHERE u.id = :id";
			results = em.createQuery(queryString, User.class).setParameter("id", connection.getId()).getResultList();
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return results;
		}
		return results;
	}

	public User getUserByUsername(String username) {
		User result = null;
		try {
			String queryString = "SELECT u FROM User u WHERE u.username = :username";
			result = em.createQuery(queryString, User.class).setParameter("username", username).getSingleResult();
		} catch (Exception e) {
			System.err.println(e.getMessage());
			return result;
		}
		return result;
	}
}
