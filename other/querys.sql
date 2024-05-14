-- Insert into Automovel
INSERT INTO Automovel(codigo, segmento, num_portas, num_lugares, cavalos)
VALUES ('a3f5b2c1', 'Sedan', 4, 5, 70),
       ('d4e6g7h8', 'normal', 5, 7, 200);

-- Insert into Veiculo
INSERT INTO Veiculo(codigo, automovel_codigo, motociclo_codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa)
VALUES ('a3f5b2c1', 'a3f5b2c1', NULL, 2020, 'Fiat', '500', 7000, 'Gasolina', 'Novo', 'Automatico'),
       ('d4e6g7h8', 'd4e6g7h8', NULL, 2018, 'Mercedes', 'Classe A', 20000, 'Gasolina', 'Usado', 'Manual');

--create anuncios
INSERT INTO Anuncio_venda(numero, data_venda, preco, codigo_veiculo, id_vendedor)
VALUES (1, '2022-01-01', 15000.00, 'a3f5b2c1', 1),
       (2, '2022-01-02', 20000.00, 'd4e6g7h8', 2);

INSERT INTO Utilizador(id, nif, nome, endereco, vendedor_id)
VALUES (1, 123456789, 'User 1', 'Address 1', 1),
       (2, 987654321, 'User 2', 'Address 2', 2);




-- Delete from Automovel
DELETE FROM Automovel WHERE codigo IN (3);

-- Get veiculos
SELECT marca, modelo, cavalos
FROM (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)

-- Get all anuncios
SELECT numero, modelo, cavalos, km, preco
FROM Anuncio_venda JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo