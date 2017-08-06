-- Table: users
CREATE TABLE users (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  firstname VARCHAR(255),
  lastname VARCHAR(255),
  username VARCHAR(255),
  password VARCHAR(255),
  email VARCHAR(40),
  birthday VARCHAR(10),
  createdTimestamp TIMESTAMP,
  lastUpdatedTimestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
)
  ENGINE = InnoDB;

-- Table address
/*CREATE TABLE address (
  user_id INT,
  zip VARCHAR(10),
  country VARCHAR(40),
  city VARCHAR(40),
  disctrict VARCHAR(40),
  adress VARCHAR(40)
)
  ENGINE = InnoDB;

ALTER TABLE address ADD CONSTRAINT address_fk1 FOREIGN KEY (user_id) REFERENCES users(id);
*/

-- Table roles
CREATE TABLE roles (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
  name VARCHAR(100) NOT NULL
)
  ENGINE = InnoDB;

-- Table for mapping users and roles: user_roles

CREATE TABLE user_roles (
  user_id INT NOT NULL ,
  role_id INT NOT NULL ,

  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (role_id) REFERENCES roles (id),

  UNIQUE (user_id, role_id)
)
  ENGINE = InnoDB;


-- Insert data

INSERT INTO users VALUES (1, 'Anton', 'Grigorovsky', 'hello', '$2a$11$uSXS6rLJ91WjgOHhEGDx..VGs7MkKZV68Lv5r1uwFu7HgtRn3dcXG');

INSERT INTO roles VALUES (1, 'ROLE_USER');
INSERT INTO roles VALUES (2, 'ROLE_ADMIN');

INSERT INTO user_roles VALUES (1, 2);