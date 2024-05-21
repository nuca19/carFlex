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
        SELECT Veiculo.codigo, numero, marca, modelo, ano, km, preco, tipo
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_nao_vendidos JOIN Veiculo ON anuncios_nao_vendidos.codigo_veiculo = Veiculo.codigo;
    END;

DROP PROCEDURE anuncios_automovel;

CREATE PROCEDURE anuncios_automovel
AS
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_automovel JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)
        ON anuncios_automovel.codigo_veiculo = Veiculo.codigo
    END;

Create PROCEDURE anuncios_motociclo
AS
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_motociclo JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo)
        ON anuncios_motociclo.codigo_veiculo = Veiculo.codigo
    END;



CREATE PROCEDURE filter_anuncios
    @tipo nvarchar(50) = NULL,
    @marca nvarchar(50) = NULL,
    @segmento nvarchar(50) = NULL,
    @ano int = NULL,
    @km int = NULL
AS
BEGIN
    IF @tipo = 'automovel' OR @tipo IS NULL
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa
        FROM Anuncio_venda 
        JOIN Veiculo ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
        JOIN Automovel ON Veiculo.codigo=Automovel.codigo
        WHERE Anuncio_venda.numero NOT IN (SELECT num_venda FROM Compra)
        AND (@tipo IS NULL OR tipo = @tipo) 
        AND (@marca IS NULL OR marca = @marca) 
        AND (@segmento IS NULL OR segmento = @segmento)
        AND (@ano IS NULL OR ano >= @ano) 
        AND (@km IS NULL OR km >= @km)
    END
    ELSE IF @tipo = 'motociclo' OR @tipo IS NULL
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa
        FROM Anuncio_venda 
        JOIN Veiculo ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
        JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo
        WHERE Anuncio_venda.numero NOT IN (SELECT num_venda FROM Compra)
        AND (@tipo IS NULL OR tipo = @tipo) 
        AND (@marca IS NULL OR marca = @marca) 
        AND (@segmento IS NULL OR segmento = @segmento)
        AND (@ano IS NULL OR ano >= @ano) 
        AND (@km IS NULL OR km >= @km)
    END
END


CREATE PROCEDURE anuncioveiculototal (@codigo_veiculo VARCHAR(8))
AS
BEGIN
    DECLARE @veiculo_type VARCHAR(255);
    SELECT @veiculo_type = tipo FROM Veiculo WHERE codigo = @codigo_veiculo;

    IF @veiculo_type = 'automovel'
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa
        FROM Anuncio_venda 
        JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) 
        ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
        WHERE Veiculo.codigo = @codigo_veiculo;
    END
    ELSE IF @veiculo_type = 'motociclo'
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa
        FROM Anuncio_venda 
        JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo) 
        ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
        WHERE Veiculo.codigo = @codigo_veiculo;
    END
END;