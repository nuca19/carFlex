--ORDEM INTERESSA

-- Insert into Veiculo
INSERT INTO Veiculo(codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa)
VALUES ('a3f5b2c1', 2020, 'Fiat', '500', 7000, 'Gasolina', 'Novo', 'Automatico'),
       ('d4e6g7h8', 2018, 'Mercedes', 'Classe A', 20000, 'Gasolina', 'Usado', 'Manual');

-- Insert into Automovel codigo(8chars)
INSERT INTO Automovel(codigo, segmento, num_portas, num_lugares, cavalos)
VALUES ('a3f5b2c1', 'Sedan', 4, 5, 70),
       ('d4e6g7h8', 'normal', 5, 7, 200);

--create users id(100-999 4digits)
INSERT INTO Utilizador(id, nif, nome, endereco)
VALUES (103, 123456789, 'User 1', 'Address 1'),
       (104, 987654321, 'User 2', 'Address 2');

--create anuncios (5digits)
INSERT INTO Anuncio_venda(numero, data_venda, preco, codigo_veiculo, id_vendedor)
VALUES (10000, '2022-01-01', 15000.00, 'a3f5b2c1', 103),
       (10001, '2022-01-02', 20000.00, 'd4e6g7h8', 104);








-- Delete from Automovel
DELETE FROM Automovel WHERE codigo IN (3);

-- Get veiculos
SELECT marca, modelo, cavalos
FROM (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)

-- Get all anuncios
SELECT numero, modelo, cavalos, km, preco
FROM Anuncio_venda JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo