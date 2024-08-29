package com.example.scraping_render.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.scraping_render.domain.User;
import com.example.scraping_render.repository.UserRepository;

@Service
public class UserService {

    @Autowired
	private PasswordEncoder passwordEncoder;

    @Autowired
    private UserRepository userRepository;

    public void insertUser(User user) {
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		userRepository.insertUser(user);
	}

    public User findUserByUsername(String username) {
        return userRepository.findUserByUsername(username);
    }
}
