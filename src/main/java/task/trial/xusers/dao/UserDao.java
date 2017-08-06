package task.trial.xusers.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import task.trial.xusers.model.User;

/**
 * Created by Антон on 04.08.2017.
 */
public interface UserDao extends JpaRepository<User, Long> {
    User findByUsername(String username);


}