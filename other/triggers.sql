CREATE TRIGGER prevent_duplicate_compra
ON Compra
INSTEAD OF INSERT
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM Compra c
        JOIN inserted i ON c.num_venda = i.num_venda
    )
    BEGIN
        INSERT INTO Compra
        SELECT * FROM inserted
    END
    ELSE
    BEGIN
        RAISERROR ('Veiculo ja comprado', 16, 1);
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