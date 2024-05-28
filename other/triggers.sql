CREATE TRIGGER prevent_purchase
ON Compra
INSTEAD OF INSERT
AS
BEGIN 
    -- Check if the buyer is the seller
    IF EXISTS ( 
        SELECT 1 
        FROM inserted i
        JOIN Anuncio_venda a ON i.num_venda = a.numero
        WHERE i.id_comprador = a.id_vendedor
    )
    BEGIN
        RAISERROR ('Nao pode comprar um anuncio seu', 16, 1);
    END
    
    ELSE IF EXISTS (
        SELECT 1 
        FROM Compra c
        JOIN inserted i ON c.num_venda = i.num_venda
    )
    BEGIN
        RAISERROR ('Veiculo ja comprado', 16, 1);
    END
    ELSE
    BEGIN
        INSERT INTO Compra
        SELECT * FROM inserted
    END
END;

-- Trigger to delete Avaliacao rows when a Compra row is deleted
CREATE TRIGGER delete_avaliacao
ON Compra
INSTEAD OF DELETE
AS
BEGIN
    -- Delete Avaliacao rows
    DELETE FROM Avaliacao 
    WHERE num_compra IN (SELECT numero FROM deleted);

    -- Delete Compra rows
    DELETE FROM Compra 
    WHERE numero IN (SELECT numero FROM deleted);
END;