--------- https://github.com/mielli/Banco_De_dados1 ---------


DROP TABLE IF EXISTS SUPERVISOR_SUPERVISIONADO;
DROP TABLE IF EXISTS CLIENTE_NEGOCIA_SERVICO;
DROP TABLE IF EXISTS CLIENTE_TEM_CONTA;
DROP TABLE IF EXISTS AGENCIA_EMPREGA_FUNCIONARIO;
DROP TABLE IF EXISTS AGENCIA_ADMINISTRA_CONTA;
DROP TABLE IF EXISTS AGENCIA_TEM_CAIXA_ELETRO;
DROP TABLE IF EXISTS BANCO_POSSUI_AGENCIA;
DROP TABLE IF EXISTS FINANCIAMENTO_IMOVEL;
DROP TABLE IF EXISTS FINANCIAMENTO_AUTOMOVEL;
DROP TABLE IF EXISTS EMPRESTIMO;
DROP TABLE IF EXISTS SERVICO;
DROP TABLE IF EXISTS PESSOA_FISICA;
DROP TABLE IF EXISTS PESSOA_JURIDICA;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS CONTA_POUPANCA;
DROP TABLE IF EXISTS CONTA_CORRENTE;
DROP TABLE IF EXISTS CONTA;
DROP TABLE IF EXISTS CAIXA_ELETRONICO;
DROP TABLE IF EXISTS AGENCIA;
DROP TABLE IF EXISTS BANCO;


CREATE TABLE BANCO (
	nome_banco VARCHAR(100),
    data_fundacao DATE,
    logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(30),
	cidade varchar(50),
	estado char(2),
	cep int,
    PRIMARY KEY(nome_banco)
);

CREATE TABLE AGENCIA (
	num_agencia INT,
    nome_banco VARCHAR(100),
    telefone int,
    cpf_gerente char(11),
	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(30),
	cidade varchar(50),
	estado char(2),
	cep int,
    PRIMARY KEY (num_agencia, nome_banco)
);

CREATE TABLE CAIXA_ELETRONICO (
	num_terminal int,
    cpf_funcionario char(11),
    num_modelo int,
    PRIMARY KEY(num_terminal)

);

CREATE TABLE CONTA (
	num_conta int,
    saldo float,
    nome_cliente VARCHAR(100),
    cpf_cliente char(11),
	PRIMARY KEY(num_conta)
);

CREATE TABLE CONTA_CORRENTE (
	num_conta int,
	limite_cheque_especial FLOAT,
    tarifa float,
    FOREIGN KEY (num_conta) REFERENCES CONTA(num_conta) ON DELETE CASCADE
);

CREATE TABLE CONTA_POUPANCA (
	num_conta int,
	taxa_juros FLOAT,
    FOREIGN KEY (num_conta) REFERENCES CONTA(num_conta) ON DELETE CASCADE
);

CREATE TABLE FUNCIONARIO (
	cpf CHAR(11),
    nome VARCHAR(50),
	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(30),
	cidade varchar(50),
	estado char(2),
	cep int,
    salario FLOAT,
    data_inicio DATE,
    telefone char(11),
    PRIMARY KEY(cpf)
);

CREATE TABLE CLIENTE (
	id_cliente int,
    telefone CHAR(11),
    nome VARCHAR(50),
    data_nascimento DATE,
 	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(30),
	cidade varchar(50),
	estado char(2),
	cep int,   
	PRIMARY KEY (id_cliente)
);

CREATE TABLE PESSOA_JURIDICA (
	id_cliente int,
    cnpj CHAR(14),
    nome_fantasia VARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente) ON DELETE CASCADE
);

CREATE TABLE PESSOA_FISICA (
	id_cliente int,
    cnpf CHAR(11),
    rg CHAR(10),
    reservista CHAR(20),
    estado_civil VARCHAR(20),
    profissao VARCHAR(25),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente) ON DELETE CASCADE
);

CREATE TABLE SERVICO (
	num_contrato int,
    id_cliente int,
    cpf_funcionario char(11),
    valor_servico FLOAT,
    data_aquisacao DATE,
    valor_faltante FLOAT,
    taxa_juros FLOAT,
    PRIMARY KEY (num_contrato)
);

CREATE TABLE EMPRESTIMO (
	num_contrato int,
    id_emprestimo int,
    FOREIGN KEY (num_contrato) REFERENCES SERVICO (num_contrato) ON DELETE CASCADE
);

CREATE TABLE FINANCIAMENTO_AUTOMOVEL (
	num_contrato int,
    id_financiamento_automovel int,
    FOREIGN KEY (num_contrato) REFERENCES SERVICO (num_contrato) ON DELETE CASCADE
);

CREATE TABLE FINANCIAMENTO_IMOVEL (
	num_contrato int,
    id_financiamento_imovel int,
    FOREIGN KEY (num_contrato) REFERENCES SERVICO (num_contrato) ON DELETE CASCADE
);

---------------- RELACIONAMENTOS ------------------------------------------------

CREATE TABLE BANCO_POSSUI_AGENCIA (
	nome_banco VARCHAR(100),
    num_agencia int,
    inauguracao DATE,
    FOREIGN KEY (nome_banco) REFERENCES BANCO (nome_banco),
    FOREIGN KEY (num_agencia) REFERENCES AGENCIA(num_agencia),
    PRIMARY KEY(nome_banco, num_agencia)
);

CREATE TABLE AGENCIA_TEM_CAIXA_ELETRO (
	num_agencia INT,
    num_terminal INT,
    data_instalacao DATE,
	FOREIGN KEY (num_agencia) REFERENCES AGENCIA (num_agencia),
    FOREIGN KEY (num_terminal) REFERENCES CAIXA_ELETRONICO (num_terminal),
    PRIMARY KEY (num_agencia, num_terminal)
);

CREATE TABLE AGENCIA_ADMINISTRA_CONTA (
	num_agencia INT,
    num_conta INT,
    data_abertura DATE,
    FOREIGN KEY (num_agencia) REFERENCES AGENCIA (num_agencia),
    FOREIGN KEY (num_conta) REFERENCES CONTA (num_conta),
    PRIMARY KEY (num_agencia, num_conta)
);

CREATE TABLE AGENCIA_EMPREGA_FUNCIONARIO (
	num_agencia INT,
    cpf CHAR(11),
    FOREIGN KEY (num_agencia) REFERENCES AGENCIA (num_agencia),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIO (cpf),
    PRIMARY KEY (num_agencia, cpf)
);

CREATE TABLE CLIENTE_TEM_CONTA (
	id_cliente INT,
    num_conta int,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente),
    FOREIGN KEY (num_conta) REFERENCES CONTA (num_conta),
    PRIMARY KEY (id_cliente, num_conta)
    
);

CREATE TABLE CLIENTE_NEGOCIA_SERVICO (
	id_cliente INT,
    cpf CHAR(11),
    num_contrato INT,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIO (cpf),
    FOREIGN KEY (num_contrato) REFERENCES SERVICO (num_contrato),
    PRIMARY KEY (id_cliente, cpf, num_contrato)
);

CREATE TABLE SUPERVISOR_SUPERVISIONADO (
	cpf_supervisor VARCHAR(11),
    cpf_func VARCHAR(11),
    FOREIGN KEY (cpf_supervisor) REFERENCES FUNCIONARIO (cpf),
    FOREIGN KEY (cpf_func) REFERENCES FUNCIONARIO (cpf),
    PRIMARY KEY (cpf_supervisor, cpf_func)
);