-- Global Solution 2026.2 - CitizenTech
-- Curso: Engenharia de Software - FIAP
-- Disciplina: Database Design
-- Solucao: CalcadaLivre
-- Integrantes:
--   Enrico Bagli Borges - RM 562541
--   Henrique Infanti Coratolo - RM 561865
--   Joao Gabriel Boaventura Marques e Silva - RM 569298
-- Script D.D.L. (Oracle)

CREATE TABLE Usuario (
    id_usuario     NUMBER PRIMARY KEY,
    Nome           VARCHAR2(100) NOT NULL,
    Email          VARCHAR2(100) NOT NULL,
    Perfil         VARCHAR2(20) NOT NULL,
    Data_Cadastro  DATE NOT NULL,
    
    CONSTRAINT uk_usuario_email UNIQUE (Email),
    CONSTRAINT ck_usuario_perfil CHECK (Perfil IN ('CIDADAO', 'PCD', 'IDOSO', 'AGENTE_PUBLICO'))
);

CREATE TABLE Logradouro (
    id_logradouro  NUMBER PRIMARY KEY,
    Nome           VARCHAR2(50) NOT NULL,
    Bairro         VARCHAR2(50) NOT NULL,
    Cidade         VARCHAR2(50) NOT NULL
);

CREATE TABLE Trecho_Calcada (
    id_trecho                 NUMBER PRIMARY KEY,
    Lado                      VARCHAR2(10) NOT NULL,
    Extensao_Metros           NUMBER(6,1) NOT NULL,
    Largura_Metros            NUMBER(4,2),
    Possui_Rampa              CHAR(1) NOT NULL,
    id_logradouro  NUMBER NOT NULL,
    
    CONSTRAINT ck_trecho_calcada_lado CHECK (Lado IN ('Par', 'Impar')),
    CONSTRAINT ck_trecho_calcada_possui_rampa CHECK (Possui_Rampa IN ('S', 'N')),
    CONSTRAINT fk_trecho_calcada_logradouro FOREIGN KEY (id_logradouro)
    REFERENCES Logradouro (id_logradouro)
    
);

CREATE TABLE Tipo_Ocorrencia (
    id_tipo           NUMBER PRIMARY KEY,
    Nome              VARCHAR2(60) NOT NULL,
    Descricao         VARCHAR2(200),
    Gravidade_Padrao  NUMBER(1) NOT NULL,
    
    CONSTRAINT uk_tipo_ocorrencia_nome UNIQUE (Nome),
    CONSTRAINT ck_tipo_ocorrencia_gravidade_padrao CHECK (Gravidade_Padrao BETWEEN 1 AND 5)
);

CREATE TABLE Ocorrencia (
    id_ocorrencia             NUMBER PRIMARY KEY,
    Descricao                 VARCHAR2(300),
    Data_Registro             DATE NOT NULL,
    Status                    VARCHAR2(15) NOT NULL,
    Data_Resolucao            DATE,
    id_trecho                 NUMBER NOT NULL,
    id_usuario                NUMBER NOT NULL,
    id_tipo                   NUMBER NOT NULL,
    
    CONSTRAINT ck_ocorrencia_status CHECK (Status IN ('ABERTA', 'EM_ANALISE', 'RESOLVIDA')),
    CONSTRAINT fk_ocorrencia_trecho_calcada FOREIGN KEY (id_trecho) REFERENCES Trecho_Calcada (id_trecho),
    CONSTRAINT fk_ocorrencia_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario (id_usuario),
    CONSTRAINT fk_ocorrencia_tipo_ocorrencia FOREIGN KEY (id_tipo) REFERENCES Tipo_Ocorrencia (id_tipo)
);

CREATE TABLE Confirmacao_Ocorrencia (
    id_confirmacao            NUMBER PRIMARY KEY,
    Data_Confirmacao          DATE NOT NULL,
    Ainda_Existe              CHAR(1) NOT NULL CHECK (Ainda_Existe IN ('S', 'N')),
    Usuario_id_usuario        NUMBER NOT NULL REFERENCES Usuario (id_usuario),
    Ocorrencia_id_ocorrencia  NUMBER NOT NULL REFERENCES Ocorrencia (id_ocorrencia),
    UNIQUE (Usuario_id_usuario, Ocorrencia_id_ocorrencia)
     );
     
    -- USUARIO
INSERT INTO Usuario (id_usuario, Nome, Email, Perfil, Data_Cadastro)
VALUES (1, 'Mariana Souza', 'mariana.souza@exemplo.com', 'CIDADAO', DATE '2026-09-01');

INSERT INTO Usuario (id_usuario, Nome, Email, Perfil, Data_Cadastro)
VALUES (2, 'Carlos Eduardo Lima', 'carlos.lima@exemplo.com', 'PCD', DATE '2026-09-02');

INSERT INTO Usuario (id_usuario, Nome, Email, Perfil, Data_Cadastro)
VALUES (3, 'Helena Prado', 'helena.prado@exemplo.com', 'IDOSO', DATE '2026-09-05');

INSERT INTO Usuario (id_usuario, Nome, Email, Perfil, Data_Cadastro)
VALUES (4, 'Rafael Tavares', 'rafael.tavares@exemplo.com', 'AGENTE_PUBLICO', DATE '2026-09-08');

INSERT INTO Usuario (id_usuario, Nome, Email, Perfil, Data_Cadastro)
VALUES (5, 'Beatriz Nogueira', 'beatriz.nogueira@exemplo.com', 'CIDADAO', DATE '2026-09-10');

INSERT INTO Usuario (id_usuario, Nome, Email, Perfil, Data_Cadastro)
VALUES (6, 'Paulo Henrique Alves', 'paulo.alves@exemplo.com', 'PCD', DATE '2026-09-12');

COMMIT;


-- LOGRADOURO

INSERT INTO Logradouro (id_logradouro, Nome, Bairro, Cidade)
VALUES (1, 'Avenida Paulista', 'Bela Vista', 'Sao Paulo');

INSERT INTO Logradouro (id_logradouro, Nome, Bairro, Cidade)
VALUES (2, 'Rua Augusta', 'Consolacao', 'Sao Paulo');

INSERT INTO Logradouro (id_logradouro, Nome, Bairro, Cidade)
VALUES (3, 'Rua da Consolacao', 'Consolacao', 'Sao Paulo');

INSERT INTO Logradouro (id_logradouro, Nome, Bairro, Cidade)
VALUES (4, 'Rua Frei Caneca', 'Consolacao', 'Sao Paulo');

INSERT INTO Logradouro (id_logradouro, Nome, Bairro, Cidade)
VALUES (5, 'Alameda Santos', 'Cerqueira Cesar', 'Sao Paulo');

COMMIT;


-- TRECHO CALÇADA

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (1, 'Par', 120.0, 4.50, 'S', 1);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (2, 'Impar', 135.5, 5.00, 'S', 1);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (3, 'Par', 80.0, 2.20, 'N', 2);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (4, 'Impar', 95.0, 2.00, 'N', 2);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (5, 'Par', 110.0, 2.80, 'S', 3);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (6, 'Impar', 70.5, NULL, 'N', 3);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (7, 'Par', 60.0, 1.80, 'N', 4);

INSERT INTO Trecho_Calcada (id_trecho, Lado, Extensao_Metros, Largura_Metros, Possui_Rampa, id_logradouro)
VALUES (8, 'Impar', 150.0, 3.50, 'S', 5);

COMMIT;


-- TIPO OCORRÊNCIA

INSERT INTO Tipo_Ocorrencia (id_tipo, Nome, Descricao, Gravidade_Padrao)
VALUES (1, 'Buraco na calcada', 'Buraco ou afundamento que impede ou torna perigosa a passagem', 4);

INSERT INTO Tipo_Ocorrencia (id_tipo, Nome, Descricao, Gravidade_Padrao)
VALUES (2, 'Degrau sem rampa', 'Desnivel que impede a passagem de cadeira de rodas ou carrinho', 4);

INSERT INTO Tipo_Ocorrencia (id_tipo, Nome, Descricao, Gravidade_Padrao)
VALUES (3, 'Obstrucao por objeto', 'Mesas, cacambas, veiculos ou outros objetos bloqueando a calcada', 3);

INSERT INTO Tipo_Ocorrencia (id_tipo, Nome, Descricao, Gravidade_Padrao)
VALUES (4, 'Piso irregular', 'Piso solto, quebrado ou com desniveis pequenos', 2);

INSERT INTO Tipo_Ocorrencia (id_tipo, Nome, Descricao, Gravidade_Padrao)
VALUES (5, 'Falta de iluminacao', 'Poste apagado ou trecho sem iluminacao a noite', 3);

COMMIT;

-- OCORRÊNCIA

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (1, 'Buraco grande no meio da calcada', DATE '2026-09-10', 'RESOLVIDA', DATE '2026-09-24', 3, 2, 1);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (2, 'Degrau alto na entrada de uma loja, sem rampa', DATE '2026-09-12', 'ABERTA', NULL, 4, 3, 2);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (3, 'Mesas de um bar ocupando toda a largura da calcada', DATE '2026-09-15', 'RESOLVIDA', DATE '2026-09-18', 1, 1, 3);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (4, 'Pedras soltas e pequenos desniveis', DATE '2026-09-20', 'EM_ANALISE', NULL, 3, 6, 4);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (5, 'Poste apagado, trecho muito escuro a noite', DATE '2026-10-01', 'ABERTA', NULL, 5, 5, 5);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (6, 'Buraco proximo ao ponto de onibus', DATE '2026-10-03', 'RESOLVIDA', DATE '2026-10-20', 4, 2, 1);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (7, 'Cacamba de entulho parada sobre a calcada', DATE '2026-10-05', 'EM_ANALISE', NULL, 8, 4, 3);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (8, 'Piso solto perto do cruzamento', DATE '2026-10-08',  'ABERTA', NULL, 2, 3, 4);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (9, 'Rampa da esquina com degrau no final', DATE '2026-10-12', 'ABERTA', NULL, 1, 6, 2);

INSERT INTO Ocorrencia (id_ocorrencia, Descricao, Data_Registro, Status, Data_Resolucao, id_trecho, id_usuario, id_tipo)
VALUES (10, 'Buraco com agua acumulada', DATE '2026-10-15', 'RESOLVIDA', DATE '2026-10-30', 5, 1, 1);

COMMIT;

-- CONFIRMAÇÃO OCORRÊNCIA

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (1, DATE '2026-09-15', 'S', 1, 1);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (2, DATE '2026-09-18', 'S', 3, 1);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (3, DATE '2026-09-14', 'S', 5, 2);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (4, DATE '2026-09-30', 'S', 6, 2);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (5, DATE '2026-10-02', 'S', 2, 5);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (6, DATE '2026-09-22', 'S', 4, 4);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (7, DATE '2026-10-14', 'S', 1, 9);

INSERT INTO Confirmacao_Ocorrencia (id_confirmacao, Data_Confirmacao, Ainda_Existe, Usuario_id_usuario, Ocorrencia_id_ocorrencia)
VALUES (8, DATE '2026-09-19', 'N', 5, 3);

COMMIT;

-- Consulta 1: INNER JOIN - ocorrencias com o nome do tipo

SELECT o.id_ocorrencia,
       t.Nome AS tipo,
       t.Gravidade_Padrao AS gravidade,
       o.Status,
       o.Data_Registro
FROM Ocorrencia o
INNER JOIN Tipo_Ocorrencia t ON t.id_tipo = o.id_tipo
ORDER BY o.id_ocorrencia;

-- Consulta 2: INNER JOIN com GROUP BY - total de ocorrencias e media de dias para resolver, por tipo

SELECT t.Nome AS tipo,
       COUNT(o.id_ocorrencia) AS total_ocorrencias,
       ROUND(AVG(o.Data_Resolucao - o.Data_Registro), 1) AS media_dias_resolucao
FROM Tipo_Ocorrencia t
INNER JOIN Ocorrencia o ON o.id_tipo = t.id_tipo
GROUP BY t.Nome
ORDER BY total_ocorrencias DESC, t.Nome;

-- Consulta 3: LEFT OUTER JOIN com WHERE e ORDER BY - trechos sem rampa e suas ocorrencias

SELECT t.id_trecho,
       t.Lado,
       t.Extensao_Metros,
       o.id_ocorrencia,
       o.Status
FROM Trecho_Calcada t
LEFT OUTER JOIN Ocorrencia o ON o.id_trecho = t.id_trecho
WHERE t.Possui_Rampa = 'N'
ORDER BY t.id_trecho, o.Data_Registro;