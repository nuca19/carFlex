--OTHER USED SQL QUERYS ARE IN persistence and app python files
--...

--These were mostly used in sql server management studio to test the database
-- Get veiculos
SELECT marca, modelo, cavalos
FROM (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)

-- Get motociclos
SELECT marca, modelo, cilindrada
FROM (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo)

-- Get all anuncios
SELECT numero, modelo, cavalos, km, preco
FROM Anuncio_venda JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo

--SELECTS
SELECT * FROM Anuncio_venda
SELECT * FROM Compra
SELECT * FROM Veiculo
--...