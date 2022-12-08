Create table Users(
    user_id uuid PRIMARY KEY DEFAULT 
    uuid_generate_v4(),
    user_name VARCHAR(255) NOT NULL,
    user_email VARCHAR(255) NOT NULL,
    user_password VARCHAR(255) NOT NULL
);

Create table Genres(
    genre_id SERIAL PRIMARY KEY,
    genre_name VARCHAR(255) NOT NULL
);

Create table Books(
    book_number isbn13 PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    link VARCHAR(255) NOT NULL,
    synopsis VARCHAR(500) NOT NULL,
    genre VARCHAR(500) NOT NULL,
    demographic VARCHAR(500) NOT NULL
);

Create table user_book(
    ub_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    book_number isbn13,
    user_id uuid,
    PRIMARY KEY(book_number, user_id),
    FOREIGN KEY (book_number) REFERENCES books(book_number),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

Create table Authors(
    author_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    author_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(author_id)
);

Create table Book_Authors(
    ba_id uuid DEFAULT uuid_generate_v4() NOT NULL,
    author_id uuid,
    book_number isbn13,
    PRIMARY KEY (author_id, book_number),
    FOREIGN KEY (author_id) REFERENCES authors(author_id),
    FOREIGN KEY (book_number) REFERENCES books(book_number)
);


INSERT INTO users(user_name, user_email, user_password) VALUES ('john', 'john@gmail.com','john123');

INSERT INTO books(book_number, title, link, demographic, genre, synopsis) VALUES ('978-0486649405','Ordinary Differential Equations','https://m.media-amazon.com/images/I/71tvEt0rtGL.jpg','Adults','Mathematics','The book contains two exceptional chapters: one on series methods of solving differential equations, the second on numerical methods of solving differential equations. The first includes a discussion of the Legendre Differential Equation, Legendre Functions, Legendre Polynomials, the Bessel Differential Equation, and the Laguerre Differential Equation. Throughout the book, every term is clearly defined and every theorem lucidly and thoroughly analyzed, and there is an admirable balance between the theory of differential equations and their application. An abundance of solved problems and practice exercises enhances the value of Ordinary Differential Equations as a classroom text for undergraduate students and teaching professionals. The book concludes with an in-depth examination of existence and uniqueness theorems about a variety of differential equations, as well as an introduction to the theory of determinants and theorems about Wronskians.');

/* Book table insert Queries*/
INSERT INTO books(book_number, title, link, synopsis,genre, demographic) VALUES ('978-1840227932','Pride And Prejudice','https://m.media-amazon.com/images/I/81FOTF7SJvL.jpg',
'Pride and Prejudice by Jane Austen. Austen''s most popular novel, the unforgettable story of Elizabeth Bennet and Mr. Darcy. Nominated as one of America''s best-loved novels by PBS''s The Great American Read. Pride and Prejudice is a novel of manners by Jane Austen, first published in 1813. The story follows the main character, Elizabeth Bennet, as she deals with issues of manners, upbringing, morality, education, and marriage in the society of the landed gentry of the British Regency. Elizabeth is the second of five daughters of a country gentleman living near the fictional town of Meryton in Hertfordshire, near London. Page 2 of a letter from Jane Austen to her sister Cassandra (11 June 1799) in which she first mentions Pride and Prejudice, using its working title First Impressions. Set in England in the early 19th century, Pride and Prejudice tells the story of Mr and Mrs Bennet''s five unmarried daughters after the rich and eligible Mr Bingley and his status-conscious friend, Mr Darcy, have moved into their neighbourhood. While Bingley takes an immediate liking to the eldest Bennet daughter, Jane, Darcy has difficulty adapting to local society and repeatedly clashes with the second-eldest Bennet daughter, Elizabeth. Though Austen set the story at the turn of the 19th century, it retains a fascination for modern readers, continuing near the top of lists of most loved books. It has become one of the most popular novels in English literature, selling over 20 million copies, and receives considerable attention from literary scholars. Modern interest in the book has resulted in a number of dramatic adaptations and an abundance of novels and stories imitating Austen''s memorable characters or themes. A True Classic that Belongs on Every Bookshelf!','Non-Fiction','Adult');


/* user_book Insert Queries*/
INSERT INTO user_book(book_number, user_id) VALUES ('978-0-545-21578-7', '679c30bf-57fb-412f-8676-bde171185e77');
INSERT INTO user_book(book_number, user_id) VALUES ('978-0-547-92822-7', '679c30bf-57fb-412f-8676-bde171185e77');

/* Query to retrieve the books data for specific users based on user_id */
select books.book_number, books.title, books.link, books.synopsis,books.demographic, books.genre, n1.user_id, n1.ub_id from books inner join (select book_number, user_id, ub_id from user_book where user_id = '679c30bf-57fb-412f-8676-bde171185e77') n1 on books.book_number = n1.book_number;

INSERT INTO book_authors(book_number, author_id) VALUES ('978-1-59986-977-3','564b9e46-3388-4406-b3d4-0e90108da88c'),('978-0-06-245771-4','7e60408b-c238-4026-b174-890b3da74b21'), ('978-0-14-028019-7', '53b4bc96-3a7a-4275-ac04-461532013c8e'), ('978-0-7352-1129-2','b268c09b-12fd-4afe-b52a-983f31441362');

select book_authors.book_number, authors.author_name from (book_authors INNER JOIN authors on book_authors.author_id = authors.author_id) n2 on books.book_number = n2.book_number;


 select books.book_number, books.title, books.synopsis, books.link, books.demographic, books.genre, n2.author_name from books INNER JOIN (select book_authors.book_number, authors.author_name from book_authors INNER JOIN authors on book_authors.author_id = authors.author_id) n2 on books.book_number = n2.book_number;




 select n2.book_number, n2.title, n2.link, n2.synopsis,n2.demographic, n2.genre, n2.user_id, n2.ub_id, n3.author_name from (select books.book_number, books.title, books.link, books.synopsis,books.demographic, books.genre, n1.user_id, n1.ub_id from books inner join (select book_number, user_id, ub_id from user_book where user_id = '679c30bf-57fb-412f-8676-bde171185e77') n1 on books.book_number = n1.book_number) n2 inner join (select book_authors.book_number, authors.author_name from book_authors INNER JOIN authors on book_authors.author_id = authors.author_id) n3 on n2.book_number = n3.book_number