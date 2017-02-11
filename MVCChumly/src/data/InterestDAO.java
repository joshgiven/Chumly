package data;

import java.util.List;
import java.util.Map;
import java.util.function.Predicate;

import entities.Interest;
import entities.InterestCategory;

public interface InterestDAO {
	public Interest show(int id);
	public Interest create(Interest film);
	public Interest update(int id, Interest film);
	public boolean destroy(int id);

	public List<Interest> index();
	public List<Interest> indexByCategory(InterestCategory category);
	public <T> List<Interest> indexBy(Predicate<T> filter);

	public Map<InterestCategory, Interest> mapByCategory();
	
	// category-specific
	public InterestCategory showCategory(int id);
	public InterestCategory createCategory(InterestCategory film);
	public InterestCategory updateCategory(int id, InterestCategory film);
	public boolean destroyCategory(int id);
	
	public List<InterestCategory> indexCategories();
	public <T> List<InterestCategory> indexCategoriesBy(Predicate<T> filter);
}
