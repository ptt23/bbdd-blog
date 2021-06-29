create DATABASE blog;

\c blog

CREATE TABLE usuarios
(
    id SERIAL PRIMARY KEY,
    email VARCHAR (100)
);

CREATE TABLE posts
(
    id SERIAL,
    usuario_id INT,
    titulo VARCHAR (100),
    fecha DATE,
    PRIMARY KEY (id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

CREATE TABLE comentarios
(
    id SERIAL PRIMARY KEY,
    usuario_id INT,
    post_id INT,
    texto TEXT,
    fecha DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (post_id) REFERENCES posts(id)
);

\copy usuarios FROM 'usuarios.csv' csv header;
\copy posts FROM 'posts.csv' csv header;
\copy comentarios FROM 'comentarios.csv' csv header;


SELECT email, u.id, titulo
FROM usuarios u
    INNER JOIN posts
    on u.id = posts.usuario_id
WHERE u.id = 5;

SELECT u.email, c.id, texto
FROM comentarios c
    INNER JOIN usuarios AS u
    ON u.id = c.usuario_id
WHERE u.email != 'usuario06@hotmail.com';

SELECT *
FROM usuarios u
    LEFT JOIN posts p
    ON u.id = p.usuario_id
WHERE p.id is NULL;

SELECT *
FROM posts p
    FULL OUTER JOIN comentarios
    ON p.id = comentarios.post_id;

SELECT *
FROM usuarios
    JOIN posts
    ON usuarios.id = posts.usuario_id
WHERE posts.fecha BETWEEN '2020-06-01' AND '2020-06-30';
