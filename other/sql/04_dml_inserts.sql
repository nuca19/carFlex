--DB NEEDS TO BE CLEAR IF INSERTING
--ORDER OF INSERTION IS IMPORTANT
INSERT INTO Veiculo(codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa, tipo)
VALUES ('a3f5b2c1', 2020, 'Fiat', '500', 7000, 'gasolina', 'novo', 'automatico', 'automovel'),
       ('d4e6g7h8', 2018, 'Mercedes', 'Classe A', 20000, 'gasolina', 'usado', 'manual', 'automovel'),
       ('b4g6h7j8', 2019, 'BMW', '320i', 15000, 'gasolina', 'usado', 'automatico', 'automovel'),
       ('c5h7i8j9', 2021, 'Audi', 'A3', 5000, 'Diesel', 'novo', 'manual', 'automovel'),
       ('m1n2o3p4', 2020, 'Honda', 'CBR600RR', 5000, 'gasolina', 'usado', 'manual', 'motociclo'),
       ('q1r2s3t4', 2021, 'Yamaha', 'YZF-R1', 1000, 'gasolina', 'novo', 'manual', 'motociclo'),
       ('v1w2x3y4', 2022, 'Tesla', 'Model 3', 100, 'eletrico', 'novo', 'automatico', 'automovel'),
       ('z1a2b3c4', 2021, 'Kawasaki', 'Ninja ZX-10R', 2000, 'gasolina', 'usado', 'manual', 'motociclo'),
       ('x1y2z3a4', 2021, 'Ford', 'Mustang', 5000, 'gasolina', 'usado', 'automatico', 'automovel'),
       ('b1c2d3e4', 2020, 'Suzuki', 'GSX-R1000', 3000, 'gasolina', 'usado', 'manual', 'motociclo'),
       ('f1g2h3i4', 2022, 'Chevrolet', 'Camaro', 1000, 'gasolina', 'novo', 'automatico', 'automovel'),
       ('j1k2l3m4', 2021, 'Ducati', 'Panigale V4', 2000, 'gasolina', 'usado', 'manual', 'motociclo'),
       ('n1o2p3q4', 2021, 'Toyota', 'Supra', 5000, 'gasolina', 'usado', 'automatico', 'automovel'),
       ('r1s2t3u4', 2020, 'Harley-Davidson', 'Street Glide', 3000, 'gasolina', 'usado', 'manual', 'motociclo'),
       ('v1w2x3y5', 2022, 'Porsche', '911', 100, 'gasolina', 'novo', 'automatico', 'automovel'),
       ('z1a2b3c5', 2021, 'KTM', 'RC 390', 2000, 'gasolina', 'usado', 'manual', 'motociclo'),
       ('v1w2x3y6', 2022, 'Lamborghini', 'Huracan', 100, 'gasolina', 'novo', 'automatico', 'automovel'),
       ('z1a2b3c6', 2021, 'Triumph', 'Street Triple', 2000, 'diesel', 'usado', 'manual', 'motociclo'),
       ('v1w2x3y7', 2024, 'Bugatti', 'Chiron', 100, 'diesel', 'novo', 'automatico', 'automovel'),
       ('m1n2o3p5', 2024, 'BMW', 'S1000RR', 0, 'diesel', 'novo', 'manual', 'motociclo'),
       ('m2n3o4p5', 2022, 'Ducati', 'Multistrada V4', 0, 'diesel', 'novo', 'manual', 'motociclo'),
       ('m3n4o5p6', 2024, 'Kawasaki', 'Z H2', 0, 'diesel', 'novo', 'manual', 'motociclo'),
       ('m4n5o6p7', 2022, 'Yamaha', 'MT-10', 0, 'diesel', 'novo', 'manual', 'motociclo'),
       ('m5n6o7p8', 2024, 'Suzuki', 'Hayabusa', 0, 'diesel', 'novo', 'manual', 'motociclo'),
       ('jdlkalx0', 2019, 'Renault', 'Clio', 15000, 'diesel', 'usado', 'manual', 'automovel'),
       ('h797sa8s', 2020, 'Peugeot', '208', 10000, 'diesel', 'usado', 'manual', 'automovel'),
       ('s9a8dhaz', 2021, 'Jeep', 'Wrangler', 5000, 'diesel', 'usado', 'automatico', 'automovel'),
       ('c1o2m3p4', 2022, 'Volkswagen', 'Golf', 100, 'disesel', 'novo', 'automatico', 'automovel'),
       ('f1a2m3i4', 2022, 'Seat', 'Ibiza', 100, 'eletrico', 'novo', 'manual', 'automovel'),
       ('moask781', 2022, 'Mercedes', 'Classe S', 100, 'eletrico', 'novo', 'automatico', 'automovel');
       

-- Insert into Automovel codigo(8chars)
INSERT INTO Automovel(codigo, segmento, num_portas, num_lugares, cavalos)
VALUES ('a3f5b2c1', 'carros_citadinos', 4, 5, 70),
       ('jdlkalx0' , 'carros_citadinos', 4, 5, 86),
       ('h797sa8s', 'carros_citadinos', 4, 5, 90),
       ('s9a8dhaz', 'utilitarios', 5, 5, 200),
       ('d4e6g7h8', 'utilitarios', 5, 7, 200),
       ('c5h7i8j9', 'utilitarios', 5, 5, 150),
       ('f1a2m3i4', 'familiares_compactos', 5, 5, 120),
       ('c1o2m3p4', 'familiares_compactos', 5, 5, 130),
       ('b4g6h7j8', 'familiares_medios_executivos_medios', 4, 5, 180),
       ('v1w2x3y4', 'familiares_medios_executivos_medios', 4, 5, 283),
       ('moask781', 'familiares_grandes_executivos_grandes', 4, 5, 300), 
       ('x1y2z3a4', 'luxo', 2, 2, 450),
       ('f1g2h3i4', 'luxo', 2, 2, 455),
       ('n1o2p3q4', 'luxo', 2, 2, 335),
       ('v1w2x3y5', 'luxo', 2, 2, 450),
       ('v1w2x3y6', 'luxo', 2, 2, 610),
       ('v1w2x3y7', 'luxo', 2, 2, 1500);



INSERT INTO Motociclo(codigo, segmento, cilindrada)
VALUES ('m1n2o3p4', 'Grand_Turismo', 600),
       ('q1r2s3t4', 'Grand_Turismo', 1000),
       ('z1a2b3c4', 'Todo_terreno', 234),
       ('b1c2d3e4', 'Todo_terreno', 373),
       ('z1a2b3c5', 'Sport', 720),
       ('j1k2l3m4', 'Sport', 1103),
       ('r1s2t3u4', 'Grand_Turismo', 1746),
       ('z1a2b3c6', 'Cruiser', 450),
       ('m1n2o3p5', 'Cruiser', 250),
       ('m2n3o4p5', 'Touring', 1200),
       ('m3n4o5p6', 'Sport', 750),
       ('m4n5o6p7', 'Quadriciclos', 500),
       ('m5n6o7p8', 'Motos125', 125);


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
VALUES ('2024-01-01', 15000.00, 'a3f5b2c1', 102),
       ('2024-01-02', 20000.00, 'd4e6g7h8', 103),
       ('2024-01-03', 25000.00, 'b4g6h7j8', 103),
       ('2024-01-04', 30000.00, 'c5h7i8j9', 102),
       ('2024-02-01', 8000.00, 'm1n2o3p4', 101),
       ('2024-02-02', 12000.00, 'q1r2s3t4', 101),
       ('2024-02-03', 35000.00, 'v1w2x3y4', 101),
       ('2024-02-04', 15000.00, 'z1a2b3c4', 103),
       ('2024-03-01', 40000.00, 'x1y2z3a4', 104),
       ('2024-03-02', 13000.00, 'b1c2d3e4', 105),
       ('2024-03-03', 60000.00, 'f1g2h3i4', 106),
       ('2024-03-04', 25000.00, 'j1k2l3m4', 107),
       ('2024-03-05', 55000.00, 'n1o2p3q4', 108),
       ('2024-03-06', 20000.00, 'r1s2t3u4', 109),
       ('2024-04-01', 200000.00, 'v1w2x3y5', 112),
       ('2024-04-02', 5500.00, 'z1a2b3c5', 110),
       ('2024-04-03', 260000.00, 'v1w2x3y6', 111),
       ('2024-04-04', 9500.00, 'z1a2b3c6', 111),
       ('2024-04-05', 3000000.00, 'v1w2x3y7', 112),
       ('2024-04-06', 10000.00, 'm1n2o3p5', 103),
       ('2024-04-07', 15000.00, 'm2n3o4p5', 105),
       ('2024-04-08', 20000.00, 'm3n4o5p6', 106),
       ('2024-04-09', 25000.00, 'm4n5o6p7', 110),
       ('2024-04-10', 30000.00, 'm5n6o7p8', 111),
       ('2024-04-11', 10000.00, 'jdlkalx0', 100),
       ('2024-04-12', 15000.00, 'h797sa8s', 101),
       ('2024-04-13', 20000.00, 's9a8dhaz', 102),
       ('2024-04-14', 25000.00, 'c1o2m3p4', 103),
       ('2024-04-15', 30000.00, 'f1a2m3i4', 104),
       ('2024-04-16', 35000.00, 'moask781', 105);
        



INSERT INTO Compra (num_venda, data_compra,  id_comprador)
VALUES (10003, '2024-01-01', 110),
       (10008, '2024-01-02', 105),
       (10010, '2024-01-03', 106),
       (10011, '2024-03-04', 112),
       (10018, '2024-04-05', 108),
       (10026, '2024-04-05', 108);


INSERT INTO Avaliacao (num_compra, avaliacao, comentario)
VALUES (1000, 10, 'Excelente compra'),
       (1001, 8, 'Bom negocio'),
       (1004, 3, 'Pessimo negocio'),
       (1005, 7, 'Adorei o material');


