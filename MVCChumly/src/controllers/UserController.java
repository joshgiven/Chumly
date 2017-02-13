package controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import data.InterestDAO;
import data.LocationDAO;
import data.MessageDAO;
import data.UserDAO;
import entities.Message;
import entities.User;
import entities.User.Role;

@Controller
@SessionAttributes(names = { "sessionUser" })
public class UserController {

	@Autowired
	UserDAO udao;

	@Autowired
	MessageDAO mdao;

	@Autowired
	InterestDAO idao;

	@Autowired
	LocationDAO ldao;

	// how to get session scope user
	// User sessionUser = (User)model.asMap().get("sessionUser");

	@RequestMapping(method = RequestMethod.POST, path = "login.do")
	public String login(User user, Errors errors, Model model) {

//		if (errors.getErrorCount() > 0) {
//			return "index.jsp";
//		}

		User u = udao.getUserByUsername(user.getUsername());
		
		
//		System.out.println("User: " + user  + " pw: "+ user.getPassword());
//		System.out.println("U from DB: " + u  + " pw: "+ u.getPassword());
		
		if (u != null){
			if(u.getPassword().equals(user.getPassword())){
				model.addAttribute("sessionUser", u);
				return "profile.jsp";
			}
			else{
				return "index.jsp";
			}
		}
		else{
			return "index.jsp";
		}

//		if (u.getUsername() == user.getUsername() && u.getPassword() == user.getPassword() && u.getRole() == Role.ADMIN) {
//			model.addAttribute("sessionUser", u);
//			
//			//need to insert admin page
//			return "profile.jsp";
//		} 
//		else if(u.getUsername() == user.getUsername() && u.getPassword() == user.getPassword()) {
//			model.addAttribute("sessionUser", u);
//			return "profile.jsp";
//		}
//		else {
//			return "index.jsp";
//		}
	}

	@RequestMapping(method = RequestMethod.POST, path = "getUpdateProfile.do")
	public String getUpdateProfile(Model model) {
		return "updateProfile.jsp";
	}

	@RequestMapping(method = RequestMethod.GET, path = "getUsersByInterest.do")
	public String searchByInterest(String interestName, Model model) {

		List<User> users = udao.indexByInterest(interestName);
		System.out.println(users);

		model.addAttribute("users", users);

		return "results.jsp";
	}
	
	
	@RequestMapping(method = RequestMethod.POST, path = "deleteProfile.do")
	public String deleteProfile(Model model) {
		User sessionUser = (User) model.asMap().get("sessionUser");
		udao.destroy(sessionUser.getId());
		return "index.jsp";
	}

	@RequestMapping(method = RequestMethod.GET, path = "getOtherUserProfileInformation.do")
	public String getUpdateProfile(Integer id, Model model) {
		User user = udao.show(id);
		model.addAttribute("user", user);
		return "otherUser.jsp";
	}

	@RequestMapping(method = RequestMethod.GET, path = "userMessage.do")
	public String getUserMessage(Integer id, Model model) {
		User recipient = udao.show(id);
		User sessionUser = (User) model.asMap().get("sessionUser");

		List<Message> messages = null;
		messages = mdao.indexByConversation(recipient, sessionUser);

		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages", messages);

		return "message.jsp";
	}

	@RequestMapping(method = RequestMethod.GET, value = "home.do")
	public String home() {
		return "index.jsp";
	}
	
	

}
