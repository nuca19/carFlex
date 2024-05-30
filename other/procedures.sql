

DROP PROCEDURE ***

-- get anuncios to show in the cards
CREATE PROCEDURE anuncios_automovel
AS
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_automovel JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo)
        ON anuncios_automovel.codigo_veiculo = Veiculo.codigo
    END;

CREATE PROCEDURE anuncios_motociclo
AS
    BEGIN
        SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa
        FROM (SELECT * FROM Anuncio_venda WHERE numero NOT IN (SELECT num_venda FROM Compra))
        AS anuncios_motociclo JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo)
        ON anuncios_motociclo.codigo_veiculo = Veiculo.codigo
    END;


--filter anuncios
CREATE PROCEDURE filter_anuncios
    @tipo nvarchar(50) = NULL,
    @marca nvarchar(50) = NULL,
    @segmento nvarchar(50) = NULL,
    @ano int = NULL,
    @km int = NULL,
    @combustivel nvarchar(50) = NULL,
    @estado nvarchar(50) = NULL,
    @tipo_caixa nvarchar(50) = NULL,
    @cavalos INT = NULL,
    @num_portas INT = NULL,
    @num_lugares INT = NULL,
    @cilindrada INT = NULL,
    @preco INT = NULL,
    @modelo nvarchar(50) = NULL
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
        AND (@combustivel IS NULL OR combustivel = @combustivel)
        AND (@estado IS NULL OR estado = @estado)
        AND (@tipo_caixa IS NULL OR tipo_caixa = @tipo_caixa)
        AND (@cavalos IS NULL OR cavalos >= @cavalos)
        AND (@num_portas IS NULL OR num_portas = @num_portas)
        AND (@num_lugares IS NULL OR num_lugares = @num_lugares)
        AND (@preco IS NULL OR preco >= @preco)
        AND (@modelo IS NULL OR modelo LIKE '%' + @modelo + '%')
        
    END
    
    IF @tipo = 'motociclo' OR @tipo IS NULL
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
        AND (@combustivel IS NULL OR combustivel = @combustivel)
        AND (@estado IS NULL OR estado = @estado)
        AND (@tipo_caixa IS NULL OR tipo_caixa = @tipo_caixa)
        AND (@cilindrada IS NULL OR cilindrada >= @cilindrada)
        AND (@preco IS NULL OR preco >= @preco)
        AND (@modelo IS NULL OR modelo LIKE '%' + @modelo + '%')
    END
END


-- get full anuncio fot individual anuncio page (can show evaluation and buy info if purchased)
CREATE PROCEDURE anuncioveiculototal (@codigo_veiculo VARCHAR(8))
AS
BEGIN
    DECLARE @veiculo_type VARCHAR(255);
    SELECT @veiculo_type = tipo FROM Veiculo WHERE codigo = @codigo_veiculo;

    IF @veiculo_type = 'automovel'
    BEGIN
        SELECT Veiculo.codigo, Anuncio_venda.numero, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa, Compra.numero, Compra.data_compra, Avaliacao.avaliacao, Avaliacao.comentario
        FROM Anuncio_venda 
        JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) 
        ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
        LEFT JOIN Compra ON Anuncio_venda.numero = Compra.num_venda
        LEFT JOIN Avaliacao ON Compra.numero = Avaliacao.num_compra
        WHERE Veiculo.codigo = @codigo_veiculo;
    END
    ELSE IF @veiculo_type = 'motociclo'
    BEGIN
        SELECT Veiculo.codigo, Anuncio_venda.numero, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa, Compra.numero, Compra.data_compra, Avaliacao.avaliacao, Avaliacao.comentario
        FROM Anuncio_venda 
        JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo) 
        ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
        LEFT JOIN Compra ON Anuncio_venda.numero = Compra.num_venda
        LEFT JOIN Avaliacao ON Compra.numero = Avaliacao.num_compra
        WHERE Veiculo.codigo = @codigo_veiculo;
    END
END;


-- get full anuncio by user
CREATE PROCEDURE anuncioveiculototalByUser (@id_vendedor INT)
AS
BEGIN
    DECLARE @veiculo_type VARCHAR(255);
    DECLARE @codigo_veiculo VARCHAR(8);

    DECLARE veiculo_cursor CURSOR FOR 
    SELECT codigo_veiculo FROM Anuncio_venda WHERE id_vendedor = @id_vendedor;

    OPEN veiculo_cursor;
    FETCH NEXT FROM veiculo_cursor INTO @codigo_veiculo;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @veiculo_type = tipo FROM Veiculo WHERE codigo = @codigo_veiculo;

        IF @veiculo_type = 'automovel'
        BEGIN
            SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa
            FROM Anuncio_venda 
            JOIN Veiculo ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
            JOIN Automovel ON Veiculo.codigo=Automovel.codigo
            WHERE Veiculo.codigo = @codigo_veiculo AND Anuncio_venda.id_vendedor = @id_vendedor;
        END
        ELSE IF @veiculo_type = 'motociclo'
        BEGIN
            SELECT Veiculo.codigo, numero, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa
            FROM Anuncio_venda 
            JOIN Veiculo ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
            JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo
            WHERE Veiculo.codigo = @codigo_veiculo AND Anuncio_venda.id_vendedor = @id_vendedor;
        END

        FETCH NEXT FROM veiculo_cursor INTO @codigo_veiculo;
    END

    CLOSE veiculo_cursor;
    DEALLOCATE veiculo_cursor;
END;


-- get compras by user
CREATE PROCEDURE ComprasByUser (@id_comprador INT)
AS
BEGIN
    DECLARE @veiculo_type VARCHAR(255);
    DECLARE @codigo_veiculo VARCHAR(8);

    DECLARE veiculo_cursor CURSOR FOR 
    SELECT codigo_veiculo FROM Compra JOIN Anuncio_venda ON Compra.num_venda=Anuncio_venda.numero WHERE Compra.id_comprador = @id_comprador;

    OPEN veiculo_cursor;
    FETCH NEXT FROM veiculo_cursor INTO @codigo_veiculo;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SELECT @veiculo_type = tipo FROM Veiculo WHERE codigo = @codigo_veiculo;

        IF @veiculo_type = 'automovel'
        BEGIN
            SELECT Veiculo.codigo, Compra.num_venda, marca, modelo, ano, segmento, km, preco, tipo, num_portas, num_lugares, cavalos, combustivel, estado, tipo_caixa
			FROM Compra 
			JOIN Anuncio_venda ON Compra.num_venda=Anuncio_venda.numero
			JOIN (Veiculo JOIN Automovel ON Veiculo.codigo=Automovel.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
			WHERE Veiculo.codigo = @codigo_veiculo AND Compra.id_comprador = @id_comprador;
		END
        ELSE IF @veiculo_type = 'motociclo'
        BEGIN
            SELECT Veiculo.codigo, Compra.num_venda, marca, modelo, ano, segmento, km, preco, tipo, cilindrada, combustivel, estado, tipo_caixa
			FROM Compra 
			JOIN Anuncio_venda ON Compra.num_venda=Anuncio_venda.numero
			JOIN (Veiculo JOIN Motociclo ON Veiculo.codigo=Motociclo.codigo) ON Anuncio_venda.codigo_veiculo=Veiculo.codigo
			WHERE Veiculo.codigo = @codigo_veiculo AND Compra.id_comprador = @id_comprador;
        END

        FETCH NEXT FROM veiculo_cursor INTO @codigo_veiculo;
    END

    CLOSE veiculo_cursor;
    DEALLOCATE veiculo_cursor;
END;


-- filter avaliacoes
CREATE PROCEDURE filterAvaliacoes
    @tipo nvarchar(50) = NULL,
    @marca nvarchar(50) = NULL,
    @modelo nvarchar(50) = NULL,
    @sort nvarchar(50) = NULL
AS
BEGIN
    DECLARE @sql nvarchar(max);
    SET @sql = N'SELECT Veiculo.codigo, Compra.data_compra, Avaliacao.avaliacao, Avaliacao.comentario, Veiculo.marca, Veiculo.modelo FROM Avaliacao '
    SET @sql = @sql + N'JOIN Compra ON Avaliacao.num_compra = Compra.numero '
    SET @sql = @sql + N'JOIN Anuncio_venda ON Compra.num_venda = Anuncio_venda.numero '
    SET @sql = @sql + N'JOIN Veiculo ON Anuncio_venda.codigo_veiculo = Veiculo.codigo WHERE (1=1) '
    
    IF @tipo IS NOT NULL
        SET @sql = @sql + N' AND (Veiculo.tipo = @tipo) '
    IF @marca IS NOT NULL
        SET @sql = @sql + N' AND (Veiculo.marca = @marca) '
    IF @modelo IS NOT NULL
        SET @sql = @sql + N' AND (Veiculo.modelo LIKE ''%'' + @modelo + ''%'') '

    IF @sort IS NOT NULL
    BEGIN
        IF @sort = 'highest_rating'
            SET @sql = @sql + N' ORDER BY Avaliacao.avaliacao DESC '
        ELSE IF @sort = 'lowest_rating'
            SET @sql = @sql + N' ORDER BY Avaliacao.avaliacao ASC '
        ELSE IF @sort = 'most_recent'
            SET @sql = @sql + N' ORDER BY Compra.data_compra DESC '
        ELSE IF @sort = 'oldest'
            SET @sql = @sql + N' ORDER BY Compra.data_compra ASC '
    END

    EXEC sp_executesql @sql, N'@tipo nvarchar(50), @marca nvarchar(50), @modelo nvarchar(50)', @tipo, @marca, @modelo;
END


-- create anuncio automovel
CREATE PROCEDURE CreateAnuncioAutomovel
    @codigo NVARCHAR(8),
    @ano INT,
    @marca NVARCHAR(50),
    @modelo NVARCHAR(50),
    @km INT,
    @combustivel NVARCHAR(50),
    @estado NVARCHAR(50),
    @tipo_caixa NVARCHAR(50),
    @segmento NVARCHAR(50),
    @num_portas INT,
    @num_lugares INT,
    @cavalos INT,
    @preco INT,
    @id_vendedor INT
AS
BEGIN
    INSERT INTO Veiculo (codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa, tipo)
    VALUES (@codigo, @ano, @marca, @modelo, @km, @combustivel, @estado, @tipo_caixa, 'automovel')

    INSERT INTO Automovel (codigo, segmento, num_portas, num_lugares, cavalos)
    VALUES (@codigo, @segmento, @num_portas, @num_lugares, @cavalos)

    INSERT INTO Anuncio_venda (data_venda, preco, codigo_veiculo, id_vendedor)
    VALUES (GETDATE(), @preco, @codigo, @id_vendedor)
END


-- create anuncio motociclo
CREATE PROCEDURE CreateAnuncioMotociclo
    @codigo NVARCHAR(8),
    @ano INT,
    @marca NVARCHAR(50),
    @modelo NVARCHAR(50),
    @km INT,
    @combustivel NVARCHAR(50),
    @estado NVARCHAR(50),
    @tipo_caixa NVARCHAR(50),
    @segmento NVARCHAR(50),
    @cilindrada INT,
    @preco INT,
    @id_vendedor INT
AS
BEGIN
    INSERT INTO Veiculo (codigo, ano, marca, modelo, km, combustivel, estado, tipo_caixa, tipo)
    VALUES (@codigo, @ano, @marca, @modelo, @km, @combustivel, @estado, @tipo_caixa, 'motociclo')

    INSERT INTO Motociclo (codigo, segmento, cilindrada)
    VALUES (@codigo, @segmento, @cilindrada)

    INSERT INTO Anuncio_venda (data_venda, preco, codigo_veiculo, id_vendedor)
    VALUES (GETDATE(), @preco, @codigo, @id_vendedor)
END