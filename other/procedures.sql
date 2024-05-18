--apagar anuncio completo
CREATE PROCEDURE remove_anuncio @codigo_veiculo VARCHAR(8)
AS
    BEGIN
        -- Declare a variable to store the type of the vehicle
        DECLARE @type VARCHAR(50);

        -- Get the type of the vehicle
        SELECT @type = type FROM Veiculo WHERE codigo = @codigo_veiculo;

        -- Delete from Anuncio_venda where the codigo_veiculo matches
        DELETE FROM Anuncio_venda WHERE codigo_veiculo = @codigo_veiculo;

        -- If the type of the vehicle is 'Motociclo', delete from Motociclo
        IF @type = 'Motociclo' 
            DELETE FROM Motociclo WHERE codigo = @codigo_veiculo;
        -- If the type of the vehicle is 'Automovel', delete from Automovel
        ELSE IF @type = 'Automovel' 
            DELETE FROM Automovel WHERE codigo = @codigo_veiculo;

        -- Finally, delete from Veiculo where the codigo matches
        DELETE FROM Veiculo WHERE codigo = @codigo_veiculo;
    END;

    EXEC remove_anuncio @codigo_veiculo = 'codigo_veiculo';


CREATE PROCEDURE anuncios_nao_vendidos
AS
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, km, preco
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_nao_vendidos JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)
        ON anuncios_nao_vendidos.codigo_veiculo = Veiculo.codigo
        UNION ALL
        SELECT Veiculo.codigo, numero, marca, modelo, km, preco
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_nao_vendidos JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo)
        ON anuncios_nao_vendidos.codigo_veiculo = Veiculo.codigo;

    END;

EXEC anuncios_nao_vendidos;

