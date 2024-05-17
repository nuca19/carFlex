GO

CREATE TABLE Utilizador(
    id INT,
	nif INT,
	nome VARCHAR(50),
	endereco VARCHAR(50),
    username VARCHAR(50),
    pass_word VARCHAR(250),
    PRIMARY KEY(id)
);

CREATE TABLE Veiculo(
    codigo VARCHAR(8),
    ano INT,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    km INT,
    combustivel VARCHAR(50),
    estado VARCHAR(50),
    tipo_caixa VARCHAR(50),
    tipo VARCHAR(50),
    PRIMARY KEY(codigo),
);

CREATE TABLE Motociclo(
    codigo VARCHAR(8),
    segmento VARCHAR(50),
    cilindrada INT,
    FOREIGN KEY(codigo) REFERENCES Veiculo(codigo),
    PRIMARY KEY(codigo)
);

CREATE TABLE Automovel(
    codigo VARCHAR(8),
    segmento VARCHAR(50),
    num_portas INT,
    num_lugares INT,
    cavalos INT,
    FOREIGN KEY(codigo) REFERENCES Veiculo(codigo),
    PRIMARY KEY(codigo)
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