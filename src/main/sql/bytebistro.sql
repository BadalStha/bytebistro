create database bytebistro;

use bytebistro;

create table users(
	user_id int primary key auto_increment,
    full_name varchar(100) not null,
    email varchar(100) unique not null,
    phone varchar(15) unique not null,
    password_hash varchar(255) not null,
    role varchar(20) not null,
    created_at timestamp default current_timestamp
);

create table menu_items(
	item_id int primary key auto_increment,
    name varchar(100) not null,
    description text,
    price decimal(10,2) not null,
    item_type varchar(50) not null,
    is_available boolean default true
);

create table table_info(
	table_id int primary key auto_increment,
    table_number int unique not null,
    seating_capacity int not null
);

create table bookings(
	booking_id int primary key auto_increment,
    user_id int not null,
    table_id int not null,
    booking_date date not null,
    booking_time time not null,
    guest_count int not null,
    status varchar(20) default 'pending',
    cancellation_fee decimal(10,2) default 0.00,
    foreign key (user_id) references users(user_id),
    foreign key (table_id) references table_info(table_id)
);

create table booking_beverages(
	booking_beverage_id int primary key auto_increment,
    booking_id int not null,
    item_id int not null,
    quantity int not null,
    foreign key (booking_id) references bookings(booking_id),
    foreign key (item_id) references menu_items(item_id)
);

create table orders(
	order_id int primary key auto_increment,
    user_id int not null,
    delivery_address text not null,
    status varchar(20) default 'pending',
    ordered_at timestamp default current_timestamp,
    foreign key (user_id) references users(user_id)
);

create table order_items(
	order_item_id int primary key auto_increment,
    order_id int not null,
    item_id int not null,
    quantity int not null,
    unit_price decimal(10,2) not null,
    foreign key (order_id) references orders(order_id),
    foreign key (item_id) references menu_items(item_id)
);

create table bills(
	bill_id int primary key auto_increment,
    order_id int unique not null,
    total_amount decimal(10,2) not null,
    discount decimal(10,2) default 0.00,
    final_amount decimal(10,2) not null,
    payment_status varchar(20) default 'unpaid',
    payment_method varchar(20),
    generated_at timestamp default current_timestamp,
    foreign key (order_id) references orders(order_id)
);

create table promotions(
	promotion_id int primary key auto_increment,
    title varchar(150) not null,
    description text,
    discount_percent decimal(5,2),
    valid_from date not null,
    valid_until date not null,
    is_active boolean default true
);

create table ratings(
	rating_id int primary key auto_increment,
    user_id int not null,
    food_rating int,
    staff_rating int,
    ambience_rating int,
    comment text,
    rated_at timestamp default current_timestamp,
    foreign key (user_id) references users(user_id)
);

create table menu_item_images(
    image_id int primary key auto_increment,
    item_id int not null,
    image_path varchar(255) not null,
    uploaded_at timestamp default current_timestamp,
    foreign key (item_id) references menu_items(item_id) on delete cascade
);