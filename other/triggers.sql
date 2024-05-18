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