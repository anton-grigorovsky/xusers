package task.trial.xusers.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import task.trial.xusers.model.Role;

/**
 * Created by Антон on 04.08.2017.
 */
public interface RoleDao extends JpaRepository<Role, Long> {
}