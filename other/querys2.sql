DROP TABLE IF EXISTS Avaliacao;
DROP TABLE IF EXISTS Compra;
DROP TABLE IF EXISTS Anuncio_venda;
DROP TABLE IF EXISTS Motociclo;
DROP TABLE IF EXISTS Automovel;
DROP TABLE IF EXISTS Veiculo;
DROP TABLE IF EXISTS Utilizador;

DELETE FROM Avaliacao;
DELETE FROM Compra;
DELETE FROM Anuncio_venda;
DELETE FROM Motociclo;
DELETE FROM Automovel;
DELETE FROM Veiculo;
DELETE FROM Utilizador;

--OTHER USED VIEWS ARE IN persistence and app python files
--...

--These were used in the sql server for checking
--Delete Anuncio
DELETE FROM Anuncio_venda WHERE numero = ?

--Delete Compra
DELETE FROM Compra WHERE numero=?;

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