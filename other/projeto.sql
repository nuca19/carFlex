GO

CREATE TABLE Utilizador(
    id INT IDENTITY(100,1),
    nif INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    endereco VARCHAR(50) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    pass_word VARCHAR(250) NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Veiculo(
    codigo VARCHAR(8) NOT NULL,
    ano INT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    km INT NOT NULL,
    combustivel VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    tipo_caixa VARCHAR(50) NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    PRIMARY KEY(codigo),
);

CREATE TABLE Motociclo(
    codigo VARCHAR(8) NOT NULL,
    segmento VARCHAR(50) NOT NULL,
    cilindrada INT NOT NULL,
    FOREIGN KEY(codigo) REFERENCES Veiculo(codigo),
    PRIMARY KEY(codigo)
);


CREATE TABLE Automovel(
    codigo VARCHAR(8) NOT NULL,
    segmento VARCHAR(50) NOT NULL,
    num_portas INT NOT NULL,
    num_lugares INT NOT NULL,
    cavalos INT NOT NULL,
    FOREIGN KEY(codigo) REFERENCES Veiculo(codigo),
    PRIMARY KEY(codigo)
);


CREATE TABLE Anuncio_venda(
    numero INT IDENTITY(10000,1),
    data_venda DATE NOT NULL,
    preco DECIMAL NOT NULL,
    codigo_veiculo VARCHAR(8) NOT NULL,
    id_vendedor INT NOT NULL,
    PRIMARY KEY(numero),
    FOREIGN KEY (codigo_veiculo) REFERENCES Veiculo(codigo),
    FOREIGN KEY (id_vendedor) REFERENCES Utilizador(id)
);

CREATE TABLE Compra(
    numero INT IDENTITY(1000,1),
    num_venda INT NOT NULL,
    data_compra DATE NOT NULL,
    id_comprador INT NOT NULL,
    PRIMARY KEY(numero),
    FOREIGN KEY (num_venda) REFERENCES Anuncio_venda(numero),
    FOREIGN KEY (id_comprador) REFERENCES Utilizador(id)
);


CREATE TABLE Avaliacao(
    numero INT IDENTITY(5000,1),
    num_compra INT NOT NULL,
    avaliacao INT NOT NULL,
    comentario VARCHAR(250),
    PRIMARY KEY(numero),
    FOREIGN KEY (num_compra) REFERENCES Compra(numero)
);