-- Insert into Automovel
INSERT INTO Automovel(codigo, segmento, num_portas, num_lugares, cavalos)
VALUES ('i9j2k3l4', 'Hatchback', 5, 5, 90),
       ('m5n6o7p8', 'SUV', 5, 7, 180);

-- Insert into Veiculo
INSERT INTO Veiculo(codigo, automovel_codigo, motociclo_codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa)
VALUES ('i9j2k3l4', 'i9j2k3l4', NULL, 2019, 'Volkswagen', 'Polo', 15000, 'Gasolina', 'Usado', 'Manual'),
       ('m5n6o7p8', 'm5n6o7p8', NULL, 2021, 'Audi', 'Q5', 10000, 'Diesel', 'Novo', 'Automático');


INSERT INTO Utilizador(id, nif, nome, endereco)
VALUES (101, 123456789, 'Martim Carvalho', 'Portimão'),
       (102, 987654321, 'Angela Ribeiro', 'Guimarães');

INSERT INTO Utilizador(id, nif, nome, endereco)
VALUES       (103, 123423289, 'Francisco Ribeiro', 'Guarda'),
             (104, 232436467, 'Cristiano Ronaldo', 'Madeira');


INSERT INTO Anuncio_venda(numero, data_venda, preco, codigo_veiculo, id_vendedor)
VALUES (1, '2020-01-01', 10000, 'a3f5b2c1', 101),
       (2, '2020-01-02', 20000, 'd4e6g7h8', 101);

INSERT INTO Anuncio_venda(numero, data_venda, preco, codigo_veiculo, id_vendedor)
       (3, '2021-03-24', 15000, 'i9j2k3l4', 104),
       (4, '2023-12-25', 45000, 'm5n6o7p8', 101);
