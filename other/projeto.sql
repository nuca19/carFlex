GO

CREATE TABLE Utilizador(
    id INT,
	nif INT,
	nome VARCHAR(50),
	endereco VARCHAR(50),
    vendedor_id INT,
    PRIMARY KEY(id)
);


CREATE TABLE Motociclo(
    codigo VARCHAR(8),
    segmento VARCHAR(50),
    cilindrada INT,
    PRIMARY KEY(codigo)
);

CREATE TABLE Automovel(
    codigo VARCHAR(8),
    segmento VARCHAR(50),
    num_portas INT,
    num_lugares INT,
    cavalos INT,
    PRIMARY KEY(codigo)
);

CREATE TABLE Veiculo(
    codigo VARCHAR(8),
    automovel_codigo VARCHAR(8),
    motociclo_codigo VARCHAR(8),
    ano INT,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    km INT,
    combustivel VARCHAR(50),
    estado VARCHAR(50),
    tipo_caixa VARCHAR(50),
    PRIMARY KEY(codigo),
    FOREIGN KEY (automovel_codigo) REFERENCES Automovel(codigo) ON DELETE CASCADE,
    FOREIGN KEY (motociclo_codigo) REFERENCES motociclo(codigo) ON DELETE CASCADE,
    CONSTRAINT fk_veiculo_codigo CHECK (
        (automovel_codigo IS NOT NULL AND motociclo_codigo IS NULL AND codigo = automovel_codigo) OR
        (automovel_codigo IS NULL AND motociclo_codigo IS NOT NULL AND codigo = motociclo_codigo)
    )
);

CREATE TABLE Anuncio_venda(
    numero INT,
    data_venda DATE,
    preco DECIMAL,
    codigo_veiculo VARCHAR(8),
    id_vendedor INT,
    PRIMARY KEY(numero),
    FOREIGN KEY (codigo_veiculo) REFERENCES Veiculo(codigo),
    FOREIGN KEY (id_vendedor) REFERENCES Utilizador(id)
);

CREATE TABLE Compra(
    numero INT,
    num_venda INT,
    data_compra DATE,
    id_comprador INT,
    PRIMARY KEY(numero),
    FOREIGN KEY (num_venda) REFERENCES Anuncio_venda(numero),
    FOREIGN KEY (id_comprador) REFERENCES Utilizador(id)
);


CREATE TABLE Avaliacao(
    numero int,
    num_compra INT,
    avaliacao INT,
    comentario VARCHAR,
    PRIMARY KEY(numero),
    FOREIGN KEY (num_compra) REFERENCES Compra(numero)
);