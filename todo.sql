create table todo (
  id serial4 primary key,
  name varchar(30) not null,
  due_date date,
  category varchar(30),
  description text
);