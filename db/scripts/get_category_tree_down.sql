with recursive category_tree_down as (select id, name, parent_id, 1 as level
                                      from categories
                                      where id = 1
                                      union all
                                      select c.id, c.name, c.parent_id, ctd.level + 1
                                      from categories c
                                               join category_tree_down ctd
                                                    on c.parent_id = ctd.id)
select *,
       dense_rank() over (order by level) as breadcrumbs_order
from category_tree_down
order by level, name;


