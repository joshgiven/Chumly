package controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import data.MessageDAO;
import data.MessageDAOImpl;
import data.UserDAO;
import data.UserDAOImpl;
import entities.Message;
import entities.User;



@SessionAttributes(names={"sessionUser"})
public class UserController {
	
	UserDAO UDAO = new UserDAOImpl();
	MessageDAO MDAO = new MessageDAOImpl();
	
//	how to get session scope user
//	User sessionUser = (User)model.asMap().get("sessionUser");
	

	@RequestMapping (method=RequestMethod.POST, path="login.do")
	public String login(@Valid User user, Errors errors, Model model){
		
		if(errors.getErrorCount()>0){
			return "index";
		}
				
		User u = UDAO.getUserByUsername(user.getUsername());	
		
		if(u.getUsername() == user.getUsername() && u.getPassword() == user.getPassword()){
			model.addAttribute("sessionUser", u);
			return "profile";
		}
		else{
			return "index";	
		}
	}
	
	@RequestMapping (method=RequestMethod.POST, path="getUpdateProfile.do")
	public String getUpdateProfile(Model model){
		return "updateProfile";
	}
	
	@RequestMapping (method=RequestMethod.GET, path="getUsersByInterest.do")
	public String searchByInterest(String interestName, Model model){
		
		List<User> users = UDAO.indexByInterest(interestName);
		
		model.addAttribute("users", users);
		
		return "results";
	}
	
	@RequestMapping (method=RequestMethod.GET, path="getOtherUserProfileInformation.do")
	public String getUpdateProfile(Integer id, Model model){
		User user = UDAO.show(id);
		model.addAttribute("user", user);
		return "otherUser";
	}
	
	@RequestMapping (method=RequestMethod.GET, path="userMessage.do")
	public String getUserMessage(Integer id, Model model){
		User recipient = UDAO.show(id);
		User sessionUser = (User)model.asMap().get("sessionUser");
		
		List<Message> messages = null;
		messages = MDAO.indexByConversation(recipient, sessionUser);
		
		model.addAttribute("sender", sessionUser);
		model.addAttribute("recipient", recipient);
		model.addAttribute("messages",messages);
		
		return "message";
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
