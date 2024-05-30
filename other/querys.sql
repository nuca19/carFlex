--ORDEM INTERESSA

        --ORDEM INTERESSA

-- Insert into Veiculo
INSERT INTO Veiculo(codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa, tipo)
VALUES ('a3f5b2c1', 2020, 'Fiat', '500', 7000, 'Gasolina', 'Novo', 'Automatico', 'automovel'),
       ('d4e6g7h8', 2018, 'Mercedes', 'Classe A', 20000, 'Gasolina', 'Usado', 'Manual', 'automovel'),
       ('b4g6h7j8', 2019, 'BMW', '320i', 15000, 'Gasolina', 'Usado', 'Automatico', 'automovel'),
       ('c5h7i8j9', 2021, 'Audi', 'A3', 5000, 'Diesel', 'Novo', 'Manual', 'automovel'),
       ('m1n2o3p4', 2020, 'Honda', 'CBR600RR', 5000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('q1r2s3t4', 2021, 'Yamaha', 'YZF-R1', 1000, 'Gasolina', 'Novo', 'Manual', 'motociclo'),
       ('v1w2x3y4', 2022, 'Tesla', 'Model 3', 100, 'Eletrico', 'Novo', 'Automatico', 'automovel'),
       ('z1a2b3c4', 2021, 'Kawasaki', 'Ninja ZX-10R', 2000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('x1y2z3a4', 2021, 'Ford', 'Mustang', 5000, 'Gasolina', 'Usado', 'Automatico', 'automovel'),
       ('b1c2d3e4', 2020, 'Suzuki', 'GSX-R1000', 3000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('f1g2h3i4', 2022, 'Chevrolet', 'Camaro', 1000, 'Gasolina', 'Novo', 'Automatico', 'automovel'),
       ('j1k2l3m4', 2021, 'Ducati', 'Panigale V4', 2000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('n1o2p3q4', 2021, 'Toyota', 'Supra', 5000, 'Gasolina', 'Usado', 'Automatico', 'automovel'),
       ('r1s2t3u4', 2020, 'Harley-Davidson', 'Street Glide', 3000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('v1w2x3y5', 2022, 'Porsche', '911', 100, 'Gasolina', 'Novo', 'Automatico', 'automovel'),
       ('z1a2b3c5', 2021, 'KTM', 'RC 390', 2000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('v1w2x3y6', 2022, 'Lamborghini', 'Huracan', 100, 'Gasolina', 'Novo', 'Automatico', 'automovel'),
       ('z1a2b3c6', 2021, 'Triumph', 'Street Triple', 2000, 'Gasolina', 'Usado', 'Manual', 'motociclo'),
       ('v1w2x3y7', 2022, 'Bugatti', 'Chiron', 100, 'Gasolina', 'Novo', 'Automatico', 'automovel'),
       ('m1n2o3p5', 2022, 'BMW', 'S1000RR', 0, 'Gasolina', 'Novo', 'Manual', 'motociclo'),
       ('m2n3o4p5', 2022, 'Ducati', 'Multistrada V4', 0, 'Gasolina', 'Novo', 'Manual', 'motociclo'),
       ('m3n4o5p6', 2022, 'Kawasaki', 'Z H2', 0, 'Gasolina', 'Novo', 'Manual', 'motociclo'),
       ('m4n5o6p7', 2022, 'Yamaha', 'MT-10', 0, 'Gasolina', 'Novo', 'Manual', 'motociclo'),
       ('m5n6o7p8', 2022, 'Suzuki', 'Hayabusa', 0, 'Gasolina', 'Novo', 'Manual', 'motociclo');
       

       
       

-- Insert into Automovel codigo(8chars)
INSERT INTO Automovel(codigo, segmento, num_portas, num_lugares, cavalos)
VALUES ('a3f5b2c1', 'carros_citadinos', 4, 5, 70),
       ('d4e6g7h8', 'utilitarios', 5, 7, 200),
       ('b4g6h7j8', 'familiares_medios_executivos_medios', 4, 5, 180),
       ('c5h7i8j9', 'utilitarios', 5, 5, 150),
       ('v1w2x3y4', 'familiares_medios_executivos_medios', 4, 5, 283),
       ('x1y2z3a4', 'luxo', 2, 2, 450),
       ('f1g2h3i4', 'luxo', 2, 2, 455),
       ('n1o2p3q4', 'luxo', 2, 2, 335),
       ('v1w2x3y5', 'luxo', 2, 2, 450),
       ('v1w2x3y6', 'luxo', 2, 2, 610),
       ('v1w2x3y7', 'luxo', 2, 2, 1500);



INSERT INTO Motociclo(codigo, segmento, cilindrada)
VALUES ('m1n2o3p4', 'Sport', 600),
       ('q1r2s3t4', 'Sport', 1000),
       ('z1a2b3c4', 'Sport', 998),
       ('b1c2d3e4', 'Sport', 1000),
       ('z1a2b3c5', 'Sport', 373),
       ('j1k2l3m4', 'Sport', 1103),
       ('r1s2t3u4', 'Grand_Turismo', 1746),
       ('z1a2b3c6', 'Sport', 765),
       ('m1n2o3p5', 'Sport', 1000),
       ('m2n3o4p5', 'Touring', 1200),
       ('m3n4o5p6', 'Sport', 1000),
       ('m4n5o6p7', 'Sport', 1000),
       ('m5n6o7p8', 'Sport', 1300);

--create users id(100-999 4digits)
INSERT INTO Utilizador(nif, nome, endereco, username, pass_word)
VALUES ( 123456789, 'User 1', 'Address 1', 'Joao', '1234'),
       ( 987654321, 'User 2', 'Address 2', 'Andre', '1234'),
       ( 234567890, 'User 3', 'Address 3', 'Maria', '1234'),
       ( 345678901, 'User 4', 'Address 4', 'Pedro', '1234'),
       (456789012, 'User 5', 'Address 5', 'Ana', '1234'),
       (567890123, 'User 6', 'Address 6', 'Carlos', '1234'),
       (678901234, 'User 7', 'Address 7', 'Ricardo', '1234'),
       (789012345, 'User 8', 'Address 8', 'Sofia', '1234'),
       (234567891, 'User 13', 'Address 13', 'Miguel', '1234'),
       (345678912, 'User 14', 'Address 14', 'Laura', '1234'),
       (456789123, 'User 15', 'Address 15', 'Goncalo', '1234'),
       (567891234, 'User 16', 'Address 16', 'Carla', '1234'),
       (678912345, 'User 17', 'Address 17', 'Nuno', '1234');
       
       

--create anuncios (5digits)
INSERT INTO Anuncio_venda( data_venda, preco, codigo_veiculo, id_vendedor)
VALUES ('2022-01-01', 15000.00, 'a3f5b2c1', 100),
       ( '2022-01-02', 20000.00, 'd4e6g7h8', 103),
       ('2022-01-03', 25000.00, 'b4g6h7j8', 103),
       ( '2022-01-04', 30000.00, 'c5h7i8j9', 102),
       ('2022-02-01', 8000.00, 'm1n2o3p4', 101),
       ('2022-02-02', 12000.00, 'q1r2s3t4', 101),
       ('2022-02-03', 35000.00, 'v1w2x3y4', 101),
       ('2022-02-04', 15000.00, 'z1a2b3c4', 103),
       ('2022-03-01', 40000.00, 'x1y2z3a4', 104),
       ('2022-03-02', 13000.00, 'b1c2d3e4', 105),
       ('2022-03-03', 60000.00, 'f1g2h3i4', 106),
       ('2022-03-04', 25000.00, 'j1k2l3m4', 107),
       ('2022-03-05', 55000.00, 'n1o2p3q4', 108),
       ('2022-03-06', 20000.00, 'r1s2t3u4', 109),
       ('2022-04-01', 200000.00, 'v1w2x3y5', 112),
       ('2022-04-02', 5500.00, 'z1a2b3c5', 110),
       ('2022-04-03', 260000.00, 'v1w2x3y6', 111),
       ('2022-04-04', 9500.00, 'z1a2b3c6', 111),
       ('2022-04-05', 3000000.00, 'v1w2x3y7', 112),
       ('2022-04-06', 10000.00, 'm1n2o3p5', 103),
       ('2022-04-07', 15000.00, 'm2n3o4p5', 105),
       ('2022-04-08', 20000.00, 'm3n4o5p6', 106),
       ('2022-04-09', 25000.00, 'm4n5o6p7', 110),
       ('2022-04-10', 30000.00, 'm5n6o7p8', 111);



INSERT INTO Compra (num_venda, data_compra,  id_comprador)
VALUES (10003, '2022-01-01', 110),
       (10008, '2022-01-02', 105),
       (10010, '2022-01-03', 106),
       (10011, '2022-03-04', 112),
       (10018, '2022-04-05', 108);


INSERT INTO Avaliacao (num_compra, avaliacao, comentario)
VALUES (1000, 5, 'Excelente compra'),
       (1001, 4, 'Bom negocio'),
       (1004, 1, 'Pessimo negocio');







-- Delete from Automovel
DELETE FROM Automovel WHERE codigo IN (3);

-- Get veiculos
SELECT marca, modelo, cavalos
FROM (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)

-- Get all anuncios
SELECT numero, modelo, cavalos, km, preco
FROM Anuncio_venda JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo

