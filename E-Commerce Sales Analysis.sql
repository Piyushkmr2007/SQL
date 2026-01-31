 BASIC (1)


--1								
select*
from customers

--2
select customer_id,
first_name,
email
from customers

--3
select product_name,category
from products
where category = 'clothing'

--4
select order_id,total_amount
from orders
where total_amount>500

--5
select customer_id,first_name,join_date
from customers
where join_date > '2023-01-01'

--6
select product_name,price
from products
order by price desc


--7
select order_id,order_date
from orders
order by order_date desC

--8
select *
from orders
where order_status = 'completed'

--9
select *
from orders
where order_date between '2023/02/01' and '2023/02/28'

--10
select *
from products
where price
between 50 and 100


-- aggregates function (2)


--1										
select COUNT(*) as total
from customers

--2
select AVG(total_amount)
from orders

--3
select MAX(price) as H, MIN(price) as L
from products


				select top 1*
				from products
				order by price desc

				-- alter

				select top 1*
				from products
				order by price asc


--4
select category,COUNT(*) as C
from products
group by category


--5
select sum(total_amount)
from orders

--6
select customer_id,COUNT(*) as total_orders
from orders
group by customer_id
order by total_orders desc

--7

select YEAR(order_date),MONTH(order_date),SUM(total_amount)
from orders
where YEAR(order_date) = 2023
group by YEAR(order_date),MONTH(order_date)
order by MONTH(order_date) asc 


--8
select customer_id, COUNT(order_id)
from orders
group by customer_id
having COUNT(order_id)>5

--9
select payment_method,COUNT(payment_id) as P
from payments
group by payment_method

--10
select AVG(price),category
from products
group by category

-- joins (3)


--1
select o.*, c.first_name, c.last_name
from orders as o
left join customers as c
on o.customer_id=c.customer_id

--2
select i.*, p.product_name, p.product_id, p.stock_quantity 
from order_items as i
left join products as p
on i.product_id=p.product_id


--3
select o.*, p.payment_method, p.payment_status
from orders as o
left join payments as p
on o.order_id=p.order_id

--4
select c.*, o.order_status
from customers as c
left join orders as o
on c.customer_id=o.customer_id
where order_status is null


--5    no ans
select p.product_name, i.order_id
from products as p
left join order_items as i
on p.product_id=i.product_id
where order_id is null

--6
select c.customer_id, sum(o.total_amount) as total_spending
from customers as c
inner join orders as o
on c.customer_id=o.customer_id
group by c.customer_id
order by total_spending desc

--7
select c.customer_id, count(o.total_amount) as no_of_products
from customers as c
inner join orders as o
on c.customer_id=o.customer_id
group by c.customer_id
order by no_of_products desc

--8
select i.*, p.product_name
from order_items as i
inner join products as p
on i.product_id=p.product_id

--9 no ans
select o.*, p.payment_id
from orders as o
left join payments as p
on o.order_id=p.order_id
where payment_id is null

--10
select c.customer_id, c.first_name, c.last_name, max(o.order_date) as last_date
from customers as c
inner join orders as o
on c.customer_id=o.customer_id
group by c.customer_id, c.first_name, c.last_name


-- subqeury (4)

--1
select *
from products
where price=(
	select max(price)
	from products
	)

--2
select *
from customers
where customer_id in (
	select distinct customer_id
	from orders
	)

--3
select *
from orders
where total_amount > (
	select avg(total_amount)
	from orders
	)

--4
select *
from products
where price =(select MIN(price)
from products
)

--5
select * 
from customers
where customer_id = (
	select top 1 customer_id
	from orders
	group by customer_id
	order by count(order_id) desc
	)

--6
	
select top 1 *
from (
	select top 2 *
	from products
	order by price desc
	) as top_2
order by price 


--7
select * 
from customers
where customer_id not in (
	select customer_id
	from orders
	where order_id in(
		select distinct order_id
		from payments
		)
	)
	
--8
select *
from products
where stock_quantity < (
    select avg(stock_quantity)
    from products
	)

--9
select *
from customers
where customer_id in(
	select customer_id
	from orders
	group by customer_id
	having sum(total_amount) > 2000
	)





