package data;

import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

import entities.Interest;
import entities.InterestCategory;

public interface InterestDAO {
	public Interest show(int id);
	public Interest create(Interest interest);
	public Interest update(int id, Interest interest);
	public boolean destroy(int id);

	public List<Interest> index();
	public List<Interest> indexByCategory(InterestCategory InterestCategory);
	public List<Interest> indexBy(Predicate<Interest> filter);

	public Map<String, List<Interest>> mapByCategory();
	
	// category-specific
	public InterestCategory showCategory(int id);
	public InterestCategory createCategory(InterestCategory interestCategory);
	public InterestCategory updateCategory(int id, InterestCategory interestCategory);
	public boolean destroyCategory(int id);
	
	public List<InterestCategory> indexCategories();
	public List<InterestCategory> indexCategoriesBy(Predicate<InterestCategory> filter);
}
