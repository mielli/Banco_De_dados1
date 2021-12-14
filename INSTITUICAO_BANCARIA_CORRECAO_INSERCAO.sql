--------- https://github.com/mielli/Banco_De_dados1 ---------

DROP TABLE IF EXISTS AGENCIA_EMPREGA_FUNCIONARIO;
DROP TABLE IF EXISTS SUPERVISOR_SUPERVISIONADO;
DROP TABLE IF EXISTS CLIENTE_NEGOCIA_SERVICO;
DROP TABLE IF EXISTS CONTA_TEM_CLIENTE;
DROP TABLE IF EXISTS AGENCIA_ADMINISTRA_CONTA;
DROP TABLE IF EXISTS AGENCIA_TEM_CAIXA_ELETRO;
DROP TABLE IF EXISTS BANCO_POSSUI_AGENCIA;
DROP TABLE IF EXISTS EMPRESTIMO;
DROP TABLE IF EXISTS FINANCIAMENTO_AUTOMOVEL;
DROP TABLE IF EXISTS FINANCIAMENTO_IMOVEL;
DROP TABLE IF EXISTS SERVICO;
DROP TABLE IF EXISTS FUNCIONARIO;
DROP TABLE IF EXISTS PESSOA_JURIDICA;
DROP TABLE IF EXISTS PESSOA_FISICA;
DROP TABLE IF EXISTS CLIENTE;
DROP TABLE IF EXISTS CONTA_CORRENTE;
DROP TABLE IF EXISTS CONTA_POUPANCA;
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
	cep char(9),
    PRIMARY KEY(nome_banco)
);

CREATE TABLE AGENCIA (
	num_agencia INT,
    nome_banco VARCHAR(100),
    telefone CHAR(11),
    cpf_gerente char(14),
	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(30),
	cidade varchar(50),
	estado char(2),
	cep char(9),
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
    cpf_cliente char(14),
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
	cpf CHAR(14),
    nome VARCHAR(100),
	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(100),
	cidade varchar(100),
	estado char(2),
	cep char(9),
    salario FLOAT,
    data_inicio DATE,
    telefone char(15),
    PRIMARY KEY(cpf)
);

CREATE TABLE CLIENTE (
	id_cliente int,
    telefone CHAR(14),
    nome VARCHAR(50),
    data_nascimento DATE,
 	logradouro varchar(100),
	numero int,
	complemento varchar(100),
	bairro varchar(30),
	cidade varchar(50),
	estado char(2),
	cep char(9),   
	PRIMARY KEY (id_cliente)
);

CREATE TABLE PESSOA_JURIDICA (
	id_cliente int,
    cnpj CHAR(18),
    nome_fantasia VARCHAR(100),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente) ON DELETE CASCADE
);

CREATE TABLE PESSOA_FISICA (
	id_cliente int,
    cnpf CHAR(14),
    rg CHAR(10),
    reservista CHAR(20),
    estado_civil VARCHAR(20),
    profissao VARCHAR(25),
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente) ON DELETE CASCADE
);

CREATE TABLE SERVICO (
	num_contrato int,
    id_cliente int,
    cpf_funcionario char(14),
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
    FOREIGN KEY (num_agencia) REFERENCES AGENCIA(num_agencia),
    PRIMARY KEY(num_agencia)
);

CREATE TABLE AGENCIA_TEM_CAIXA_ELETRO (
	num_agencia INT,
    num_terminal INT,
    data_instalacao DATE,
    FOREIGN KEY (num_terminal) REFERENCES CAIXA_ELETRONICO (num_terminal),
    PRIMARY KEY (num_agencia)
);

CREATE TABLE AGENCIA_ADMINISTRA_CONTA (
	num_conta INT,
    num_agencia INT,
    data_abertura DATE,
    PRIMARY KEY (num_conta)
);

CREATE TABLE AGENCIA_EMPREGA_FUNCIONARIO (
	num_agencia INT,
    cpf CHAR(14),
    FOREIGN KEY (cpf) REFERENCES FUNCIONARIO (cpf),
    PRIMARY KEY(num_agencia, cpf)
);

CREATE TABLE CONTA_TEM_CLIENTE (
	id_cliente INT,
    num_conta int,
    PRIMARY KEY (num_conta, id_cliente)
);

CREATE TABLE CLIENTE_NEGOCIA_SERVICO (
	id_cliente INT,
    cpf CHAR(14),
    num_contrato INT,
    PRIMARY KEY (id_cliente, cpf, num_contrato)
);

CREATE TABLE SUPERVISOR_SUPERVISIONADO (
	cpf_supervisor CHAR(14),
    cpf_func CHAR(14),
    FOREIGN KEY (cpf_supervisor) REFERENCES FUNCIONARIO (cpf),
    FOREIGN KEY (cpf_func) REFERENCES FUNCIONARIO (cpf),
    PRIMARY KEY (cpf_supervisor, cpf_func)
);

---------------- INSERÇÕES ENTIDADES ------------------------------------------------

INSERT INTO BANCO(nome_banco, data_fundacao, logradouro, numero, complemento, bairro, cidade, estado, cep) 
VALUES ('BancoX', '1993-08-28', 'Rua Major Carvalho Filho', 1355, 'Andar 2, sala 102', 'Vila Pequi', 'Campo Mourão', 'PR', 87303180);

INSERT INTO AGENCIA (num_agencia, nome_banco, telefone, cpf_gerente, logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES (2992, 'BancoX', '01633352520', '412.521.184-52', 'Avenida Floriano Peixoto', 1255,' ', 'Centro', 'Araraquara', 'SP', 14810121),
(0762, 'BancoX', '01633227070', '501.025.484-33', 'Avenida Joaquim Borba ', 187,' ', 'Bismarque Domingues', 'Sao Carlos', 'SP', 14821314),
(4544, 'BancoX', '01633391214', '381.221.884-35', 'Rua Papa Pio XII ', 255,' ', 'Vila Capadocio', 'Ribeirao Preto', 'SP', 12110030),
(2808, 'BancoX', '01141142500', '534.133.720-62', 'Avenida Claudino Claudianos', 703, 'Q28L10 ', 'Altos da Fonte Nova', 'Sao Paulo', 'SP', 02512121),
(3433, 'BancoX', '04433287330', '283.112.841-53', 'Avenida Tapajos ', 155, ' ', 'Centro', 'Campo Mourao', 'PR', 83481012),
(8213, 'BancoX', '04431135252', '190.821.012-25', 'Rua Monteiro Lobato', 550, ' ', 'Castelo Branco', 'Cascavel', 'PR' , 80310073),
(1672, 'BancoX', '01622523043', '012.801.422-72', 'Avenida Washington Luiz', 314,' ', 'Uvaia', 'Matao', 'SP', 124100115),
(8069, 'BancoX', '08140044001', '497.883.015-29', 'Rua 1 de Maio', 381,' ', 'Centro', 'Recife', 'PE', 44810381),
(1401, 'BancoX', '01422335520', '712.220.441-62', 'Rua Luana Marquito', 614,' ', 'Jardim Primavera', 'Ribeirao Bonito', 'SP', 11800299),
(9922, 'BancoX', '06131395220', '942.314.084-48', 'Alameda Palmares', 897,' ', 'Vale Verde', 'Brasilia', 'DF', 14124014),
(2447, 'BancoX', '04130300058', '622.156.014-37', 'Rua Gilbertino Machado', 255,' ', 'Hortencias', 'Campo Largo', 'PR', 81100201);

INSERT INTO CAIXA_ELETRONICO (num_terminal, num_modelo) 
VALUES (0011, 2021028), (0012, 2021028), (0111, 2021028), (0118, 2021028), (00830, 2021113), (00811, 2021113), (00820, 2021113), 
(00818, 2021113), (11008, 2021046), (11011, 2021046);

INSERT INTO CONTA (num_conta)
VALUES (00022), (00014), (00080), (00069), (00071), (20448), (20397), (20666), (20288), (20300);

INSERT INTO CLIENTE (id_cliente, telefone, nome, data_nascimento, logradouro, numero, complemento, bairro, cidade, estado, cep)
VALUES (002882, '16999921515', 'Clayton Rasta', '1979-12-28', 'Rua Aldo Lupo', 320, ' ', 'Caramuru', 'Vila Redonda', 'SP', 14818125),
(001401, '48988992012', 'Maicon Douglas Marques Antunes', '1972-2-2', 'Rua Ipes Anglo saxônicos', 1066, 'Próximo ao assentamento', 'Green Valley', 'Criciuma', 'SC', 12112555),
(000412, '16988817374', 'Alex Alberto dos Santos', '1984-06-25', 'Avenida Waldomiro Doguihéive', 106, ' ', 'Vila Xavier', 'Araraquara', 'SP', 52580014),
(006998, '41988773142', 'Mateus Róqueli', '1991-01-22', 'Rua Sandra Candalarrara', 668, ' ', 'Constancio', 'Joinville', 'SC', 14810193),
(003341, '16999188814', 'Eva Isabel', '1961-06-04', 'Rua Treze de Maio', 2106, ' ', 'Jardim América', 'São Carlos', 'SP', 14810028),
(000312, '21999011239', 'Larissa Pavão', '1995-09-11', 'Avenida Manoel Alucigleisson', 1326, 'Prédio de esquina', 'Francisco Vintem', 'Ibaté', 'SP', 14615214),
(002142, '12988778173', 'Walter Hibota', '1990-01-02', 'Avenida Interventor Manoel Ribas', 1906, ' ', 'Centro', 'Rio de Janeiro', 'RJ', 25800145),
(001270, '39998801029', 'Eder Jacobino', '1978-12-05', 'Rua Franciscano Nicolau', 2061, ' ', 'Jardim Vidal', 'Campo Largo', 'PR', 81300208),
(004198, '16997877737', 'Esiquiel Sabino', '1997-07-04', 'Avenida Rio de Janeiro', 784, ' ', 'Cruzeiro do Sul', 'Matao', 'SP', 14810525),
(004214, '63999210828', 'Joelma Correia', '1993-01-08', 'Rua Clemente Malagueta', 206, ' ', 'Selmi Dei', 'Bueno de Andrade', 'SP', 14810309);

INSERT INTO FUNCIONARIO (cpf, nome, logradouro, numero, complemento, bairro, cidade, estado, cep, salario, data_inicio, telefone) 
VALUES ('415.225.336-62', 'Claudia Nascimento', 'Rua Magda Camargo', 330, ' ', 'Cidade Nova', 'Ortolandia', 'SP', 14200125, 9000.00, '1999-04-18', 14997871714),
('255.720.636-42', 'Jandira Pereira Cardoso', 'Avenida Vasco da Gama', 1012, ' ', 'Carmelitas', 'Sao Paulo', 'SP', 18112048, 7200.00, '2002-11-23', 11997992100),
('508.200.036-33', 'Ketlyn Bergamo', 'Rua Souza Cruz', 1001, ' ', 'Adalberto Roxo', 'Joinville', 'SC', 80010388, 3150.00, '2009-10-12', 21997210015),
('200.422.828-22', 'Dandara Fernandez ', 'Rua Camargo Corrêa', 630, 'Apartamente 114 Bloco 18 ', 'Laranjal', 'Campinas', 'SP', 14800508, 3150.00, '2009-04-08', 11997992524),
('631.022.371-66', 'Vesputio Tartonelli', 'Rua Padre Malaquias', 1236, ' ', 'Acapulco', 'Santa Rita do Passa Quatro', 'SP', 14510200, 4200.00, '2004-11-14', 17997212888),
('601.080.715-55', 'Fabiola Costa', 'Avenida Jorge Walter', 1300, ' ', 'Jardim Paraiso', 'Araraquara', 'SP', 14810314, 6300.00, '2000-03-28', 16997198524),
('422.303.101-44', 'Jackson Ferraz', 'Rua Sabatico Miguel', 608, ' ', 'Santo Antonio', 'Itu', 'SP', 11100180, 3150.00, '2009-06-11', 11997371407),
('220.722.216-35', 'Sandra Cavalcante ', 'Avenida Bahia', 180, 'Apartamente 108 Bloco 3 ', 'Vista Alegre', 'São Carlos', 'SP', 14380115, 7500.00, '2000-12-07', 16997631839),
('838.142.373-67', 'Antonio Carlos Clemente', 'Alameda São Caetano', 832, ' ', 'Jardim Paulistano', 'Campo Largo', 'PR', 84180125, 9000.00, '1999-09-03', 41988186676),
('646.108.029-22', 'Sabrina Castelo', 'Rua 22 de agosto', 706, ' ', 'Pedregal', 'Curitiba', 'PR', 94800105, 6500.00, '2001-09-09', 41997990018);

INSERT INTO SERVICO (num_contrato) 
VALUES (2021010), (2021012), (2021014), (2021016), (2021018), (2021020), (2021022), (2021024), (2021026), (2021028);


---------------- INSERÇÕES RELACIONAMENTOS ------------------------------------------------

INSERT INTO BANCO_POSSUI_AGENCIA (nome_banco, num_agencia, inauguracao) 
VALUES ('BancoX', 2992, '1999-05-20'), ('BancoX', 0762, '2001-06-12'), 
('BancoX', 4544, '1998-02-10'), ('BancoX', 2808, '2005-10-10'), ('BancoX', 3433, '2001-02-25'), ('BancoX', 8213, '1997-06-18'), 
('BancoX', 1672, '2005-07-08'), ('BancoX', 8069, '1993-08-28'), ('BancoX', 1401, '1994-06-12'), ('BancoX', 9922, '2001-10-08'), 
('BancoX', 2447, '2001-10-08');

INSERT INTO AGENCIA_TEM_CAIXA_ELETRO (num_agencia, data_instalacao, num_terminal) 
VALUES (2992, '1999-05-20', 11), (0762, '2001-06-12', 12), (4544, '1998-02-10', 111), (2808, '2005-10-10', 118), (3433, '2001-02-25', 811), 
(8213, '1997-06-18', 818), (1672, '2005-07-08', 820), (8069, '1993-08-28', 830), (1401, '1994-06-12', 11008), (9922, '2001-10-08', 11011);

INSERT INTO AGENCIA_ADMINISTRA_CONTA (num_agencia, num_conta, data_abertura) 
VALUES (14, 762, '2010-05-28'), (22, 1401, '2019-01-18'), (69, 1672, '2020-11-08'), (71, 2447, '2007-03-8'), (80, 2808, '2001-07-11'), 
(20288, 2992, '2010-05-28'), (20300, 3433, '2017-09-04'), (20397, 4544, '2016-02-16'), (20448, 8069, '2009-01-22'), (20666, 9922, '2018-08-28');

INSERT INTO CONTA_TEM_CLIENTE (id_cliente, num_conta) 
VALUES (14, 312), (22, 412), (69, 1270), (71, 1401), (80, 2142), (20288, 2882), (20300, 3341), (20397, 4198), (20448, 4214), (20666, 6998);

INSERT INTO CLIENTE_NEGOCIA_SERVICO (id_cliente, cpf, num_contrato) 
VALUES (312, '200.422.828-22', 312200), (412, '220.722.216-35', 412220), (1270, '255.720.636-42', 312200), (1401, '415.225.336-62', 001401),
(2142, '422.303.101-44', 002142), (2882, '508.200.036-33', 002882), (3341, '601.080.715-55', 003341), (4198, '631.022.371-66', 004198),
(4214, '646.108.029-22', 004214), (6998, '838.142.373-67', 006998);

INSERT INTO SUPERVISOR_SUPERVISIONADO (cpf_supervisor, cpf_func) 
VALUES ('415.225.336-62', '422.303.101-44'), ('415.225.336-62', '255.720.636-42'), ('415.225.336-62', '220.722.216-35'), 
('415.225.336-62', '200.422.828-22'), ('838.142.373-67', '646.108.029-22'), ('838.142.373-67', '631.022.371-66'), 
('838.142.373-67', '601.080.715-55'), ('838.142.373-67', '508.200.036-33');


INSERT INTO AGENCIA_EMPREGA_FUNCIONARIO (num_agencia, cpf) 
VALUES (14, '415.225.336-62'), (14, '422.303.101-44'), (14, '255.720.636-42'), (14, '220.722.216-35'), (14, '200.422.828-22'), 
(20288, '838.142.373-67'), (20288, '646.108.029-22'), (20288, '631.022.371-66'), (20288, '601.080.715-55'), (20288, '508.200.036-33');



