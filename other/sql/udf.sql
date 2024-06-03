CREATE FUNCTION udf_AveragePriceByBrand (@brand VARCHAR(50))
RETURNS INT
AS
BEGIN
    DECLARE @averagePrice INT

    SELECT @averagePrice = AVG(anuncio_venda.preco)
    FROM Anuncio_venda
    INNER JOIN Veiculo ON Anuncio_venda.codigo_veiculo = Veiculo.codigo
    INNER JOIN Automovel ON Veiculo.codigo = Automovel.codigo
    WHERE Veiculo.marca = @brand

    RETURN @averagePrice
END

--call
SELECT dbo.udf_AveragePriceByBrand('Audi') AS AudiAveragePrice,
       dbo.udf_AveragePriceByBrand('BMW') AS BMWAveragePrice,
       dbo.udf_AveragePriceByBrand('Mercedes') AS MercedesAveragePrice,
       dbo.udf_AveragePriceByBrand('Volkswagen') AS VolkswagenAveragePrice