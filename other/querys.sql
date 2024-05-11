-- Insert into Automovel
INSERT INTO Automovel(codigo, segmento, num_portas, num_lugares, cavalos)
VALUES (3, 'Sedan', 4, 5, 70),
       (4, 'normal', 5, 7, 200);


-- Insert into Veiculo
INSERT INTO Veiculo(codigo, automovel_codigo, motociclo_codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa)
VALUES (3, 3, NULL, 2020, 'Fiat', '500', 7000, 'Gasolina', 'Novo', 'Automatico'),
		(4, 4, NULL, 2018, 'Mercedes', 'Classe A', 20000, 'Gasolina', 'Usado', 'Manual')






-- Delete from Automovel
DELETE FROM Automovel WHERE codigo IN (3);

-- Get veiculos
SELECT marca, modelo, cavalos
FROM (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)