package task.trial.xusers.service;

import task.trial.xusers.model.User;

import java.util.List;

/**
 * Created by Антон on 04.08.2017.
 */
public interface UserService {

    void save(User user);

    User findByUsername(String username);

    List<User> listUsers(String name);

    User getUserById(long id);


    void updateUser(User user);

    void removeUser(long id);
}
