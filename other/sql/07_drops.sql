---DROP TABLES
DROP TABLE IF EXISTS Avaliacao;
DROP TABLE IF EXISTS Compra;
DROP TABLE IF EXISTS Anuncio_venda;
DROP TABLE IF EXISTS Motociclo;
DROP TABLE IF EXISTS Automovel;
DROP TABLE IF EXISTS Veiculo;
DROP TABLE IF EXISTS Utilizador;

---DELETE DATA
DELETE FROM Avaliacao;
DELETE FROM Compra;
DELETE FROM Anuncio_venda;
DELETE FROM Motociclo;
DELETE FROM Automovel;
DELETE FROM Veiculo;
DELETE FROM Utilizador;

--Delete Anuncio
DELETE FROM Anuncio_venda WHERE numero = ?

--Delete Compra
DELETE FROM Compra WHERE numero=?;