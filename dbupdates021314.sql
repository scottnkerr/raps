use Raps
select user_id, user_name, disabled from users

alter table users
add search_options_exact bit, 
search_options_other varchar(50), 
search_options_searchby varchar(50),
search_options_include varchar(50)


alter table rating_property
add prop_agencyfeeoverride bit null