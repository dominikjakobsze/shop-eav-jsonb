with recursive category_tree_up as (select id, parent_id, name, 1 as level
                                    from categories
                                    where id = 6
                                    union all
                                    select c.id, c.parent_id, c.name, ctu.level + 1
                                    from categories c
                                             join category_tree_up ctu
                                                  on c.id = ctu.parent_id)
select *,
       dense_rank() over (order by level desc) as breadcrumbs_order
from category_tree_up
order by level desc, name;